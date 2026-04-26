#!/usr/bin/env bash
set -u

mode="${1:-check}"
if [[ "${mode}" == "-Mode" ]]; then
  mode="${2:-check}"
fi

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "${root}" || exit 1

failures=()
warnings=()

ok() { printf '[OK] %s\n' "$1"; }
warn() { warnings+=("$1"); printf '[WARN] %s\n' "$1"; }
fail() { failures+=("$1"); printf '[FAIL] %s\n' "$1"; }

require_file() {
  [[ -f "$1" ]] && ok "file exists: $1" || fail "missing file: $1"
}

for file in \
  scripts/evolve.sh \
  scripts/check.sh \
  internal/evolution/backlog.json \
  internal/evolution/risk-register.json \
  internal/evolution/review.json \
  .github/workflows/self-evolution.yml; do
  require_file "$file"
done

if [[ "$(basename "$root")" != "OLMO_PROMETEUS" ]]; then
  fail "unexpected repo root: $root"
fi

for file in internal/evolution/backlog.json internal/evolution/risk-register.json internal/evolution/review.json; do
  if [[ -f "$file" ]]; then
    jq empty "$file" >/dev/null 2>&1 || fail "invalid JSON: $file"
  fi
done

if [[ -f internal/evolution/backlog.json ]]; then
  schema="$(jq -r '.schema // empty' internal/evolution/backlog.json)"
  [[ "$schema" == "prometeus.evolution.backlog.v1" ]] || fail "unexpected backlog schema: $schema"

  next_count="$(jq '[.items[] | select(.status == "next")] | length' internal/evolution/backlog.json)"
  if [[ "$next_count" -eq 0 ]]; then
    fail "self-evolution backlog must declare exactly one next item"
  elif [[ "$next_count" -gt 1 ]]; then
    fail "self-evolution backlog has more than one next item"
  fi

  missing_required="$(jq -r '
    .items[]
    | select((.id // "") == "" or (.batch // "") == "" or (.status // "") == "" or (.area // "") == "" or (.problem // "") == "" or (.trigger // "") == "" or (.owner // "") == "" or (.risk // "") == "" or (.rollback // "") == "" or (.negative_criterion // "") == "" or (.next_action // "") == "")
    | .id // "unknown"
  ' internal/evolution/backlog.json)"
  [[ -z "$missing_required" ]] || fail "backlog items missing required fields: ${missing_required//$'\n'/, }"
fi

if [[ -f internal/evolution/risk-register.json ]]; then
  schema="$(jq -r '.schema // empty' internal/evolution/risk-register.json)"
  [[ "$schema" == "prometeus.evolution.risk-register.v1" ]] || fail "unexpected risk register schema: $schema"

  critical_open="$(jq -r '[.risks[] | select(.severity == "critical" and .status == "open") | .id] | join(", ")' internal/evolution/risk-register.json)"
  [[ -z "$critical_open" ]] || warn "critical risk remains open: $critical_open"
fi

if [[ -f internal/evolution/review.json ]]; then
  schema="$(jq -r '.schema // empty' internal/evolution/review.json)"
  [[ "$schema" == "prometeus.evolution.review.v1" ]] || fail "unexpected review schema: $schema"
  jq -e '.cadence and .last_review and .next_review and (.triggers | length > 0) and (.definition_of_ready | length > 0) and (.definition_of_done | length > 0)' internal/evolution/review.json >/dev/null 2>&1 || fail "review missing required fields"
fi

if [[ -f .github/workflows/self-evolution.yml ]]; then
  grep -Eq '^[[:space:]]*schedule:' .github/workflows/self-evolution.yml || fail "self-evolution workflow must run on schedule"
  grep -Eq '^[[:space:]]*workflow_dispatch:' .github/workflows/self-evolution.yml || fail "self-evolution workflow must support workflow_dispatch"
  grep -Eq '^[[:space:]]*contents:[[:space:]]*read[[:space:]]*$' .github/workflows/self-evolution.yml || fail "self-evolution workflow must use permissions.contents: read"
  if grep -Eiq '\b(git[[:space:]]+push|git[[:space:]]+commit|gh[[:space:]]+issue|gh[[:space:]]+pr|rm[[:space:]]+-rf|tee[[:space:]]+-a)\b' .github/workflows/self-evolution.yml; then
    fail "self-evolution workflow must not write, commit, push, or create GitHub objects"
  fi
fi

if [[ "$mode" == "next" ]]; then
  jq -r '.items[] | select(.status == "next") | "id: \(.id)\nbatch: \(.batch)\narea: \(.area)\nproblem: \(.problem)\nnext_action: \(.next_action)"' internal/evolution/backlog.json
  exit 0
fi

if [[ "$mode" == "json" ]]; then
  jq '{backlog: input, risks: input}' internal/evolution/backlog.json internal/evolution/risk-register.json
  exit 0
fi

if ((${#failures[@]} > 0)); then
  printf 'Self-evolution check failed with %s issue(s), %s warning(s).\n' "${#failures[@]}" "${#warnings[@]}"
  exit 1
fi

ok "self-evolution loop passes"
