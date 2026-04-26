#!/usr/bin/env bash
# ask-bash-write.sh — PreToolUse(Bash): pede confirmacao humana antes de
# comandos Bash com write-intent (mkdir, rm, mv, cp, git add/commit/push, >, >>).
# Reads (ls, cat, grep, find, git status/log/diff) sao allow direto.
#
# Decisao do Lucas (2026-04-26): "ask antes de continuar como existe no OLMO original".
# Trigger: comandos que escrevem ou que tem efeito visivel em filesystem/remoto.
# Nao-trigger: read/inspect commands.
#
# Comportamento:
#   - exit 0 + JSON permissionDecision=ask: usuario aprova ou nega caso-a-caso.
#   - exit 0 sem JSON: allow direto (read commands).
#   - exit 0 com JSON allow: allow explicito (raro; deixar implicito).
#
# NUNCA bloqueia (deny e responsabilidade dos guard-* hooks). Aqui so pausa
# para confirmacao humana — alinhado com humano-no-loop em AGENTS.md.

set -uo pipefail

INPUT=$(cat 2>/dev/null || echo '{}')

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

if [ -z "$CMD" ]; then
  exit 0
fi

# Patterns de write-intent. Caso-insensitivo. Prioridade: comando primario na linha.
# Captura tambem em pipelines/`&&`/`;` chains.
WRITE_PATTERNS='\b(mkdir|rmdir|rm|mv|cp|ln|touch|chmod|chown|tee|dd|wget|curl[^|]*-[oO])\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|\bgit\s+(add|commit|push|rm|mv|checkout|reset|clean|tag|stash\s+(push|drop|pop|clear)|branch\s+-[dD]|branch\s+--delete|cherry-pick|rebase|revert|merge|fetch\s+--prune)\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|\bnpm\s+(install|i|publish|run|exec)\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|\bpnpm\s+(add|install|i|publish|run|exec)\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|\buv\s+(add|sync|publish|build|run)\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|\bgh\s+(pr\s+(create|merge|close|edit)|issue\s+(create|edit|close)|release\s+create|workflow\s+run|repo\s+(create|edit|delete|fork))\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|\bsudo\b'
WRITE_PATTERNS="$WRITE_PATTERNS"'|>>\|(?<!\d)>(?!&)'

# Extra: redirecao para arquivo (nao stderr/stdout numerico).
if echo "$CMD" | grep -qE '(^|[^&0-9>])>[^&]' 2>/dev/null; then
  HAS_REDIRECT=1
else
  HAS_REDIRECT=0
fi

if [ "$HAS_REDIRECT" -eq 1 ] || echo "$CMD" | grep -qiE "$WRITE_PATTERNS" 2>/dev/null; then
  # Match: write-intent. Pedir confirmacao.
  REASON="ask-bash-write: comando com write-intent. Confirme antes de executar."
  jq -n --arg reason "$REASON" '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":$reason}}'
  exit 0
fi

# Read-only command: allow implicito.
exit 0
