from __future__ import annotations

import json
import re
import unicodedata
from datetime import datetime
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VAULT_ROOT = PROJECT_ROOT / "Prometeus"
WIKI_ROOT = VAULT_ROOT / "wiki"
OUTPUT_PATH = Path(__file__).resolve().with_name("graph-data.js")

WIKILINK_RE = re.compile(r"\[\[([^|\]]+)(?:\|([^\]]+))?\]\]")
MARKDOWN_LINK_RE = re.compile(r"(?<!!)\[[^\]]+\]\(([^)]+)\)")
H1_RE = re.compile(r"^#\s+(.+)$", re.MULTILINE)


def normalize(value: str) -> str:
    text = unicodedata.normalize("NFKD", value)
    text = "".join(ch for ch in text if not unicodedata.combining(ch))
    text = re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")
    return text


def parse_inline_list(value: str) -> list[str]:
    value = value.strip()
    if not (value.startswith("[") and value.endswith("]")):
        return []
    inner = value[1:-1].strip()
    if not inner:
        return []
    return [item.strip().strip('"').strip("'") for item in inner.split(",") if item.strip()]


def ensure_list(value: object) -> list[str]:
    if isinstance(value, list):
        return [str(item).strip() for item in value if str(item).strip()]
    if isinstance(value, str) and value.strip():
        return [value.strip()]
    return []


def parse_frontmatter(content: str) -> tuple[dict[str, object], str]:
    if not content.startswith("---\n"):
        return {}, content

    end = content.find("\n---\n", 4)
    if end == -1:
        return {}, content

    raw_frontmatter = content[4:end]
    body = content[end + 5 :]
    lines = raw_frontmatter.splitlines()

    data: dict[str, object] = {}
    current_key: str | None = None

    for raw_line in lines:
        line = raw_line.rstrip()
        if not line:
            continue

        if line.startswith("  - ") and current_key:
            current = data.setdefault(current_key, [])
            if isinstance(current, list):
                current.append(line[4:].strip())
            continue

        if ":" not in line:
            continue

        key, value = line.split(":", 1)
        key = key.strip()
        value = value.strip()
        current_key = key

        if not value:
            data[key] = []
        elif value.startswith("[") and value.endswith("]"):
            data[key] = parse_inline_list(value)
        else:
            data[key] = value.strip('"').strip("'")

    return data, body


def summarize_markdown(body: str) -> tuple[str, str]:
    lines = [line.rstrip() for line in body.splitlines()]
    clean_blocks: list[str] = []
    buffer: list[str] = []

    for line in lines:
        stripped = line.strip()
        if not stripped:
            if buffer:
                clean_blocks.append(" ".join(buffer).strip())
                buffer = []
            continue
        if stripped.startswith("#") or stripped.startswith("- ") or stripped.startswith("|") or stripped.startswith("```"):
            if buffer:
                clean_blocks.append(" ".join(buffer).strip())
                buffer = []
            continue
        buffer.append(stripped)

    if buffer:
        clean_blocks.append(" ".join(buffer).strip())

    summary = clean_blocks[0] if clean_blocks else ""
    teaser = " ".join(clean_blocks[:2]).strip()
    return summary[:260], teaser[:420]


def detect_kind(path: Path) -> str:
    if path.name == "_index.md":
        return "index"
    if path.name.lower() == "readme.md":
        return "guide"
    if path.parent.name == "concepts":
        return "concept"
    if path.parent.name == "topics":
        return "topic"
    if path.parent.name == "Notes":
        return "concept"
    if path.parent.name == "Atlas":
        return "topic"
    if path.parent.name == "Categories":
        return "index"
    if path.parent.name == "References":
        return "reference"
    if path.parent.name == "Maps":
        return "map"
    return "note"


def extract_title(path: Path, body: str, frontmatter: dict[str, object]) -> str:
    explicit = str(frontmatter.get("title") or "").strip()
    if explicit:
        return explicit

    h1_match = H1_RE.search(body)
    if h1_match:
        return h1_match.group(1).strip()

    if path.name == "_index.md":
        return f"{path.parent.name.replace('-', ' ').title()} Index"

    return path.stem.replace("-", " ").title()


def extract_links(text: str) -> list[str]:
    return [match.group(1).strip() for match in WIKILINK_RE.finditer(text)]


def extract_markdown_links(text: str, source_path: Path) -> list[str]:
    targets: list[str] = []
    for match in MARKDOWN_LINK_RE.finditer(text):
        raw_target = match.group(1).strip()
        if not raw_target or "://" in raw_target or raw_target.startswith("#"):
            continue

        clean_target = raw_target.split("#", 1)[0].split("?", 1)[0].strip()
        if not clean_target.endswith(".md"):
            continue

        try:
            absolute_target = (source_path.parent / clean_target).resolve()
            relative_target = absolute_target.relative_to(VAULT_ROOT)
        except Exception:
            continue

        if "raw" in relative_target.parts or relative_target.parts[0] != "wiki":
            continue
        targets.append(relative_target.as_posix())

    return targets


def collect_notes() -> list[dict[str, object]]:
    notes: list[dict[str, object]] = []

    for md_path in sorted(WIKI_ROOT.rglob("*.md")):
        relative = md_path.relative_to(VAULT_ROOT)
        if "raw" in relative.parts:
            continue
        if relative.parts[0] != "wiki":
            continue

        content = md_path.read_text(encoding="utf-8")
        frontmatter, body = parse_frontmatter(content)
        summary, teaser = summarize_markdown(body)

        title = extract_title(md_path, body, frontmatter)
        domain = str(frontmatter.get("domain") or (relative.parts[1] if len(relative.parts) > 1 else "wiki"))
        kind = detect_kind(md_path)
        tags = ensure_list(frontmatter.get("tags", []))

        related = extract_links("\n".join(ensure_list(frontmatter.get("related", []))))
        body_links = extract_links(body)
        markdown_links = extract_markdown_links(body, md_path)

        slug = normalize(str(relative.with_suffix("")))
        aliases = {
            normalize(title),
            normalize(md_path.stem),
            normalize(md_path.stem.replace("-", " ")),
        }
        aliases.update(normalize(alias) for alias in ensure_list(frontmatter.get("aliases", [])))

        if md_path.name == "_index.md":
            aliases.add(normalize(md_path.parent.name))
            aliases.add(normalize(relative.parent.as_posix()))
        if relative == Path("wiki") / "_index.md":
            aliases.add("wiki")
            aliases.add("wiki-index")
        if relative == Path("wiki") / "README.md":
            aliases.add("wiki-readme")

        notes.append(
            {
                "id": slug,
                "title": title,
                "domain": domain,
                "kind": kind,
                "description": str(frontmatter.get("description") or ""),
                "confidence": str(frontmatter.get("confidence") or ""),
                "created": str(frontmatter.get("created") or ""),
                "path": relative.as_posix(),
                "tags": tags,
                "aliases": sorted(alias for alias in aliases if alias),
                "relatedLinks": related,
                "bodyLinks": body_links,
                "pathLinks": markdown_links,
                "summary": summary,
                "teaser": teaser,
                "markdown": body.strip(),
            }
        )

    return notes


def build_graph_data() -> dict[str, object]:
    notes = collect_notes()

    alias_map: dict[str, str] = {}
    path_map: dict[str, str] = {}
    for note in notes:
        for alias in note["aliases"]:
            alias_map.setdefault(alias, note["id"])
        note_path = str(note["path"])
        note_path_without_suffix = note_path[:-3] if note_path.endswith(".md") else note_path
        path_map.setdefault(note_path, note["id"])
        path_map.setdefault(note_path_without_suffix, note["id"])
        if note_path.endswith("/_index.md"):
            parent_path = note_path[: -len("/_index.md")]
            path_map.setdefault(parent_path, note["id"])

    links: list[dict[str, str]] = []
    seen_edges: set[tuple[str, str]] = set()
    incoming: dict[str, int] = {note["id"]: 0 for note in notes}
    outgoing: dict[str, int] = {note["id"]: 0 for note in notes}

    for note in notes:
        targets: list[tuple[str, str]] = []
        targets.extend(("related", target) for target in note["relatedLinks"])
        targets.extend(("wikilink", target) for target in note["bodyLinks"])
        targets.extend(("markdown", target) for target in note["pathLinks"])

        for link_type, target in targets:
            if link_type == "markdown":
                target_id = path_map.get(target) or path_map.get(target[:-3] if target.endswith(".md") else target)
            else:
                target_id = alias_map.get(normalize(target))
            if not target_id or target_id == note["id"]:
                continue
            edge = (note["id"], target_id)
            if edge in seen_edges:
                continue
            seen_edges.add(edge)
            outgoing[note["id"]] += 1
            incoming[target_id] += 1
            links.append({"source": note["id"], "target": target_id, "type": link_type})

    for note in notes:
        note["outgoing"] = outgoing[note["id"]]
        note["incoming"] = incoming[note["id"]]
        note["degree"] = outgoing[note["id"]] + incoming[note["id"]]

    notes.sort(key=lambda item: (str(item["domain"]), str(item["kind"]), str(item["title"])))

    return {
        "generatedAt": datetime.now().isoformat(timespec="seconds"),
        "projectRoot": VAULT_ROOT.as_posix(),
        "nodeCount": len(notes),
        "linkCount": len(links),
        "nodes": notes,
        "links": links,
    }


def main() -> None:
    data = build_graph_data()
    js_payload = "window.WIKI_GRAPH_DATA = " + json.dumps(data, ensure_ascii=False, indent=2) + ";\n"
    OUTPUT_PATH.write_text(js_payload, encoding="utf-8")
    print(f"graph-data.js atualizado: {OUTPUT_PATH}")
    print(f"nodes={data['nodeCount']} links={data['linkCount']}")


if __name__ == "__main__":
    main()
