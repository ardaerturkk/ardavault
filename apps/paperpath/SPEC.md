# Paperpath: spec

Personality: a calm clerk who already has your folder in order.
Accent: ink blue (light #2255CC, dark #6B9BFF). Everything else is system colors.

## User and job
A newcomer to Germany (first: Arda, a Turkish master's student moving to Kiel) who has
to get through a chain of offices. Job: "Tell me what I can do today, and what to bring."

## Core flows
1. Start: empty Steps screen offers "Add Germany Starter Steps" (asks for the move-in
   date) or "Add Step". The starter set holds 10 typical steps and 15 documents for a
   non-EU student, all editable.
2. Go to an appointment: Steps shows Ready (every needed document is in hand), Waiting
   (names the missing documents) and Done. A step opens to a "Bring" checklist, the
   documents it gives you, deadline and appointment date. Tapping a needed document marks
   it as in hand.
3. Finish a step: "Mark as Done" marks the documents it produces as in hand. Steps that
   were waiting on them move to Ready. Deadlines show "Due in 3 days" / "Overdue".

Documents tab: Have / Missing, each showing what it is needed for and where it comes
from. Add, edit, delete steps and documents.

## Left out (v1)
Notifications (would need a native plugin; deadlines are visible in the list instead),
photos/scans of documents (privacy and storage burden), sync, multiple plans, expiry
tracking, office addresses or opening hours (go stale), iPad, landscape.

## Data model (JSON file, `paperpath.json` in the app documents directory)
- Plan: version, moveInDate (date or null), documents[], steps[].
- Document: id, templateKey?, name?, note, have (bool).
  Display name is `name` if set, else the localized template name.
- PathStep: id, templateKey?, title?, note?, needs [documentId], produces [documentId],
  dueDaysAfterMoveIn (int?) or dueDate (date?), appointment (date-time?), done (bool),
  doneAt (date?).
- Derived: status (done / ready / waiting), effective due date, missing documents.

## Dependencies
- flutter_localizations, intl (SDK / Dart team): localized dates and strings.
- path_provider: the one plugin with native iOS code. Needed to find the app's documents
  directory for the JSON file. Maintained by the Flutter team, used by most apps,
  iOS implementation is path_provider_foundation (no permissions, no data leaves the
  device). Required-reason API: none beyond file timestamps (declared C617.1 to be safe).
- No other packages. No network access at all.
