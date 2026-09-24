#!/bin/bash
# Renders fallback 6.9-inch App Store screenshots (1320x2868) for an app from its
# test harness and removes the alpha channel (App Store Connect rejects alpha).
set -e
app="${1:?usage: scripts/store_screenshots.sh <app>}"
root="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/flutter/bin:$PATH"
(cd "$root/apps/$app" && flutter test --tags screenshots --run-skipped test/store_screenshots_test.dart)
python3 - "$root/apps/$app/store/screenshots" <<'PY'
import glob, sys
from PIL import Image
for f in sorted(glob.glob(sys.argv[1] + '/*/*.png')):
    im = Image.open(f)
    if im.mode != 'RGB':
        bg = Image.new('RGB', im.size, (255, 255, 255))
        bg.paste(im, mask=im.split()[-1] if im.mode == 'RGBA' else None)
        bg.save(f)
    print(f, Image.open(f).size, Image.open(f).mode)
PY
