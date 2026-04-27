#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$root" || exit 1

failures=()
warnings=()

ok() { printf '[OK] %s\n' "$1"; }
warn() { warnings+=("$1"); printf '[WARN] %s\n' "$1"; }
fail() { failures+=("$1"); printf '[FAIL] %s\n' "$1"; }
has_cmd() { command -v "$1" >/dev/null 2>&1; }

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
  local id updated
  if [[ ! -f internal/evolution/backlog.json || ! -f shadow/BACKLOG.md ]]; then
    fail "backlog sync inputs missing"
    return
  fi

  updated="$(jq -r '.updated // empty' internal/evolution/backlog.json)"
  if [[ -n "$updated" && "$updated" != "null" ]]; then
    if grep -Fq "sincronizado $updated" shadow/BACKLOG.md; then
      ok "backlog markdown sync date matches JSON: $updated"
    else
      fail "backlog markdown sync date does not match JSON updated date: $updated"
    fi
  else
    fail "backlog JSON missing updated date"
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
  require_text shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md '^## Producer-Consumer Matrix$' 'producer-consumer matrix exists'
  require_text shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md 'Regra T3: gate novo sem linha nesta matriz fica bloqueado' 'producer-consumer gate rule'
  require_text internal/evolution/backlog.json 'T4 applied: manter sync leve entre internal/evolution/backlog.json e shadow/BACKLOG.md' 'EV-B5 T4 applied in JSON'
  require_text shadow/BACKLOG.md 'T4 applied sync leve backlog JSON/Markdown' 'EV-B5 T4 applied in markdown'
  require_text internal/evolution/backlog.json 'T5 applied: converter erro observado em detector/teste antes de chamar antifragile' 'EV-B5 T5 applied in JSON'
  require_text shadow/BACKLOG.md 'T5 applied erro observado vira detector/teste antes de claim antifragile' 'EV-B5 T5 applied in markdown'
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

check_adr_index() {
  local id
  require_text docs/adr/README.md '^## Indice$' 'ADR index exists'
  for id in 0001 0002 0003 0004 0005 0006 0007; do
    require_text docs/adr/README.md "$id" "ADR index references $id"
  done
  require_text docs/adr/0002-exclusive-executor-rule.md '^# 0002' 'ADR 0002 exists'
  require_text docs/adr/0003-privacy-guard-minimum.md '^# 0003' 'ADR 0003 exists'
  require_text docs/adr/0004-procedure-before-agent-runtime.md '^# 0004' 'ADR 0004 exists'
  require_text docs/adr/0005-producer-consumer-gates.md '^# 0005' 'ADR 0005 exists'
  require_text docs/adr/0007-multimodel-sota-efficacy.md '^# 0007' 'ADR 0007 exists'
}

check_antifragile_contract() {
  require_text shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md 'erro observado vira detector, regra ou teste de regressao' 'antifragile requires detector/rule/test'
  require_text VALUES.md 'Falha so vira aprendizado quando reduz repeticao via teste, detector, regra ou backlog com criterio negativo' 'values antifragile is verifiable'
  require_text shadow/KBP.md 'KBP-11 \| Antifragile narrativo sem detector/regra/teste' 'KBP records narrative antifragile ban'
  require_text shadow/EVIDENCE-LOG.md 'producer-consumer-gate.*T3 aplicado|T3 aplicado.*producer-consumer-gate' 'producer-consumer evidence exists'
}

check_stale_candidate_evidence() {
  local today_epoch procedure last_date last_epoch age

  if ! today_epoch="$(date -u +%s 2>/dev/null)"; then
    warn "skip stale evidence check: date unavailable"
    return
  fi

  while IFS= read -r procedure; do
    [[ -z "$procedure" ]] && continue
    last_date="$(
      awk -F'|' -v procedure="$procedure" '
        $0 ~ /^\|[[:space:]]*[0-9]{4}-[0-9]{2}-[0-9]{2}[[:space:]]*\|/ {
          date=$2
          proc=$3
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", date)
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", proc)
          if (proc == procedure) {
            print date
          }
        }
      ' shadow/EVIDENCE-LOG.md | sort | tail -n 1
    )"

    if [[ -z "$last_date" ]]; then
      warn "candidate/operational procedure has no evidence entry: $procedure"
      continue
    fi

    if ! last_epoch="$(date -u -d "$last_date" +%s 2>/dev/null)"; then
      warn "skip stale evidence age for $procedure: invalid date $last_date"
      continue
    fi

    age=$(( (today_epoch - last_epoch) / 86400 ))
    if [[ "$age" -gt 21 ]]; then
      warn "candidate/operational procedure evidence is stale: $procedure last used $last_date (${age}d)"
    else
      ok "candidate/operational procedure evidence recent: $procedure ($last_date)"
    fi
  done < <(
    awk -F'|' '
      $0 ~ /^\| `[^`]+` / && ($5 ~ /`candidate`/ || $5 ~ /`operational`/) {
        name=$2
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
        gsub(/`/, "", name)
        print name
      }
    ' shadow/AGENT-MODULES.md | sort -u
  )
}

check_no_external_write_targets() {
  local pattern='(^|[^A-Za-z0-9_])(cp|mv|rsync|tee|cat|python|node|bash|sh)[^`\n]*(/mnt/c/Dev/Projetos/OLMO|C:\\Dev\\Projetos\\OLMO)'

  if has_cmd rg; then
    external_write_cmd=(rg -n "$pattern" scripts)
  else
    warn "rg not installed; using grep fallback for external write target scan"
    external_write_cmd=(grep -RInE "$pattern" scripts)
  fi

  if "${external_write_cmd[@]}" >/tmp/prometeus-integrity-external-write.txt; then
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
check_adr_index
check_antifragile_contract
check_stale_candidate_evidence
check_no_external_write_targets

if ((${#failures[@]} > 0)); then
  printf 'Integrity check failed with %s issue(s), %s warning(s).\n' "${#failures[@]}" "${#warnings[@]}"
  exit 1
fi

printf 'Integrity check passed with %s warning(s).\n' "${#warnings[@]}"
