# Idea: Exercise-sheet points toward exam admission (working name "Sheetwise")

Date: 2026-09-24. Stage: Discover, candidate (passes the wedge test, high confidence).

## Pain (Arda first)
In most German computer science and maths courses you may only sit the Klausur if you
earned a share of the exercise-sheet points during the semester (the Klausurzulassung or
Prüfungsvorleistung): typically 50 % of all points, sometimes "at least 30 % on each
sheet", "the best 10 of 12 sheets count", "present a solution twice" (Vorrechnen), or
bonus points on the exam above 80 %. Arda has four or five courses at once, each with a
weekly sheet, each graded by a different tutor, with points scattered across Moodle/OLAT,
PDFs and emails. The question he actually has every Sunday night is "how many points do
I still need, per remaining sheet, to be admitted, and can I skip this one?" Nobody
answers it; students keep a spreadsheet or find out in week 12 that they are short.

## Competitors (searched 2026-09-24)
- Apple Notes / Numbers: a manual spreadsheet; no rule, no "needed per remaining sheet".
- Notenrechner / Notendurchschnitt / PlusPoints: school grade averages (1-6 or 15-point
  scale) and teacher grading tools; no semester-long sheets against an admission rule.
- MyStudyLife, Assignment Tracker: Timetable, Exam Tracker: homework due dates and
  reminders; they record tasks, not points against a threshold.
- Studo and university apps: timetables and mail, network and account bound; they do
  not compute admission from tutor-graded points.
- Searches in German and English for an app that tracks Übungsblatt points toward the
  Klausurzulassung found only course web pages that state the rules.

## Wedge (one sentence)
Unlike Notes, grade calculators or study planners, Sheetwise knows the usual admission
rules (share of total points, minimum per sheet, best n of m, presentations, bonus
tiers) and after each graded sheet tells you exactly how many points you still need per
remaining sheet, offline and without an account.

## Why it can be great
Sunday evening, the tutor's correction arrives: tap the course, type "14" for sheet 6
out of 20. The hero line changes from "Need 8.6 per sheet" to "Need 7.2 per sheet" and a
quiet second line says "Admitted if you get 43 more points in 6 sheets. You could skip
one sheet and still need only 8.6." When the threshold is reached, the course flips to
"Admitted" with a single light haptic. That moment is the app.

## Three core flows
1. Set up a course (under a minute): name, number of sheets (or "unknown yet"), points
   per sheet (default same for all, editable per sheet), rule: share of total (%), or
   fixed points; optional extras: minimum per sheet (%), best n of m count, required
   presentations (count), bonus tiers (for example 80 % gives 6 exam points).
2. Enter a result: tap a sheet, type points (and max if it differs), mark "not
   submitted" or "excused" (excused sheets leave the total, as many courses rule). The
   course screen shows points so far, admitted yes/no, needed per remaining sheet, and a
   per-sheet list.
3. Semester overview: all courses sorted by risk ("Needs 9.1 of 10 per sheet" at top,
   "Admitted" at bottom), with a what-if: "if I skip sheet 8" recomputes instantly
   without saving.

## Left out
Grades after the exam, ECTS and exam attempts (that was the parked Studienstand idea),
timetables, deadlines and reminders (no notifications plugin), importing from Moodle,
sync, groups. No claims about any specific university's rules: the user types the rule
from the course page.

## Data model
- Semester { id, name (e.g. "WiSe 2026/27"), courses }
- Course { id, name, sheetCount?, defaultMaxPoints, rule: AdmissionRule, sheets,
  presentationsDone, note? }
- AdmissionRule { kind: percentOfTotal | fixedPoints, value, minPercentPerSheet?,
  bestNofM?, presentationsRequired?, excusedLeavesTotal=true, bonusTiers[] }
- Sheet { index, maxPoints, points?, status: open | graded | skipped | excused }
- Derived: pointsCounted, pointsPossible, admitted, neededPerRemainingSheet (with "best
  n of m" handled by optimal choice), isStillPossible, bonus tier reached.
All pure Dart logic, heavily unit tested (best-n-of-m and per-sheet minimum are the
tricky parts). Stored as one JSON file via path_provider.

## Content needs and honesty
No bundled rules and no university data: rules come from the course page, typed in by
the user. Copy says "Based on the rule you entered" and "Check your course page; the
lecturer decides." Numbers shown with intl (decimal comma in German). The only risk is
arithmetic, which is testable exhaustively.

## Risks
- Audience is German-speaking-university students (and Austria/Switzerland, where
  Übungen work the same way), including many internationals: big enough, and App Store
  search terms are distinctive (Klausurzulassung, Übungsblatt, Vorleistung, exam
  admission).
- Rules vary more than the model covers (e.g. two admission blocks, each 50 %). v1: a
  course can have up to two blocks of sheets, each with its own rule; anything stranger
  goes in the note. Keep the rule editor calm, not a formula builder.
- Portfolio: a study tool, clearly different from the bureaucracy apps.

## Design
Accent: teal #0A7C78 (light) / #4DD0C8 (dark).
Personality: a sharp teaching assistant who has already done the arithmetic for you.

## Name
"Sheetwise": no iOS App Store app found by that name (searched 2026-09-24; only a Google
Sheets add-on and web tools use it). Store name idea "Sheetwise: Exam Admission Points".
Check again before submission.
