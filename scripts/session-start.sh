#!/usr/bin/env bash
# session-start.sh — SessionStart hook: hidrata sessao nova com HANDOFF + git state.
# Source: adapted from OLMO hooks/session-start.sh (read-only, autorizado 2026-04-26).
# Melhoras: stripped to ~30L; sem banner/insights/dream/R3-deadline; sem session-name file write;
# sem hook-log rotation; foco em surface HANDOFF + git log + git status.
# Wiring: opt-in via .claude/settings.local.json SessionStart matcher "*".

set -uo pipefail

cat >/dev/null 2>&1 || true

PROJECT_ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
[[ "$(basename "$PROJECT_ROOT")" == ".claude" ]] && exit 0

PROJECT_NAME=$(basename "$PROJECT_ROOT")
TODAY=$(date +%Y-%m-%d)

cat <<EOF
Projeto: $PROJECT_NAME | Data: $TODAY

=== shadow/HANDOFF.md (top 60 li) ===
EOF

if [ -f "$PROJECT_ROOT/shadow/HANDOFF.md" ]; then
  head -n 60 "$PROJECT_ROOT/shadow/HANDOFF.md"
  TOTAL=$(wc -l < "$PROJECT_ROOT/shadow/HANDOFF.md")
  if [ "$TOTAL" -gt 60 ]; then
    echo ""
    echo "(HANDOFF.md truncado em 60/${TOTAL} li — Read integral para detalhes)"
  fi
else
  echo "(no shadow/HANDOFF.md found)"
fi

echo ""
echo "=== git log --oneline -5 ==="
git -C "$PROJECT_ROOT" log --oneline -5 2>/dev/null

echo ""
echo "=== git status --short ==="
git -C "$PROJECT_ROOT" status --short 2>/dev/null | head -15

exit 0
