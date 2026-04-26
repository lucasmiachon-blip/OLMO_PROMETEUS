#!/usr/bin/env bash
# trace-edits.sh — PostToolUse(Edit|Write|MultiEdit): emite resumo do diff/edit
# para o usuario VER em tempo real (stderr) + para o modelo (additionalContext).
#
# Proposito: transparencia em duas camadas. Usuario monitora cada Edit/Write no
# transcript; modelo recebe o mesmo trace como contexto estruturado.
#
# Source: original deste repo (nao adaptado de OLMO).
# Wiring: .claude/settings.local.json PostToolUse matcher "Edit|Write|MultiEdit".
# Nunca bloqueia (sempre exit 0).

set -uo pipefail

INPUT=$(cat 2>/dev/null || echo '{}')

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null || echo "")
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""' 2>/dev/null || echo "")

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
HEADER=""
BODY=""

if [ -n "$REPO_ROOT" ] && [[ "$FILE_PATH" == "$REPO_ROOT"* ]]; then
  REL=${FILE_PATH#"$REPO_ROOT"/}
  if git -C "$REPO_ROOT" ls-files --error-unmatch "$REL" >/dev/null 2>&1; then
    SHORTSTAT=$(git -C "$REPO_ROOT" diff --no-color --shortstat -- "$REL" 2>/dev/null | sed 's/^[[:space:]]*//')
    DIFF=$(git -C "$REPO_ROOT" diff --no-color -- "$REL" 2>/dev/null | head -60)
    if [ -n "$DIFF" ]; then
      HEADER="[trace] $TOOL_NAME -> $REL"
      [ -n "$SHORTSTAT" ] && HEADER="$HEADER ($SHORTSTAT)"
      BODY="$DIFF"
    else
      LINES=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "?")
      HEADER="[trace] $TOOL_NAME -> $REL (no diff vs HEAD; $LINES lines)"
    fi
  else
    LINES=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "?")
    HEADER="[trace] $TOOL_NAME -> $REL (untracked, $LINES lines)"
  fi
else
  LINES=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "?")
  HEADER="[trace] $TOOL_NAME -> $FILE_PATH (outside repo, $LINES lines)"
fi

# 1) Para o USUARIO: stderr surfaces no transcript do Claude Code.
{
  echo "$HEADER"
  if [ -n "$BODY" ]; then
    echo "$BODY"
    LINES_DIFF=$(echo "$BODY" | wc -l)
    if [ "$LINES_DIFF" -ge 60 ]; then
      echo "... (diff truncado em 60 li; use \`git diff -- $REL\` para ver completo)"
    fi
  fi
} >&2

# 2) Para o MODELO: JSON additionalContext (contexto estruturado).
CTX="$HEADER"
[ -n "$BODY" ] && CTX="$CTX"$'\n'"$BODY"
jq -n --arg ctx "$CTX" '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":$ctx}}'
exit 0
