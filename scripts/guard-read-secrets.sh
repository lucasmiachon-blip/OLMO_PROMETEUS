#!/usr/bin/env bash
# guard-read-secrets.sh — PreToolUse(Read|Grep|Glob): bloqueia leitura/busca de secrets/credenciais.
# Source: adaptado de OLMO `.claude/hooks/guard-read-secrets.sh` (read-only, autorizado 2026-04-26).
# Melhoras: simplified jq pipeline; adiciona PHI-friendly path blocks (paciente_*, patient_*, phi_*); fail-closed em empty stdin.
# Wiring: opt-in via `.claude/settings.local.json` PreToolUse matcher "Read|Grep|Glob". Nao habilitado automaticamente.
# Exit 2 = BLOCK; exit 0 = allow. Output: JSON em stdout para PreToolUse.

set -euo pipefail

INPUT=$(cat 2>/dev/null || true)

if [ -z "$INPUT" ]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"guard-read-secrets: empty stdin — confirme leitura"}}\n'
  exit 0
fi

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null || echo "")

if [ "$TOOL_NAME" = "Grep" ]; then
  GREP_PATTERN=$(echo "$INPUT" | jq -r '.tool_input.pattern // ""' 2>/dev/null || echo "")
  if echo "$GREP_PATTERN" | grep -qiE '(BEGIN[[:space:]]+(RSA|PRIVATE|OPENSSH|EC)|AWS_SECRET|AWS_ACCESS_KEY|API[_-]TOKEN|GITHUB_TOKEN|PRIVATE_KEY=|GHCR_PAT|sk-ant-|sk_live_)'; then
    printf '{"error": "BLOQUEADO: Grep pattern contem credential keyword. Use leitura explicita do arquivo se autorizado."}\n'
    exit 2
  fi
fi

case "$TOOL_NAME" in
  Glob)
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.pattern // ""' 2>/dev/null | sed 's|\\|/|g')
    ;;
  *)
    FILE_PATH=$(echo "$INPUT" | jq -r '(.tool_input.file_path // .tool_input.path // "") | gsub("\\\\"; "/")' 2>/dev/null || echo "")
    ;;
esac

[ -z "$FILE_PATH" ] && exit 0

BASENAME=$(echo "$FILE_PATH" | sed 's|.*/||')

case "$BASENAME" in
  .env|.env.local|.env.production|.env.staging|.env.dev|.env.development)
    printf '{"error": "BLOQUEADO: %s contem credenciais. Use .env.example."}\n' "$BASENAME"
    exit 2
    ;;
  *.pem|*.key|*.p12|*.pfx|*.jks)
    printf '{"error": "BLOQUEADO: %s e material criptografico privado."}\n' "$BASENAME"
    exit 2
    ;;
  credentials.json|service-account*.json|*_secret*.json|*-secret*.json)
    printf '{"error": "BLOQUEADO: %s contem credenciais de servico."}\n' "$BASENAME"
    exit 2
    ;;
  id_rsa|id_ed25519|id_ecdsa|id_dsa)
    printf '{"error": "BLOQUEADO: %s e chave SSH privada."}\n' "$BASENAME"
    exit 2
    ;;
esac

if echo "$FILE_PATH" | grep -qE '(^|/)\.env(\.|$)'; then
  printf '{"error": "BLOQUEADO: arquivo .env contem credenciais."}\n'
  exit 2
fi

if echo "$FILE_PATH" | grep -qiE '(^|/)(paciente_|patient_|phi_|clinical_)[^/]+'; then
  printf '{"error": "BLOQUEADO: path com prefixo PHI/clinical detectado (%s). Use PHI checklist em shadow/PHI-CHECKLIST.md antes de qualquer leitura."}\n' "$BASENAME"
  exit 2
fi

exit 0
