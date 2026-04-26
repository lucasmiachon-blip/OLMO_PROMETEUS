#!/usr/bin/env bash
# pre-compact-checkpoint.sh — PreCompact hook: snapshot do estado antes de context compaction.
# Source: adapted from OLMO hooks/pre-compact-checkpoint.sh (read-only, autorizado 2026-04-26).
# Melhoras: stripped to ~25L; sem dependencia de .session-name / .plan-path / pending-fixes.md;
# escreve em .claude/.last-checkpoint (gitignored).
# Wiring: opt-in via .claude/settings.local.json PreCompact matcher "*".

set -uo pipefail

cat >/dev/null 2>&1 || true

PROJECT_ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
[[ "$(basename "$PROJECT_ROOT")" == ".claude" ]] && exit 0

CHECKPOINT="$PROJECT_ROOT/.claude/.last-checkpoint"
mkdir -p "$(dirname "$CHECKPOINT")"

{
  echo "=== Checkpoint $(date '+%Y-%m-%d %H:%M:%S') ==="
  echo ""
  echo "## git log --oneline -5"
  git -C "$PROJECT_ROOT" log --oneline -5 2>/dev/null
  echo ""
  echo "## git status --short"
  git -C "$PROJECT_ROOT" status --short 2>/dev/null
  echo ""
  echo "## Recently modified (last 30 min, .md/.sh/.json)"
  find "$PROJECT_ROOT" -maxdepth 4 -type f \( -name "*.md" -o -name "*.sh" -o -name "*.json" \) -not -path "*/.git/*" -not -path "*/node_modules/*" -not -path "*/.venv/*" -mmin -30 2>/dev/null | head -15
  echo ""
  echo "## HANDOFF top 30 li"
  head -n 30 "$PROJECT_ROOT/shadow/HANDOFF.md" 2>/dev/null || echo "(no HANDOFF)"
} > "$CHECKPOINT" 2>&1 || echo "[pre-compact] checkpoint write failed: $CHECKPOINT" >&2

exit 0
