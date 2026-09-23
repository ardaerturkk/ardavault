# STATE

Updated: 2026-09-23 (first studio session)

## Current app: Paperpath (apps/paperpath)
Stage: Polish/QA, hand-off written. Arda can archive and upload from apps/paperpath/ARDA-MAC.md.

Done and verified here (Linux container, Flutter 3.47.5):
- Model + starter set (10 steps, 14 documents), JSON persistence with atomic writes and
  a kept copy of unreadable files. Unit tests.
- UI: Steps (Ready/Waiting/Done), step detail (Bring checklist, You Get, deadline,
  appointment, Mark as Done), step editor with document picker, Documents list/detail/editor.
- en/de/tr via gen-l10n, including all starter content.
- Widget flow tests (14) for every core flow; 110 goldens (13 screens/states x light/dark
  x 1x/2x x 375x667/440x956, plus de/tr at small 2x), all reviewed by eye.
- iOS project: iPhone only, portrait only, single deployment target 15.0, PrivacyInfo in
  Runner resources, ITSAppUsesNonExemptEncryption false, CFBundleLocalizations en/de/tr,
  launch screen = systemGroupedBackground, original icon (apps/paperpath/design/icon.svg).
- store/ (en-US, de-DE, tr) and site/paperpath (privacy, support). scripts/dod.sh passes.
- `flutter build web` compiles.

NOT verified (say so, do not fake):
- iOS build / simulator / integration test / 6.9" screenshots: the ios-check workflow
  could not be started. Pushing tags from this session is refused by the git proxy (403),
  and a file-based trigger on the branch was denied as a workaround, so it was not added.
  ARDA-MAC.md tells Arda how to run it (tag from his Mac, or flutter drive locally).
- integration_test/app_test.dart has only been analyzed, not run (needs iOS).
- Playwright web click-through not done: the app uses path_provider, which has no web
  implementation, so the web build is a compile check only. Flows are covered by widget tests.

## Next
1. Apply must-fix items from the design and QA subagent reviews (in progress).
2. When Arda reports the Xcode/ios-check result: fix, bump build number, update hand-off.
3. Then: improve Paperpath (reminders via local notifications only if Arda wants the
   plugin risk) or Discover the next app (budget TRY/EUR, habits) within WIP limits.

## Notes
- Scripts: scripts/dod.sh <app> (verified to catch injected failures).
- Goldens are tagged `golden`; CI runs `flutter test --exclude-tags golden` on macOS.
