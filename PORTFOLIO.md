# PORTFOLIO

Bundle ID prefix: com.arda (placeholder until Arda confirms)

| App | Stage | Wedge | Bundle ID | Notes |
| --- | --- | --- | --- | --- |
| Paperpath | 6 ready-for-arda (1.0.0+1) | Knows which documents each paperwork step needs and gives you, so it always shows what you can do today and what to bring; offline, no account | com.arda.paperpath | Idea: ideas/paperpath.md. iOS workflow not run (tag push refused in cloud session). |
| Flatboard (flat hunt) | 6 ready-for-arda (1.0.0+1), review fixes applied | One offline pipeline for flats from every portal, with viewings and warm-rent comparison | - | ideas/flathunt.md; waiting on Arda: still looking? |
| Halfday (work-day quota) | 4 Polish/QA (dod.sh passes, review running) | Counts full/half work days against the 140/280 student quota and shows when a plan hits the limit | com.arda.halfday | ideas/halfday.md |
| Sagbar (counter phrases) | 6 ready-for-arda (1.0.0+1), review fixes applied | Ready German lines with your own details filled in, meanings in EN/TR, show-card for the counter | com.arda.sagbar | ideas/sagbar.md |

## Parked / killed

- Studienstand (ECTS/exam-attempt planner): parked, low-medium confidence; module.org covers much of it.
- Belegheft (study-cost receipts for the tax return): parked, close to the killed expense-tracker category; MeinELSTER+ is free.
- From the idea agent, dropped: grocery unit prices, utility bill check, recipe costing, der/die/das trainer, Turkish ingredient guide, WG chores (needs sync), packing (all saturated or out of scope).

- Document expiry tracker: saturated (Document Expiry Reminder, RemindMe, KeepValid, RenewalKit).
- Contract cancellation tracker: saturated (All Renewals, aboalarm, Contract, Contractly).
- Daily "safe to spend" student budget: saturated (DaySum, BUDGT, Safe To Spend, Daily
  Budget, Allowance Budgeting), all offline and bank-free already. Killed 2026-09-23.
- Two-currency (TRY/EUR) expense tracker: saturated (Finny, Money Lover, Expenses,
  SpendSnap). Killed 2026-09-23.
- Waste sorting guide for Germany: parked. Several apps exist (Sort My Trash, Fessies,
  Recycling Master), rules differ per city, and "offline + Turkish" alone is not a wedge.
- Candidate for Paperpath v1.1 instead of a new app: official letters (Behörde,
  Krankenkasse, Rundfunkbeitrag) with reply deadlines, e.g. one month for a Widerspruch,
  linked to steps and documents. Wait for Arda's feedback on v1 first.

## Learnings

- The cloud session's git proxy only accepts pushes to claude/app-studio: tags are refused,
  so the tag-triggered ios-check has to be started by Arda (or a future path he approves).
- Awaiting HapticFeedback in tap handlers stalls widget tests; fire and forget with unawaited().
- CupertinoFormSection headers render without the theme font in tests; CupertinoListSection
  headers are fine and look the same.
- Value rows (label + additionalInfo) break at 2x text: move the value under the label.
- Icon and TextStyle do not resolve CupertinoDynamicColor: always pass
  `accent.resolveFrom(context)`, or dark mode silently uses the light color. dod.sh checks.
- Soft hyphens (U+00AD) break lines in Flutter without drawing a hyphen: do not use them.
- Run date logic tests with TZ=Europe/Berlin: container UTC hides DST off-by-one bugs.
- Fresh-eyes QA and design subagents found real bugs (DST, navigation, data loss) that
  110 goldens and 50 tests did not: always run them before hand-off.
- `flutter test` also ran the store screenshot test and silently re-wrote RGBA screenshots
  (App Store rejects alpha). dod.sh now excludes the tag and checks for alpha.
- Plain `flutter test` now skips the `screenshots` tag (dart_test.yaml skip);
  scripts/store_screenshots.sh passes --run-skipped.
- WIP limit note: Arda asked for parallel apps until morning (2026-09-23), which overrides
  the usual limit of two unconfirmed ready-for-arda apps for that night. He picks which
  ones to publish; do not upload several near-simultaneously (Guideline 4.3).
