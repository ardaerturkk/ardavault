#!/bin/bash
# Studio SessionStart hook (cloud): installs Flutter if missing and records the run start.
dir="${CLAUDE_PROJECT_DIR:-$PWD}"
mkdir -p "$dir/.studio"
date +%s > "$dir/.studio/run-start"

if ! command -v flutter >/dev/null 2>&1 && [ ! -x "$HOME/flutter/bin/flutter" ]; then
  json=$(curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json) || exit 0
  archive=$(printf '%s' "$json" | python3 -c "import json,sys;d=json.load(sys.stdin);h=d['current_release']['stable'];print([r for r in d['releases'] if r['hash']==h][0]['archive'])")
  curl -fsSL "https://storage.googleapis.com/flutter_infra_release/releases/$archive" | tar -xJ -C "$HOME" || exit 0
  git config --global --add safe.directory "$HOME/flutter"
  "$HOME/flutter/bin/flutter" config --no-analytics >/dev/null 2>&1
  "$HOME/flutter/bin/flutter" precache --web >/dev/null 2>&1
fi

if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo "export PATH=\"$HOME/flutter/bin:$HOME/.pub-cache/bin:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi
exit 0
