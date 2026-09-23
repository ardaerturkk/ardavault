#!/bin/bash
# Studio Stop hook (cloud): keeps a run working for up to RUN_MINUTES, then lets it end
# so the next scheduled run can take over. A STOP file in the repo stops everything.
RUN_MINUTES=100
input=$(cat)
dir="${CLAUDE_PROJECT_DIR:-$PWD}"

[ -f "$dir/STOP" ] && exit 0
[ -f "$dir/.studio/WAITING_ON_ARDA" ] && exit 0

if command -v jq >/dev/null 2>&1; then
  running=$(printf '%s' "$input" | jq '(.background_tasks // []) | length' 2>/dev/null)
  [ "${running:-0}" -gt 0 ] && exit 0
fi

start=$(cat "$dir/.studio/run-start" 2>/dev/null || echo 0)
elapsed=$(( ($(date +%s) - start) / 60 ))
if [ "$elapsed" -lt "$RUN_MINUTES" ]; then
  echo "Studio run: ${elapsed}/${RUN_MINUTES} min used. Read STATE.md, do the next pipeline step from CLAUDE.md, verify it, update STATE.md, commit and push to main. If everything is blocked on Arda, create .studio/WAITING_ON_ARDA, explain in ARDA-INBOX.md, push, and end." >&2
  exit 2
fi

# Past the budget: one wrap-up nudge (for 15 min) if the run lock is still in the repo.
if [ -f "$dir/STUDIO.LOCK" ] && [ "$elapsed" -lt $((RUN_MINUTES + 15)) ]; then
  echo "Run budget reached. Update STATE.md, delete STUDIO.LOCK, commit and push to main, then end." >&2
  exit 2
fi
exit 0
