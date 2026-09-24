# Builder guide (for app-building agents)

You build ONE app, end to end, to the studio's quality bar. CLAUDE.md is the binding
manual; this file is the practical kit. Paperpath (apps/paperpath) is the reference
app: when in doubt, look at how it does it and do the same.

## Ground rules for agents
- Work only inside `apps/<app>/`, `site/<app>/` and your idea brief `ideas/<app>.md`.
  Never edit other apps, scripts/, CLAUDE.md, STATE.md, PORTFOLIO.md, ARDA-INBOX.md.
- Never run git (no add, commit, push, checkout, stash). The orchestrator commits.
- No emoji anywhere. No network, no accounts, no analytics, no paid anything.
- Only pure Dart packages plus path_provider (already added). Any other plugin with
  native iOS code needs a very strong reason in SPEC.md; prefer leaving the feature out.
- Flutter: `export PATH=$HOME/flutter/bin:$PATH`. Several agents build at once: only
  run flutter commands inside your own app directory.

## Steps
1. `bash scripts/new_app.sh <app> "<Display Name>" "<description>"` (run from repo root).
   It creates the Flutter app with bundle id com.arda.<app>, studio lint/l10n/test
   config, the test font helper, and all iOS project settings (iPhone only, portrait,
   iOS 15.0, PrivacyInfo in Runner resources, Info.plist keys, plain launch screen).
2. `apps/<app>/SPEC.md`: user, job, three core flows, left out, data model,
   dependencies with justification, accent color (light/dark hex), personality.
3. Model and logic first, with unit tests. Persistence: one JSON file via
   path_provider, atomic write (tmp + rename), unreadable file moved aside and writes
   blocked if that fails. Copy the pattern from apps/paperpath/lib/state/.
4. UI with Cupertino only (see CLAUDE.md design rules). Reuse Paperpath's helpers by
   copying apps/paperpath/lib/ui/widgets.dart and adapting: RowText, AddButton,
   EmptyState, ProblemBanner, ValueTile, FooterText, pickDate, confirmDelete,
   cancelEditor, leaveDeletedPage, oneLine.
5. Strings: lib/l10n/app_en.arb, app_de.arb, app_tr.arb with natural German and
   Turkish. All numbers, dates and money through intl.
6. Tests: unit tests, widget flow tests for every core flow (copy the style of
   apps/paperpath/test/flows_test.dart), and goldens tagged `golden` for every screen
   and state (empty, typical, heavy, error) x light/dark x text scale 1.0/2.0 x
   375x667 and 440x956, plus de/tr at the small size and 2x. Copy
   apps/paperpath/test/goldens_test.dart and test/support/demo.dart patterns. Run
   date/time tests also with `TZ=Europe/Berlin`.
7. LOOK at the goldens (Read the PNGs; make contact sheets with Pillow to see many at
   once). Fix clipping, overlap, misalignment, loud or inconsistent styling. Repeat.
8. Icon: original SVG in `design/icon.svg` (simple, bold, one idea, accent background,
   no text, no SF Symbols, no other brands), render to `design/icon-1024.png` without
   alpha (Playwright Chromium at /opt/pw-browsers, see below, then Pillow convert RGB),
   then `dart run flutter_launcher_icons`.
9. Integration test `integration_test/app_test.dart` (driven by test_driver, which is
   already copied): a real-storage round trip plus the main flow with
   `binding.takeScreenshot('${locale}_N_name')` (locale from
   `String.fromEnvironment('SCREENSHOT_LOCALE')`). See Paperpath's.
10. Store: `store/{en-US,de-DE,tr}/{name,subtitle,keywords,description,
    promotional_text,review_notes}.txt` (limits: name/subtitle 30 chars, keywords 100
    bytes without words from name/subtitle, promo 170). Fallback screenshots: copy
    apps/paperpath/test/store_screenshots_test.dart, then run
    `bash scripts/store_screenshots.sh <app>` (change the output path inside the test from
    apps/paperpath to apps/<app>).
11. `site/<app>/privacy.md` (must contain "does not collect") and `support.md`.
12. `apps/<app>/ARDA-MAC.md` in Turkish, same structure as Paperpath's.
13. `bash scripts/dod.sh <app>` must print "DoD: all automatable items pass".

## Hard-won lessons (do not repeat these bugs)
- Icon and TextStyle do NOT resolve CupertinoDynamicColor: always pass
  `accent.resolveFrom(context)`. dod.sh greps for `color: accent,`.
- Never await HapticFeedback in handlers (stalls widget tests): `unawaited(...)`.
- Use CupertinoListSection.insetGrouped for forms too (CupertinoFormSection headers
  render without the theme font in tests).
- Label + value rows break at 2x text: use Paperpath's ValueTile (value moves under the
  label at large text; label unflexed, value Expanded and end-aligned otherwise).
- Date math in calendar days: `DateTime(y, m, d + n)`, and day differences via
  `DateTime.utc(...)`. Never `add(Duration(days: n))` on local dates.
- Deleting an item whose detail page is open: remove only that route
  (`leaveDeletedPage`), never `maybePop()` from build.
- Semantics(excludeSemantics: true) must also get `onTap`.
- The store screenshot test is tagged `screenshots` and writes RGBA; only run it via
  scripts/store_screenshots.sh (which flattens). dod.sh excludes it and checks alpha.
- Soft hyphens (U+00AD) break lines without a visible hyphen: do not use them.
- 12/24-hour time: follow `MediaQuery.alwaysUse24HourFormatOf(context)`.
- Section footers: footnote size (13) in secondaryLabel (FooterText).
- Primary action reachable: pin it in a bottom bar on long detail screens.
- Empty state inside SliverFillRemaining(hasScrollBody: false): no maxWidth
  constraints (breaks intrinsic sizing); use horizontal padding instead.

## Rendering the icon
```
cd /tmp && mkdir -p pw && cd pw && (test -d node_modules/playwright || npm i -s playwright@1.56.1)
node -e "const {chromium}=require('playwright');(async()=>{const b=await chromium.launch();const p=await b.newPage({viewport:{width:1024,height:1024}});await p.goto('file://'+process.argv[1]);await p.screenshot({path:process.argv[2]});await b.close();})()" /abs/design/icon.svg /abs/design/icon-rgba.png
python3 -c "from PIL import Image;Image.open('/abs/design/icon-rgba.png').convert('RGB').save('/abs/design/icon-1024.png')"
```
