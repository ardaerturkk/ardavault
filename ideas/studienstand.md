# Idea: Degree progress under your exam regulations (working name "Studienstand")

Date: 2026-09-23. Stage: Discover, candidate (passes the wedge test, lower confidence).

## Pain (Arda first)
A German master's is a Prüfungsordnung: module groups with required ECTS (for example
"Compulsory 45, Electives 30, Seminar 5, Thesis 30"), an ECTS-weighted final grade on
the 1.0-5.0 scale where 5.0 earns nothing, and usually two or three attempts per exam,
the last one before exmatriculation. The university portal lists results but does not
answer "what do I still need, which exam is my last attempt, and what final grade can
I still reach". Arda starts in Kiel in the winter semester and will plan electives
every semester.

## Competitors (searched 2026-09-23)
- module.org: loads published module plans, grade goal, credit account, calendar sync.
  Depends on its catalog of programs; no attempt counter found; account-free but online.
- Credit Points (App Store): credits and weighted average per module; no module groups
  with requirements, no attempts, no projection.
- Studo: campus app (timetable, mail, menus) for 400+ universities, not a degree plan.
- Web ECTS calculators (notenrechner-online, ects-rechner.de) and a GitHub web tracker
  for one Oldenburg program: one-off averages, nothing personal and persistent.
- University portals (QIS, AlmaWeb): official, but no planning or what-if.

## Wedge (one sentence)
Unlike the university portal, module.org or a grade calculator, Studienstand models
your own exam regulations (module groups with required ECTS, attempts per exam, 5.0
rules) and answers what is still missing, which exam is a last attempt, and the best
and worst final grade you can still reach, offline and without a catalog or account.

## Why it can be great
Enter a 1.7 for a 6-ECTS module: the group bar fills, "Electives: 12 of 30 ECTS" moves,
and the range line updates to "Final grade can still be 1.4 to 2.6". A failed attempt
shows "Attempt 2 of 3" in plain secondary text, no alarm colors.

## Three core flows
1. Set up the program once: groups with required ECTS and max attempts (defaults 3),
   thesis weight if different; a blank template plus one example.
2. Add modules and results: name, ECTS, group, attempts with date and grade (or pass/fail
   without grade).
3. Overview: ECTS per group vs required, weighted average so far, best/worst reachable
   final grade, list of open modules and any last-attempt warnings.

## Left out
Timetables, calendar sync, exam reminders, module catalogs, portal import, grade
conversion for applications (modified Bavarian formula), semesters as a hard structure.

## Data model
- Program { name, groups: [Group], defaultMaxAttempts, gradeScale 1.0-5.0 }
- Group { id, name, requiredEcts, countsTowardGrade: bool, weight=1 }
- Module { id, name, ects, groupId, graded: bool, attempts: [Attempt] }
- Attempt { date, grade? (1.0..5.0), passed }
Derived: earned ECTS per group, weighted average, reachable range.
JSON via path_provider.

## Content needs and honesty
Almost none: rules come from the user. Explain the formula once (sum of grade x ECTS
over sum of ECTS) and that some regulations weight modules differently, so weights are
editable. No claims about any university's rules.

## Risks
- module.org already covers credits and grade goals; the wedge rests on groups,
  attempts and the reachable range. If Arda's program portal already shows this,
  confidence drops. Ask him after his first semester registration.
- Setup effort: the first flow must be under two minutes.
- Seasonal use (after each exam period), which is fine for a free utility.

## Design
Accent: green #1E7B4F (light) / #4CC38A (dark).
Personality: a sober study adviser with a pencil, who shows the numbers and stops.

## Name
"Studienstand": no App Store app found by that name (searched 2026-09-23).
