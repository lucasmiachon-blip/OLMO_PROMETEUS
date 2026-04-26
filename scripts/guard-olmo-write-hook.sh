#!/usr/bin/env bash
set -u

input_json="$(cat)"
HOOK_INPUT_JSON="$input_json" python3 - "$PWD" <<'PY'
import json
import os
import re
import sys


def response(decision, reason):
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": decision,
            "permissionDecisionReason": reason,
        }
    }, separators=(",", ":")))


def block(reason):
    response("deny", reason)


def ask(reason):
    response("ask", reason)


def add_text(value, sink):
    if value is None:
        return
    if isinstance(value, str):
        sink.append(value)
        return
    if isinstance(value, dict):
        for key, item in value.items():
            add_text(str(key), sink)
            add_text(item, sink)
        return
    if isinstance(value, (list, tuple)):
        for item in value:
            add_text(item, sink)
        return
    sink.append(str(value))


def tool_name(payload):
    for key in ("tool_name", "toolName", "name"):
        value = payload.get(key)
        if isinstance(value, str) and value.strip():
            return value
    return ""


def is_write_intent(payload, texts):
    if re.match(r"(?i)^(Write|Edit|MultiEdit|NotebookEdit)$", tool_name(payload)):
        return True
    write_re = re.compile(
        r"(?i)(\b(Set-Content|Add-Content|Out-File|Remove-Item|Move-Item|Copy-Item|New-Item|Rename-Item|Clear-Content)\b"
        r"|\b(git\s+(add|commit|push|checkout|reset|clean|mv|rm))\b"
        r"|\b(mkdir|ni|rm|del|erase|rmdir|rd|move|copy)\b|>>|(?<![<])>)"
    )
    return any(write_re.search(text) for text in texts)


def comparable(path):
    return path.rstrip("\\/").replace("\\", "/").lower()


def external_response(is_write, canonical_root, matched_name):
    if is_write:
        block(f"OLMO boundary guard: bloqueado. Write externo para sibling OLMO detectado ({matched_name}); use apenas {canonical_root}.")
    else:
        ask(f"OLMO boundary guard: leitura externa de sibling/legado OLMO detectada ({matched_name}). Peca permissao explicita do Lucas antes de ler; write continua bloqueado.")


input_json = os.environ.get("HOOK_INPUT_JSON", "")
if not input_json.strip():
    sys.exit(0)

try:
    payload = json.loads(input_json)
except Exception:
    block("OLMO boundary guard: hook input JSON invalido; fail-closed para evitar write externo.")
    sys.exit(0)

if not isinstance(payload, dict):
    payload = {"payload": payload}

texts = []
add_text(payload, texts)
write = is_write_intent(payload, texts)

canonical_name = "OLMO_PROMETEUS"
repo_root = os.path.realpath(sys.argv[1])
canonical_roots = {
    comparable(f"C:\\Dev\\Projetos\\{canonical_name}"),
    comparable(repo_root),
}

windows_re = re.compile(r"(?i)C:\\Dev\\Projetos\\OLMO[A-Za-z0-9_-]*")
linux_parent = os.path.dirname(repo_root).replace("\\", "/").rstrip("/")
linux_re = re.compile(r"(?i)" + re.escape(linux_parent) + r"/OLMO[A-Za-z0-9_-]*")
relative_re = re.compile(r"(?i)(^|[\s`\"'])\.\.[\\/]+(OLMO[A-Za-z0-9_-]*)")

for text in texts:
    normalized_windows = text.replace("/", "\\")
    normalized_unix = text.replace("\\", "/")

    for match in windows_re.finditer(normalized_windows):
        matched_root = match.group(0)
        if comparable(matched_root) in canonical_roots:
            continue
        external_response(write, repo_root, os.path.basename(matched_root.replace("\\", "/")))
        sys.exit(0)

    for match in linux_re.finditer(normalized_unix):
        matched_root = match.group(0)
        if comparable(matched_root) in canonical_roots:
            continue
        external_response(write, repo_root, os.path.basename(matched_root))
        sys.exit(0)

    for match in relative_re.finditer(normalized_windows):
        matched_name = match.group(2)
        if matched_name.lower() == canonical_name.lower():
            continue
        external_response(write, repo_root, matched_name)
        sys.exit(0)

sys.exit(0)
PY
