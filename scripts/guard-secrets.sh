#!/usr/bin/env bash
# guard-secrets.sh — PreToolUse(Bash): bloqueia git commit/add com staged blobs contendo secrets.
# Source: adaptado de OLMO `.claude/hooks/guard-secrets.sh` (read-only, autorizado 2026-04-26).
# Melhoras: simplified output; mantem patterns chave; symlink staged block; .env file staged block.
# Wiring: opt-in via `.claude/settings.local.json` PreToolUse matcher "Bash". Nao habilitado automaticamente.
# Exit 2 = BLOCK; exit 0 = allow. Output: erro humano-legivel.

set -euo pipefail

INPUT=$(cat 2>/dev/null || echo '{}')

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

if ! echo "$CMD" | grep -qE 'git[[:space:]]+(commit|add)'; then
  exit 0
fi

PATTERNS=(
  'sk-[a-zA-Z0-9]{20,}'
  'sk-ant-[a-zA-Z0-9_\-]{20,}'
  'Bearer [a-zA-Z0-9_\-\.]{20,}'
  '-----BEGIN [A-Z]+'
  'AKIA[0-9A-Z]{16}'
  'ghp_[a-zA-Z0-9]{36}'
  'gho_[a-zA-Z0-9]{36}'
  'github_pat_[a-zA-Z0-9_]{20,}'
  'ntn_[a-zA-Z0-9]{40,}'
  'secret_[a-zA-Z0-9]{40,}'
  'AIza[a-zA-Z0-9_\-]{35}'
  'xox[bpars]-[a-zA-Z0-9\-]{10,}'
  'sk_live_[a-zA-Z0-9]{20,}'
  'sk_test_[a-zA-Z0-9]{20,}'
  '(postgres|mysql|mongodb|redis)://[^[:space:]]+:[^[:space:]@]+@'
  '\b[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}\b'
)

STAGED=$(git diff --cached --name-only 2>/dev/null || true)
[ -z "$STAGED" ] && exit 0

FOUND=0
WARNINGS=""

while IFS= read -r file; do
  [ -z "$file" ] && continue

  if git ls-files -s "$file" 2>/dev/null | grep -q "^120"; then
    printf '{"error": "BLOQUEADO: symlink em staged files: %s"}\n' "$file"
    exit 2
  fi

  case "$file" in
    *.png|*.jpg|*.jpeg|*.gif|*.woff2|*.pdf|*.ico|*.zip|*.tar.gz) continue ;;
    .env.example|*/.env.example) continue ;;
  esac

  case "$file" in
    .env|.env.*|*/.env|*/.env.*)
      printf '{"error": "BLOQUEADO: .env staged: %s (use .env.example para templates)"}\n' "$file"
      exit 2
      ;;
  esac

  CONTENT=$(git show ":$file" 2>/dev/null || true)
  [ -z "$CONTENT" ] && continue

  for pattern in "${PATTERNS[@]}"; do
    if echo "$CONTENT" | grep -qE -- "$pattern" 2>/dev/null; then
      MATCH=$(echo "$CONTENT" | grep -nE -- "$pattern" 2>/dev/null | grep -vF '${' | head -3 || true)
      if [ -n "$MATCH" ]; then
        WARNINGS="${WARNINGS}\n[!] $file:\n${MATCH}\n"
        FOUND=1
      fi
    fi
  done
done <<< "$STAGED"

if [ "$FOUND" -eq 1 ]; then
  echo "guard-secrets: possiveis credenciais detectadas em staged files:"
  echo -e "$WARNINGS"
  echo "BLOQUEADO: remova as credenciais antes de commitar. Falsos positivos: ajuste pattern ou use \${VAR}."
  exit 2
fi

exit 0
