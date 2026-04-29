#!/usr/bin/env bash
set -u

strict=0
[[ "${1:-}" == "--strict" || "${1:-}" == "-Strict" ]] && strict=1

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "${root}" || exit 1

failures=()
warnings=()

ok() { printf '[OK] %s\n' "$1"; }
warn() { warnings+=("$1"); printf '[WARN] %s\n' "$1"; }
fail() { failures+=("$1"); printf '[FAIL] %s\n' "$1"; }
has_cmd() { command -v "$1" >/dev/null 2>&1; }

require_file() {
  [[ -f "$1" ]] && ok "file exists: $1" || fail "missing file: $1"
}

require_text() {
  local file="$1" pattern="$2" label="$3"
  if grep -Eq "$pattern" "$file"; then
    ok "$label"
  else
    fail "missing text for $label in $file"
  fi
}

if [[ "$(basename "$root")" == "OLMO_PROMETEUS" ]]; then
  ok "repo root is OLMO_PROMETEUS"
else
  fail "unexpected repo root: $root"
fi

legacy_root="$(dirname "$root")/OLMO_ROADMAP"
[[ -e "$legacy_root" ]] && fail "legacy workspace root exists and can attract stale sessions: $legacy_root" || ok "legacy workspace root absent"

required_files=(
  AGENTS.md CLAUDE.md CODEX.md GEMINI.md PROJECT_CONTRACT.md VALUES.md README.md TREE.md
  biome.json
  lab/wiki-graph-lab/pyproject.toml lab/wiki-graph-lab/uv.lock
  .gitignore .claudeignore .github/workflows/self-evolution.yml
  scripts/check.sh scripts/evolve.sh scripts/integrity.sh scripts/install-stack.sh scripts/simulate-ci.sh scripts/guard-olmo-write-hook.sh scripts/test-olmo-boundary-guard.sh scripts/doctor-github-remote.sh
  shadow/FOUNDATION.md shadow/HANDOFF.md shadow/AGENT-MODULES.md shadow/HYGIENE.md
  shadow/SOTA-DECISIONS.md shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md
  shadow/GITHUB-REMOTE-WSL.md
  shadow/DATA-CLASSIFICATION.md shadow/PHI-CHECKLIST.md shadow/THREAT-MODEL.md shadow/INCIDENT-LOG.md
  shadow/INCORPORATION-LOG.md shadow/WORK-LANES.md shadow/EMAIL-DIGEST-4P.md shadow/STUDY-TRACK-DONE.md
  shadow/EVIDENCE-LOG.md shadow/AGENT-USAGE.md
  internal/evolution/backlog.json internal/evolution/risk-register.json internal/evolution/review.json
  Prometeus/README.md Prometeus/wiki/Home.md
  Prometeus/wiki/Atlas/Second\ Brain\ Atlas.md
  Prometeus/wiki/Atlas/Graph\ Operating\ System.md
  Prometeus/wiki/Atlas/Knowledge\ Lifecycle.md
  Prometeus/wiki/Maps/Prometeus.canvas
  Prometeus/wiki/Categories/Prometeus\ Wiki.md
  Prometeus/wiki/Notes/Workspace\ Boundary.md
  Prometeus/wiki/Notes/Foundation\ Harness.md
  Prometeus/wiki/Notes/SOTA\ Research\ Gate.md
  Prometeus/wiki/Notes/Agent\ Module\ Encapsulation.md
  Prometeus/wiki/References/Kepano\ and\ Karpathy\ Principles.md
  Prometeus/.obsidian/app.json Prometeus/.obsidian/core-plugins.json Prometeus/.obsidian/graph.json
  Prometeus/.obsidian/snippets/prometeus-visuals.css
)

for file in "${required_files[@]}"; do
  require_file "$file"
done

if [[ -f .claude/settings.local.json ]]; then
  jq empty .claude/settings.local.json >/dev/null 2>&1 && ok "Claude local settings JSON parses" || fail "invalid Claude local settings JSON"
else
  warn "Claude local OLMO boundary guard not active: missing .claude/settings.local.json"
fi

"${root}/scripts/evolve.sh" check
[[ $? -eq 0 ]] && ok "self-evolution executable passes" || fail "self-evolution executable failed"

bash "${root}/scripts/integrity.sh"
[[ $? -eq 0 ]] && ok "integrity executable passes" || fail "integrity executable failed"

"${root}/scripts/test-olmo-boundary-guard.sh"
[[ $? -eq 0 ]] && ok "OLMO boundary guard tests pass" || fail "OLMO boundary guard tests failed"

if [[ -f lab/wiki-graph-lab/pyproject.toml ]]; then
  if command -v ruff >/dev/null 2>&1; then
    if ruff check lab/wiki-graph-lab/ >/tmp/prometeus-ruff.log 2>&1; then
      ok "ruff lint clean: lab/wiki-graph-lab"
    else
      fail "ruff lint failures: lab/wiki-graph-lab (see /tmp/prometeus-ruff.log)"
    fi
  else
    warn "ruff not installed; skipping Python lint"
  fi
fi

if [[ -f biome.json ]]; then
  if command -v biome >/dev/null 2>&1; then
    if biome check --no-errors-on-unmatched . >/tmp/prometeus-biome.log 2>&1; then
      ok "biome check clean"
    else
      fail "biome check failures (see /tmp/prometeus-biome.log)"
    fi
  else
    warn "biome not installed; skipping JS/JSON lint"
  fi
fi

for file in internal/evolution/backlog.json internal/evolution/risk-register.json internal/evolution/review.json Prometeus/.obsidian/app.json Prometeus/.obsidian/appearance.json Prometeus/.obsidian/core-plugins.json Prometeus/.obsidian/daily-notes.json Prometeus/.obsidian/graph.json Prometeus/.obsidian/templates.json Prometeus/wiki/Maps/Prometeus.canvas; do
  if [[ -f "$file" ]]; then
    jq empty "$file" >/dev/null 2>&1 && ok "JSON parses: $file" || fail "invalid JSON: $file"
  fi
done

for dir in .agents .codex .gemini agents subagents skills hooks playground .claude/hooks .claude/commands; do
  [[ -d "$dir" ]] && fail "forbidden scaffold exists: $dir" || ok "forbidden scaffold absent: $dir"
done

for pattern in '.claude/settings.local.json' '.codex' 'private-learning/' 'Prometeus/.obsidian/workspace*.json' 'Prometeus/.obsidian/cache/' 'Prometeus/.obsidian/plugins/' 'Prometeus/wiki/Clippings/*' '!Prometeus/wiki/Clippings/README.md' 'Prometeus/wiki/Daily/*' '!Prometeus/wiki/Daily/README.md' 'Prometeus/wiki/Attachments/*' '!Prometeus/wiki/Attachments/README.md' 'node_modules/' '.venv/'; do
  grep -Fxq "$pattern" .gitignore && ok "ignore pattern present in .gitignore: $pattern" || fail "missing .gitignore pattern: $pattern"
  grep -Fxq "$pattern" .claudeignore && ok "ignore pattern present in .claudeignore: $pattern" || fail "missing .claudeignore pattern: $pattern"
done

require_text AGENTS.md '^## SOTA Research Gate$' 'AGENTS.md SOTA gate'
require_text AGENTS.md '^## Memoria$' 'AGENTS.md memory'
require_text VALUES.md '^## Valores$' 'VALUES.md values'
require_text VALUES.md '^## Objetivos$' 'VALUES.md objectives'
require_text VALUES.md '^## Gap Lens$' 'VALUES.md gap lens'
require_text shadow/HANDOFF.md '^## Migration Readiness$' 'handoff migration readiness'
require_text shadow/WORK-LANES.md '^## Promotion gate$' 'work lanes promotion gate'
require_text shadow/SOTA-DECISIONS.md '^## Canonical Linux workspace with Windows UI fallback \(2026-04-26\)$' 'canonical Linux workspace with Windows UI fallback'
require_text shadow/SOTA-DECISIONS.md '^## Exclusive executor rule \(2026-04-26\)$' 'exclusive executor rule'
require_text shadow/SOTA-DECISIONS.md '^## Privacy guard minimum \(2026-04-26\)$' 'SOTA privacy guard'
require_text shadow/DATA-CLASSIFICATION.md '^## Classes$' 'data classification classes'
require_text shadow/PHI-CHECKLIST.md '^## Stop checklist$' 'PHI stop checklist'
require_text shadow/THREAT-MODEL.md '^## Ameacas$' 'threat model threats'
require_text shadow/INCIDENT-LOG.md '^## Entradas$' 'incident log entries'
require_text shadow/GITHUB-REMOTE-WSL.md '^## Procedimento$' 'GitHub WSL remote procedure'

if has_cmd rg; then
  secret_scan_cmd=(rg -n --hidden --glob '!.git/**' --glob '!scripts/check.sh' --glob '!private-learning/**' --glob '!Prometeus/wiki/Clippings/**' --glob '!Prometeus/wiki/Daily/**' --glob '!Prometeus/wiki/Attachments/**' 'AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|BEGIN RSA PRIVATE KEY' .)
else
  warn "rg not installed; using grep fallback for secret scan"
  secret_scan_cmd=(grep -RInE --exclude-dir=.git --exclude=check.sh 'AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|BEGIN RSA PRIVATE KEY' .)
fi

if "${secret_scan_cmd[@]}" >/tmp/prometeus-secret-scan.txt; then
  fail "no obvious secret strings found: $(wc -l </tmp/prometeus-secret-scan.txt) finding(s)"
else
  ok "no obvious secret strings"
fi

if has_cmd rg; then
  olmo_path_cmd=(rg -n 'C:\\Dev\\Projetos\\OLMO|/mnt/c/Dev/Projetos/OLMO' scripts shadow AGENTS.md README.md TREE.md PROJECT_CONTRACT.md)
else
  warn "rg not installed; using grep fallback for OLMO path scan"
  olmo_path_cmd=(grep -RInE 'C:\\Dev\\Projetos\\OLMO|/mnt/c/Dev/Projetos/OLMO' scripts shadow AGENTS.md README.md TREE.md PROJECT_CONTRACT.md)
fi

if "${olmo_path_cmd[@]}" >/tmp/prometeus-olmo-paths.txt; then
  ok "OLMO path references stay documented"
else
  ok "no protected OLMO path references outside boundary docs"
fi

if [[ -f Prometeus/wiki/Maps/Prometeus.canvas ]]; then
  while IFS= read -r path; do
    path="${path//$'\r'/}"
    [[ -z "$path" ]] && continue
    [[ -f "Prometeus/$path" ]] && ok "canvas file reference resolves: $path" || fail "canvas file reference missing: $path"
  done < <(jq -r '.nodes[]? | select(.type == "file") | .file' Prometeus/wiki/Maps/Prometeus.canvas)
fi

status="$(git status --short)"
if [[ -n "$status" ]]; then
  if [[ "$strict" -eq 1 ]]; then
    fail "git working tree is not clean"
  else
    warn "git working tree has changes"
  fi
else
  ok "git working tree is clean"
fi

if ((${#failures[@]} > 0)) || { [[ "$strict" -eq 1 ]] && ((${#warnings[@]} > 0)); }; then
  printf 'Harness failed with %s issue(s), %s warning(s).\n' "${#failures[@]}" "${#warnings[@]}"
  exit 1
fi

printf 'Harness passed with %s warning(s).\n' "${#warnings[@]}"
