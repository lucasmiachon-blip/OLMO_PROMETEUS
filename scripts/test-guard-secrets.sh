#!/usr/bin/env bash
# test-guard-secrets.sh — valida regex patterns + comportamento end-to-end.
# Source: criado em B4 do plano happy-drifting-naur (2026-04-28).
# Wire: scripts/check.sh chama este teste em --strict.

set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
guard="${root}/scripts/guard-secrets.sh"
failures=()

fail() { failures+=("$1"); }

# Fixtures positivos por pattern (mesmo ordem que PATTERNS em guard-secrets.sh).
# Fixtures sao construidos em runtime via prefix+body para nao gravar
# tokens literais que tools de secret-scanning (GitHub, scout) interpretem
# como credenciais reais. Body e padding repetitivo de baixa entropia.
A36='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
A40='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
A20='AAAAAAAAAAAAAAAAAAAA'
A35='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
A16='AAAAAAAAAAAAAAAA'
# PEM header construido em runtime: source nao contem literal "-----BEGIN <UPPER>"
# para evitar self-reference com pattern em guard-secrets.sh.
PEM_PREFIX='-----BEGIN'
PEM_BODY=' RSA PRIVATE KEY-----'
positives=(
  "sk-${A20}"
  "sk-ant-${A20}"
  "Bearer ${A20}"
  "${PEM_PREFIX}${PEM_BODY}"
  "AKIA${A16}"
  "ghp_${A36}"
  "gho_${A36}"
  "github_pat_${A20}"
  "ntn_${A40}"
  "secret_${A40}"
  "AIza${A35}"
  'xoxb-AAAAAAAAAA'
  "sk_live_${A20}"
  "sk_test_${A20}"
  'postgres://user:pass@host/db'
  '123.456.789-01'
)

# Extrair PATTERNS array de guard-secrets.sh.
patterns=()
in_array=0
while IFS= read -r line; do
  if [[ "$line" == "PATTERNS=("* ]]; then in_array=1; continue; fi
  if (( in_array )); then
    [[ "$line" == ")" ]] && break
    pat="${line#  \'}"
    pat="${pat%\'}"
    patterns+=("$pat")
  fi
done < "$guard"

[[ "${#patterns[@]}" -eq "${#positives[@]}" ]] || fail "pattern count (${#patterns[@]}) != positive fixture count (${#positives[@]})"

for i in "${!patterns[@]}"; do
  if ! echo "${positives[$i]:-}" | grep -qE -- "${patterns[$i]}"; then
    fail "pattern $i (${patterns[$i]}) did not match positive: ${positives[$i]:-EMPTY}"
  fi
done

# Falsos positivos comuns que NAO podem disparar PHI/CPF.
phi_negatives=(
  'Silva'
  'Santos'
  'Joao da Silva'
  '1985-01-15'
  'Joao da Silva nasceu em 1985'
  'Maria dos Santos'
  '85.000.000'
  '00000000'
)
cpf_pattern='\b[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}\b'
for neg in "${phi_negatives[@]}"; do
  if echo "$neg" | grep -qE "$cpf_pattern"; then
    fail "CPF false positive on benign string: $neg"
  fi
done

# End-to-end: temp git repo + staged scenarios.
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
cd "$tmpdir"
git init -q
git config user.email test@test.local
git config user.name test
git checkout -q -b main 2>/dev/null || true

run_guard() {
  echo '{"tool_input":{"command":"git commit -m test"}}' | "$guard" >/dev/null 2>&1
}

# .env staged -> block.
echo 'KEY=value' > .env
git add .env
run_guard && fail ".env staged: expected block (exit 2), got allow"
git rm -fq .env >/dev/null

# .env.example staged -> allow.
echo 'KEY=template' > .env.example
git add .env.example
run_guard || rc=$?; rc=${rc:-0}
[[ "$rc" -eq 0 ]] || fail ".env.example: expected allow (exit 0), got $rc"
git rm -fq .env.example >/dev/null

# config.txt with synthetic github token -> block.
echo "token = \"ghp_${A36}\"" > config.txt
git add config.txt
run_guard && fail "github token: expected block (exit 2), got allow"
git rm -fq config.txt >/dev/null

# config.txt with synthetic CPF -> block.
echo 'paciente cpf 111.222.333-44' > note.txt
git add note.txt
run_guard && fail "CPF formatted: expected block (exit 2), got allow"
git rm -fq note.txt >/dev/null

# Clean note (no secret/PHI) -> allow.
echo 'todo: revisar amanha' > clean.txt
git add clean.txt
run_guard || rc=$?; rc=${rc:-0}
[[ "$rc" -eq 0 ]] || fail "clean note: expected allow (exit 0), got $rc"

cd "$root"

if (( ${#failures[@]} > 0 )); then
  printf '[FAIL] %s\n' "${failures[@]}"
  exit 1
fi

printf '[OK] guard-secrets tests pass (%d patterns + e2e fixtures)\n' "${#patterns[@]}"
