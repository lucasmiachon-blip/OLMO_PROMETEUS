#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$root" || exit 1

failures=()
warnings=()

ok() { printf '[OK] %s\n' "$1"; }
warn() { warnings+=("$1"); printf '[WARN] %s\n' "$1"; }
fail() { failures+=("$1"); printf '[FAIL] %s\n' "$1"; }

require_text() {
  local file="$1" pattern="$2" label="$3"
  if [[ ! -f "$file" ]]; then
    fail "missing file for $label: $file"
    return
  fi
  if grep -Eq "$pattern" "$file"; then
    ok "$label"
  else
    fail "missing text for $label in $file"
  fi
}

check_script_syntax() {
  local file
  while IFS= read -r file; do
    if bash -n "$file" >/dev/null 2>&1; then
      ok "bash syntax: $file"
    else
      fail "bash syntax error: $file"
    fi
  done < <(find scripts -maxdepth 1 -type f -name '*.sh' | sort)
}

check_hook_targets() {
  local settings=".claude/settings.local.json"
  local command relative

  if [[ ! -f "$settings" ]]; then
    warn "skip hook target integrity: missing $settings"
    return
  fi
  if ! jq empty "$settings" >/dev/null 2>&1; then
    fail "invalid JSON: $settings"
    return
  fi

  while IFS= read -r command; do
    [[ -z "$command" || "$command" == "null" ]] && continue
    if [[ "$command" =~ \$CLAUDE_PROJECT_DIR/([^[:space:]]+) ]]; then
      relative="${BASH_REMATCH[1]}"
      relative="${relative%%\"*}"
      relative="${relative%%\'*}"
      if [[ -f "$relative" ]]; then
        ok "hook target exists: $relative"
        if [[ "$relative" == *.sh ]]; then
          bash -n "$relative" >/dev/null 2>&1 && ok "hook target syntax: $relative" || fail "hook target syntax error: $relative"
        fi
      else
        fail "hook target missing: $relative"
      fi
    fi
  done < <(jq -r '.hooks? // {} | to_entries[] | .value[]? | .hooks[]? | .command? // empty' "$settings")
}

check_backlog_view_sync() {
  local id
  if [[ ! -f internal/evolution/backlog.json || ! -f shadow/BACKLOG.md ]]; then
    fail "backlog sync inputs missing"
    return
  fi

  while IFS= read -r id; do
    [[ -z "$id" ]] && continue
    if grep -Fq "\`$id\`" shadow/BACKLOG.md; then
      ok "backlog markdown references active item: $id"
    else
      fail "backlog markdown missing active item: $id"
    fi
  done < <(jq -r '.items[] | select(.status == "next" or .status == "planned") | .id' internal/evolution/backlog.json)
}

check_ev_b5_contract() {
  require_text internal/evolution/backlog.json '"id": "EV-B5"' 'EV-B5 exists in canonical backlog'
  require_text shadow/BACKLOG.md 'EV-B5' 'EV-B5 appears in markdown backlog'
  require_text shadow/SOTA-DECISIONS.md '^## OLMO/OLMO_GENESIS selective adaptation scan \(2026-04-27\)$' 'OLMO/GENESIS selective adaptation decision'
  require_text shadow/EVIDENCE-LOG.md 'OLMO_GENESIS.*EV-B5|EV-B5.*OLMO_GENESIS' 'EV-B5 evidence entry'
}

check_values_contract() {
  require_text VALUES.md '^## Valores$' 'values contract has values'
  require_text VALUES.md '^## Objetivos$' 'values contract has objectives'
  require_text VALUES.md '^## OLMO como piso$' 'values contract treats OLMO as floor'
  require_text VALUES.md '^## Gap Lens$' 'values contract has gap lens'
  require_text shadow/SOTA-DECISIONS.md '^## OLMO plans as maturity floor \(2026-04-27\)$' 'OLMO plans maturity floor decision'
  require_text PROJECT_CONTRACT.md 'VALUES.md' 'project contract references values'
  require_text AGENTS.md 'VALUES.md' 'agent contract references values'
}

check_no_external_write_targets() {
  if rg -n '(^|[^A-Za-z0-9_])(cp|mv|rsync|tee|cat|python|node|bash|sh)[^`\n]*(/mnt/c/Dev/Projetos/OLMO|C:\\Dev\\Projetos\\OLMO)' scripts >/tmp/prometeus-integrity-external-write.txt; then
    fail "script may write or execute against protected OLMO path: $(wc -l </tmp/prometeus-integrity-external-write.txt) finding(s)"
  else
    ok "scripts do not target protected OLMO paths"
  fi
}

check_script_syntax
check_hook_targets
check_backlog_view_sync
check_ev_b5_contract
check_values_contract
check_no_external_write_targets

if ((${#failures[@]} > 0)); then
  printf 'Integrity check failed with %s issue(s), %s warning(s).\n' "${#failures[@]}" "${#warnings[@]}"
  exit 1
fi

printf 'Integrity check passed with %s warning(s).\n' "${#warnings[@]}"
