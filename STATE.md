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

Reviews (fresh-eyes subagents, 2026-09-23), all must-fix items applied:
- Design: footnote footers, back labels, one icon language for step status and documents,
  Ready icon no longer looks like a checkbox, editor wording matches detail (Bring/You
  Get), editor alignment, Mark as Done pinned in a bottom bar (tinted + confirm on
  waiting steps), missing documents first with "From: <step>", clearer error copy,
  status line under step titles, due-soon in orange, rounded picker sheet.
- QA: calendar-day math across DST (tests run with TZ=Europe/Berlin), deleted-page
  navigation removes only its own route, same-date deadline pick keeps the move-in link,
  unreadable file is moved aside (writes blocked if that fails), VoiceOver tap on Bring
  rows, refresh on resume, 12/24h appointment times, single-line titles, a step cannot
  need what it gives, id collision guard, German copy fixes.
- Not done (should-fix, low value now): undo for deletes, discard-changes prompt,
  localized list joining ("A, B"), collapsed Done section.

## Next
1. Wait for Arda's Xcode result; fix anything he reports.
2. When Arda reports the Xcode/ios-check result: fix, bump build number, update hand-off.
3. Discover (2026-09-23): budget, TRY/EUR tracker and waste sorting failed the wedge
   test (see PORTFOLIO.md). Next Discover should dig into habits/to-dos with a real
   wedge, or pursue Paperpath v1.1 "letters" if Arda likes v1.
4. Then: improve Paperpath (reminders via local notifications only if Arda wants the
   plugin risk) or Discover the next app (budget TRY/EUR, habits) within WIP limits.

## Notes
- Scripts: scripts/dod.sh <app> (verified to catch injected failures).
- Goldens are tagged `golden`; CI runs `flutter test --exclude-tags golden` on macOS.
- Fallback store screenshots: scripts/store_screenshots.sh <app> (1320x2868, RGB, Roboto, no status bar).
