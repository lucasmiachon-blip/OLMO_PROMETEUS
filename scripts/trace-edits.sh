#!/usr/bin/env bash
# trace-edits.sh — PostToolUse(Edit|Write|MultiEdit): emite resumo do diff/edit como additionalContext.
# Proposito: transparencia. Cada Edit/Write produz uma linha visivel no proximo turn do agente,
# para o user ver o que esta sendo modificado em tempo real (em vez de surpresa em commits).
# Wiring: .claude/settings.local.json PostToolUse matcher "Edit|Write|MultiEdit".
# Nunca bloqueia (sempre exit 0). Output: JSON com hookSpecificOutput.additionalContext.

set -uo pipefail

INPUT=$(cat 2>/dev/null || echo '{}')

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null || echo "")
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""' 2>/dev/null || echo "")

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
CTX=""

if [ -n "$REPO_ROOT" ] && [[ "$FILE_PATH" == "$REPO_ROOT"* ]]; then
  REL=${FILE_PATH#"$REPO_ROOT"/}
  if git -C "$REPO_ROOT" ls-files --error-unmatch "$REL" >/dev/null 2>&1; then
    SHORTSTAT=$(git -C "$REPO_ROOT" diff --no-color --shortstat -- "$REL" 2>/dev/null | sed 's/^[[:space:]]*//')
    DIFF_HEAD=$(git -C "$REPO_ROOT" diff --no-color -- "$REL" 2>/dev/null | head -25)
    if [ -n "$DIFF_HEAD" ]; then
      CTX="[trace] $TOOL_NAME -> $REL"$'\n'"$SHORTSTAT"$'\n'"$DIFF_HEAD"
    else
      LINES=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "?")
      CTX="[trace] $TOOL_NAME -> $REL (no diff vs HEAD; $LINES lines)"
    fi
  else
    LINES=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "?")
    CTX="[trace] $TOOL_NAME -> $REL (untracked, $LINES lines)"
  fi
else
  CTX="[trace] $TOOL_NAME -> $FILE_PATH (outside repo)"
fi

jq -n --arg ctx "$CTX" '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":$ctx}}'
exit 0
