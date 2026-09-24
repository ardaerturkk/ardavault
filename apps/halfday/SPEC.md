# Halfday: spec

Personality: a calm payroll clerk who counts exactly and never lectures.
Accent: indigo (light #3949AB, dark #8C9EFF). Everything else is system colors.

## User and job
A student from outside the EU working in Germany on a student residence permit (first:
Arda, a Turkish master's student in Kiel with a Werkstudent job or Minijob). Typical
rule: 140 full or 280 half working days per calendar year; a day with more than 4 hours
is a full day, up to 4 hours a half day; student-assistant jobs at the university are
usually not counted. Job: "Tell me how many days I have left, and when my plan runs out."

## Core flows
1. Log a shift: date (default today), job (last one remembered), duration on a wheel.
   The editor shows live how the day counts: full, half or not counted, including other
   shifts on the same date (two 3-hour shifts on one day make one full day).
2. Year overview: the hero is the days left this calendar year (full-day equivalents,
   so 118.5 means 118 full days and one half day). Below: used days split into full and
   half, hours this week against the weekly limit (lecture period), and this month's
   Minijob pay against that year's Minijob limit when a Minijob exists. The Shifts tab
   lists every shift by month with its day status.
3. Plan ahead: start date, weeks, days per week, hours per day and job. Shows the date
   the limit would be reached (or "fits"), how far over it goes, and what is left in the
   year after the plan. Planned days only become shifts after "Add as Shifts".

Settings: jobs (regular, Minijob with hourly pay, university job not counted) and every
limit (full days per year, half-day threshold, weekly hours, Minijob limit per year),
with "Restore Typical Values" and a plain "How Halfday Counts" page. Legal wording stays
generic: "typical rules; your residence permit and the Ausländerbehörde decide".

## Counting rules (lib/model/quota.dart)
- Days are calendar dates (stored "yyyy-mm-dd"), never instants. The quota resets on
  1 January. Shifts of counted jobs on the same date are added up first.
- A date with more than `halfDayMaxMinutes` counted minutes is a full day, with more than
  zero a half day. Counting is in half-day units (full = 2) so there is no rounding.
- Days left = fullDayLimit - (full + half / 2). Shifts dated later this year are counted
  too (they are planned work) and marked as upcoming.
- Weeks run Monday to Sunday and may span New Year. Weekly hours include every job.
- Plan: from the start date, walk calendar days; a day is a work day when its weekday
  (Monday = 1) is at most "days per week". It continues until weeks x days work days
  are placed. Planned hours add to shifts already logged on that date. The run-out date
  is the first date on which the year's used days reach the limit; "over" starts on the
  first date that exceeds it. A plan that crosses New Year counts each year separately.

## Left out (v1)
The alternative 2.5-days-per-week method (some offices use it; it is explained on the
How It Counts page but not computed), notifications and reminders (need a native
plugin), clock-in timers, payslips and tax, export, sync, iPad, landscape. No legal
advice.

## Data model (JSON file `halfday.json` in the app documents directory)
- Book: version, jobs[], shifts[], settings, lastJobId?
- Job: id, name, kind (regular | minijob | university), rateCents? (hourly pay).
- Shift: id, jobId, date ("yyyy-mm-dd"), minutes (int), note.
- Settings: fullDayLimit=140, halfDayMaxMinutes=240, weeklyHourLimit=20,
  minijobLimits {2026: 603, 2027: 633} (euros per month; a missing year uses the latest
  earlier year).
- Derived: per-year usage, day status per date, weekly hours, monthly Minijob pay, plan
  result.

## Dependencies
- flutter_localizations, intl (SDK / Dart team): localized dates, numbers, currency.
- path_provider: the one plugin with native iOS code. Needed to find the app's documents
  directory for the JSON file. Maintained by the Flutter team, used by most apps;
  path_provider_foundation asks for no permissions and sends nothing. Required-reason
  API: file timestamps (C617.1) declared to be safe.
- No other packages. No network access at all.
