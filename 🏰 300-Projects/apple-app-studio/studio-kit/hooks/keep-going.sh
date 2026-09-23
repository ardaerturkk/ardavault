#!/bin/bash
# Studio Stop hook: keeps the session working until Arda creates a STOP file.
# Allows stopping when: STOP exists, everything is blocked on Arda, or background work
# (subagents, builds) is still running and will wake the session by itself.
input=$(cat)
dir="${CLAUDE_PROJECT_DIR:-$PWD}"

[ -f "$dir/STOP" ] && exit 0
[ -f "$dir/.studio/WAITING_ON_ARDA" ] && exit 0

if command -v jq >/dev/null 2>&1; then
  running=$(printf '%s' "$input" | jq '(.background_tasks // []) | length' 2>/dev/null)
  [ "${running:-0}" -gt 0 ] && exit 0
fi

echo "Studio loop: no STOP file. Read STATE.md, do the next most valuable pipeline step from CLAUDE.md, verify it, update STATE.md and PORTFOLIO.md, commit. If every remaining step is blocked on Arda, create .studio/WAITING_ON_ARDA, explain in ARDA-INBOX.md, and end." >&2
exit 2
