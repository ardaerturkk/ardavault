#!/bin/bash
# Definition of done for one app: scripts/dod.sh <app>
# Exits non-zero if any automatable item from the iOS readiness checklist fails.
set -u
app="${1:?usage: scripts/dod.sh <app>}"
root="$(cd "$(dirname "$0")/.." && pwd)"
dir="$root/apps/$app"
export PATH="$HOME/flutter/bin:$PATH"
fails=0
pass() { printf '  ok    %s\n' "$1"; }
fail() { printf '  FAIL  %s\n' "$1"; fails=$((fails + 1)); }
check() { if eval "$2" >/dev/null 2>&1; then pass "$1"; else fail "$1"; fi; }

[ -d "$dir" ] || { echo "no such app: $dir"; exit 2; }
prefix=$(sed -n 's/^Bundle ID prefix: \([a-z0-9.]*\).*/\1/p' "$root/PORTFOLIO.md")
bundle="${prefix:-com.arda}.$app"
plist="$dir/ios/Runner/Info.plist"
pbx="$dir/ios/Runner.xcodeproj/project.pbxproj"

echo "== $app: code"
(cd "$dir" && flutter pub get >/dev/null 2>&1)
check "dart format clean" "cd '$dir' && dart format --output=none --set-exit-if-changed lib test integration_test"
check "flutter analyze: no issues" "cd '$dir' && flutter analyze --no-pub"
check "flutter test (incl. goldens) green" "cd '$dir' && flutter test --no-pub"
check "golden PNGs exist" "ls '$dir'/test/goldens/*.png"
check "no print() in lib" "! grep -rnE '\\bprint\\(' '$dir/lib'"
check "no TODO/FIXME in lib" "! grep -rnE 'TODO|FIXME|XXX' '$dir/lib'"
check "no placeholder text" "! grep -rniE 'lorem|ipsum|placeholder text' '$dir/lib' '$dir/store'"
check "no debug banner" "grep -rq 'debugShowCheckedModeBanner: false' '$dir/lib'"
check "no Material import in lib" "! grep -rn \"package:flutter/material.dart\" '$dir/lib'"
check "no emoji in app, store, site" "! python3 '$root/scripts/find_emoji.py' '$dir/lib' '$dir/store' '$root/site/$app' '$dir/ARDA-MAC.md'"
check "no network or data SDKs" "! grep -nE '^\\s+(http|dio|firebase|sentry|amplitude|mixpanel|google_mobile_ads|url_launcher):' '$dir/pubspec.yaml'"

echo "== $app: version and l10n"
check "pubspec version 1.0.0+N" "grep -qE '^version: 1\\.0\\.0\\+[0-9]+' '$dir/pubspec.yaml'"
for l in en de tr; do check "ARB $l present" "test -s '$dir/lib/l10n/app_$l.arb'"; done

echo "== $app: iOS project"
check "Info.plist exists" "test -f '$plist'"
pl() { plutil_get "$1"; }
plutil_get() { python3 -c "import plistlib,sys;d=plistlib.load(open('$plist','rb'));v=d.get(sys.argv[1]);print(v if v is not None else '__missing__')" "$1"; }
check "ITSAppUsesNonExemptEncryption = false" "[ \"\$(pl ITSAppUsesNonExemptEncryption)\" = False ]"
check "CFBundleDisplayName set" "[ \"\$(pl CFBundleDisplayName)\" != __missing__ ]"
check "CFBundleLocalizations en de tr" "python3 -c \"import plistlib;d=plistlib.load(open('$plist','rb'));assert set(d['CFBundleLocalizations'])>={'en','de','tr'}\""
check "portrait only (iPhone)" "python3 -c \"import plistlib;d=plistlib.load(open('$plist','rb'));assert d['UISupportedInterfaceOrientations']==['UIInterfaceOrientationPortrait']\""
check "no usage-description keys" "python3 -c \"import plistlib;d=plistlib.load(open('$plist','rb'));assert not [k for k in d if k.endswith('UsageDescription')]\""
check "bundle id $bundle on all Runner configs" "[ \"\$(grep -c 'PRODUCT_BUNDLE_IDENTIFIER = $bundle;' '$pbx')\" -ge 3 ]"
check "no com.example anywhere in ios" "! grep -rq 'com.example' '$dir/ios'"
check "TARGETED_DEVICE_FAMILY = 1 only" "grep -q 'TARGETED_DEVICE_FAMILY = 1;' '$pbx' && ! grep -q 'TARGETED_DEVICE_FAMILY = \"1,2\"' '$pbx'"
check "single IPHONEOS_DEPLOYMENT_TARGET" "[ \"\$(grep -o 'IPHONEOS_DEPLOYMENT_TARGET = [0-9.]*' '$pbx' | sort -u | wc -l)\" -eq 1 ]"
check "PrivacyInfo.xcprivacy exists" "test -f '$dir/ios/Runner/PrivacyInfo.xcprivacy'"
check "PrivacyInfo in Runner resources" "grep -q 'PrivacyInfo.xcprivacy in Resources' '$pbx'"
check "PrivacyInfo: NSPrivacyTracking false" "python3 -c \"import plistlib;d=plistlib.load(open('$dir/ios/Runner/PrivacyInfo.xcprivacy','rb'));assert d['NSPrivacyTracking'] is False and d['NSPrivacyCollectedDataTypes']==[]\""
check "app icon 1024 without alpha" "python3 '$root/scripts/png_info.py' '$dir/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png' 1024 1024 noalpha"

echo "== $app: store and site"
for l in en-US de-DE tr; do
  s="$dir/store/$l"
  for f in name.txt subtitle.txt keywords.txt description.txt promotional_text.txt review_notes.txt; do
    check "store/$l/$f" "test -s '$s/$f'"
  done
  check "store/$l name <= 30 chars" "python3 -c \"import sys;assert len(open('$s/name.txt').read().strip())<=30\""
  check "store/$l subtitle <= 30 chars" "python3 -c \"import sys;assert len(open('$s/subtitle.txt').read().strip())<=30\""
  check "store/$l keywords <= 100 bytes" "python3 -c \"assert len(open('$s/keywords.txt').read().strip().encode())<=100\""
  check "store/$l promo <= 170 chars" "python3 -c \"assert len(open('$s/promotional_text.txt').read().strip())<=170\""
  check "store/$l description <= 4000 chars" "python3 -c \"assert len(open('$s/description.txt').read().strip())<=4000\""
  check "store/$l keywords not in name/subtitle" "python3 '$root/scripts/keywords_check.py' '$s'"
done
check "site privacy.md" "grep -qi 'does not collect' '$root/site/$app/privacy.md'"
check "site support.md" "test -s '$root/site/$app/support.md'"
check "ARDA-MAC.md" "test -s '$dir/ARDA-MAC.md'"

echo
if [ "$fails" -gt 0 ]; then echo "DoD: $fails failing item(s)"; exit 1; fi
echo "DoD: all automatable items pass"
