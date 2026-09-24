# Idea: Student work-day allowance counter (working name "Halfday")

Date: 2026-09-23. Stage: built (apps/halfday), ready for review. 2.5-days-per-week method left out of v1 (explained in the app, not computed).

## Pain (Arda first)
A non-EU student on a Section 16b residence permit may work 140 full days or 280 half
days per calendar year (raised from 120/240 in 2024). A day with more than 4 hours is a
full day, up to 4 hours is a half day; vacation and sick days do not count; university
jobs (studentische Hilfskraft, tutor) are exempt; during the lecture period the 20-hour
week also matters for Werkstudent status, and a Minijob must stay under the monthly
limit (603 EUR in 2026, 633 EUR in 2027). Arda will take a Werkstudent or Minijob in
Kiel. Crossing the day limit risks his residence permit, and nobody at the employer
counts it for him. Today people keep this in a spreadsheet or not at all.

## Competitors (searched 2026-09-23)
- Hours trackers: Hours Tracker, atWork Zeiterfassung, Stundenzettel (TimeChief),
  WORK Arbeitszeiterfassung. They sum hours and pay; none knows the full-day/half-day
  rule, the calendar-year quota, exempt university jobs or the 2.5-days-per-week method.
- Workdays / Workdays calculator: count business days between dates, not a work quota.
- Apple Calendar / Notes / spreadsheets: no rule, no remaining count, easy to miscount.
- Search for an app that counts the 140/280 quota found only guides (Expatrio,
  GradGermany, university and Ausländerbehörde leaflets) that say "keep a log".

## Wedge (one sentence)
Unlike Calendar or any hours tracker, Halfday turns each shift into full or half days
under the student residence rules (4-hour threshold, exempt university jobs, calendar
year) and always shows how many days are left and the date a planned job would hit the
limit, offline and without an account.

## Why it can be great
The core loop is one tap: log "3.5 h at the cafe" and the big number drops from 213 to
212.5 with a half tick, plus a quiet line "Half day. 20-hour week: 11.5 h used".
Planning a summer job ("8 weeks, 5 days, 8 h") shows the exact date it would run out.

## Three core flows
1. Log a shift: date (default today), hours, job (remembered). Result: full/half/exempt.
2. Year overview: days left (full-day equivalents), this week's hours vs 20, this
   month's pay vs the Minijob limit if the job is a Minijob, list of shifts by month.
3. Plan ahead: a what-if schedule (weeks x days x hours) shows the run-out date and
   what remains for the rest of the year; not saved as shifts unless confirmed.

## Left out
Clock-in timers, reminders/notifications, payslips, tax, sync, export beyond a plain
text/CSV share of the year's log (share sheet only if a pure path exists; otherwise
copy to clipboard). No legal advice.

## Data model
- Job { id, name, kind: regular | minijob | universityExempt, hourlyRate? }
- Shift { id, jobId, date, hours (decimal), note? }
- Settings { fullDayLimit=140, halfDayThresholdHours=4, weeklyHourLimit=20,
  minijobMonthlyLimitByYear {2026: 603, 2027: 633}, weekMethodEnabled=false }
- Derived per year: fullDays, halfDays, equivalents used/left, run-out date for a plan.
Stored as one JSON file via path_provider.

## Content needs and honesty
Only a handful of numbers, all editable in Settings with a one-line source hint
("from the Zusatzblatt to your residence permit; your Ausländerbehörde decides").
The optional 2.5-days-per-week method (some Ausländerbehörden count the more favorable
of the two per week) stays off by default and is explained plainly. No claims beyond
"this counts what you enter".

## Risks
- Rules change (they did in 2024): editable limits, dated "rules as of" line.
- Narrow audience (non-EU students in Germany: a few hundred thousand), but high intent
  and easy App Store search terms (140 days, Werkstudent, student visa work).
- Must not look like an hours tracker: the quota number is the hero, not the hours.

## Design
Accent: indigo #3949AB (light) / #8C9EFF (dark).
Personality: a calm payroll clerk who counts exactly and never lectures.

## Name
"Halfday": no App Store app found by that name (searched 2026-09-23; near names:
Halfway, HALF-TIME, Little Halfday focus app). Check again before submission.
Checked again 2026-09-24: still no App Store app named "Halfday"; store name
"Halfday: Student Work Days", home-screen name "Halfday".
