#!/bin/bash
# Applies the studio iOS settings to apps/<app>/ios (idempotent):
# iPhone only, portrait only, single deployment target 15.0, privacy manifest in
# Runner resources, Info.plist keys, plain launch screen (systemGroupedBackground).
#   scripts/ios_setup.sh <app> "<Display Name>" [extra required-reason JSON ignored]
set -e
app="${1:?usage}"; display="${2:?display name}"
root="$(cd "$(dirname "$0")/.." && pwd)"
ios="$root/apps/$app/ios"
cd "$ios"
cp "$root/apps/paperpath/ios/Runner/PrivacyInfo.xcprivacy" Runner/PrivacyInfo.xcprivacy
cp "$root/apps/paperpath/ios/Runner/Base.lproj/LaunchScreen.storyboard" Runner/Base.lproj/LaunchScreen.storyboard
rm -rf Runner/Assets.xcassets/LaunchImage.imageset
ruby -e '
require "xcodeproj"
p = Xcodeproj::Project.open("Runner.xcodeproj")
p.build_configurations.each { |c| c.build_settings["TARGETED_DEVICE_FAMILY"] = "1"; c.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "15.0" }
r = p.targets.find { |t| t.name == "Runner" }
r.build_configurations.each { |c| c.build_settings["TARGETED_DEVICE_FAMILY"] = "1"; c.build_settings.delete("IPHONEOS_DEPLOYMENT_TARGET") }
g = p.main_group.find_subpath("Runner", false)
unless g.files.any? { |f| f.path == "PrivacyInfo.xcprivacy" }
  r.resources_build_phase.add_file_reference(g.new_reference("PrivacyInfo.xcprivacy"))
end
p.save'
python3 - "$display" <<'PY'
import plistlib, sys
p = 'Runner/Info.plist'
d = plistlib.load(open(p, 'rb'))
d['CFBundleDisplayName'] = sys.argv[1]
d['CFBundleName'] = sys.argv[1]
d['ITSAppUsesNonExemptEncryption'] = False
d['CFBundleLocalizations'] = ['en', 'de', 'tr']
d['CFBundleDevelopmentRegion'] = 'en'
d['UISupportedInterfaceOrientations'] = ['UIInterfaceOrientationPortrait']
d.pop('UISupportedInterfaceOrientations~ipad', None)
d['UIRequiresFullScreen'] = True
plistlib.dump(d, open(p, 'wb'))
PY
echo "iOS settings applied to apps/$app"
