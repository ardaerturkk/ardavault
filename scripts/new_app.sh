#!/bin/bash
# Scaffolds a studio app the way Paperpath was set up:
#   scripts/new_app.sh <app> "<Display Name>" "<one-line description>"
# Creates apps/<app> (iOS + web), studio lint/l10n/test config, the test font
# helper, and applies the iOS project settings (scripts/ios_setup.sh).
set -e
app="${1:?usage: scripts/new_app.sh <app> <DisplayName> <description>}"
display="${2:?display name}"
desc="${3:-$display}"
root="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/flutter/bin:$PATH"
dir="$root/apps/$app"
[ -e "$dir" ] && { echo "apps/$app exists"; exit 1; }
cd "$root/apps"
flutter create --platforms=ios,web --org com.arda --project-name "$app" --description "$desc" "$app" >/dev/null
cd "$dir"
rm -f test/widget_test.dart
flutter pub add path_provider intl 'flutter_localizations:{"sdk":"flutter"}' >/dev/null
flutter pub add 'dev:integration_test:{"sdk":"flutter"}' 'dev:flutter_driver:{"sdk":"flutter"}' dev:flutter_launcher_icons >/dev/null
python3 - "$app" <<'PY'
import re, sys
s = open('pubspec.yaml').read()
s = re.sub(r'\nflutter:\n[\s\S]*$', '\nflutter:\n  generate: true\n', s)
s = '\n'.join(l for l in s.split('\n') if not l.strip().startswith('#'))
s = re.sub(r'\n{3,}', '\n\n', s).replace(" # Remove this line if you wish to publish to pub.dev", "")
s += '''
flutter_launcher_icons:
  ios: true
  android: false
  image_path: design/icon-1024.png
  remove_alpha_ios: true
'''
open('pubspec.yaml', 'w').write(s)
PY
pp="$root/apps/paperpath"
cp "$pp/analysis_options.yaml" "$pp/l10n.yaml" "$pp/dart_test.yaml" .
mkdir -p test/support lib/l10n design integration_test test_driver
cp "$pp/test/support/fonts.dart" test/support/
cp "$pp/test_driver/integration_test.dart" test_driver/
bash "$root/scripts/ios_setup.sh" "$app" "$display"
echo "apps/$app scaffolded. Next: lib/l10n/app_{en,de,tr}.arb, SPEC.md, code, tests."
