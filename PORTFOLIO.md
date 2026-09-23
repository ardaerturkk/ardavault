# PORTFOLIO

Bundle ID prefix: com.arda (placeholder until Arda confirms)

| App | Stage | Wedge | Bundle ID | Notes |
| --- | --- | --- | --- | --- |
| Paperpath | 4 Polish/QA -> 6 ready-for-arda | Knows which documents each paperwork step needs and gives you, so it always shows what you can do today and what to bring; offline, no account | com.arda.paperpath | Idea: ideas/paperpath.md. iOS workflow not run (tag push refused in cloud session). |

## Parked / killed

- Document expiry tracker: saturated (Document Expiry Reminder, RemindMe, KeepValid, RenewalKit).
- Contract cancellation tracker: saturated (All Renewals, aboalarm, Contract, Contractly).

## Learnings

- The cloud session's git proxy only accepts pushes to claude/app-studio: tags are refused,
  so the tag-triggered ios-check has to be started by Arda (or a future path he approves).
- Awaiting HapticFeedback in tap handlers stalls widget tests; fire and forget with unawaited().
- CupertinoFormSection headers render without the theme font in tests; CupertinoListSection
  headers are fine and look the same.
- Value rows (label + additionalInfo) break at 2x text: move the value under the label.
