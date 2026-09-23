# PORTFOLIO

Bundle ID prefix: com.arda (placeholder until Arda confirms)

| App | Stage | Wedge | Bundle ID | Notes |
| --- | --- | --- | --- | --- |
| Paperpath | 4 Polish/QA -> 6 ready-for-arda | Knows which documents each paperwork step needs and gives you, so it always shows what you can do today and what to bring; offline, no account | com.arda.paperpath | Idea: ideas/paperpath.md. iOS workflow not run (tag push refused in cloud session). |

## Parked / killed

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
