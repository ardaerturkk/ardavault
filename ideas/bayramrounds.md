# Idea: Bayram and family-day call rounds across time zones (working name "Bayram Rounds")

Date: 2026-09-24. Stage: Discover, candidate (passes the wedge test, medium confidence).

## Pain (Arda first)
On the first morning of Ramazan Bayramı and Kurban Bayramı, a Turkish family expects
bayramlaşma: you call the elders first (grandparents, uncles and aunts, parents' close
friends), then everyone else, within the first day or two. Forgetting an elder is noticed
and remembered. Arda is now in Kiel, one or two hours behind Turkey (Turkey is UTC+3 all
year, Germany switches between UTC+1 and UTC+2), in lectures on Bayram morning because it
is a normal German workday, and the dates move eleven days earlier every year so they
surprise him. The same applies, smaller, to Anneler Günü (same Sunday in both countries)
and Babalar Günü (third Sunday of June in Turkey, while German Vatertag is Ascension
Day), kandil nights for religious relatives, and birthdays. Today it is memory plus a
scroll through WhatsApp.

## Competitors (searched 2026-09-24)
- Apple Contacts / Reminders / Calendar: birthdays and one-off reminders; the Turkey
  holiday calendar shows the Bayram but there is no list of who to call and who is done.
- Personal CRMs: Dex, Keep, Reach, inTouch, Keep In Touch CRM, Covve. They schedule
  "contact every N weeks" per person; none has an occasion round (a checklist that opens
  for a Bayram, orders elders first and closes when done), none knows Bayram or kandil
  dates, several need accounts or iCloud and some use AI services.
- Bayram Mesajları apps (App Store and Google Play): ready-made greeting texts and
  pictures, ad-funded; no people, no tracking.
- World clock apps (Overlap, Time Zone Buddy, TimeBuddy): show whether it is a good time
  to call, not whom you still owe a call.

## Wedge (one sentence)
Unlike Contacts, a personal CRM or a Bayram message app, Bayram Rounds opens a call round
for each Bayram and family day with the correct dates in both calendars, puts elders
first, shows each person's local time, and ticks people off until nobody is forgotten,
offline and without an account.

## Why it can be great
The evening before Bayram (arefe), the app's home screen reads "Ramazan Bayramı starts
tomorrow. 14 people, 6 elders." On the morning, between lectures, Arda opens it: the list
is in the order his mother would expect, each row shows "09:40 in Ankara", and each tap
("Called", "Messaged") moves the person to the done section with a soft haptic. "3 left,
all cousins." The round closes by itself after the last Bayram day, and last Bayram's
round is still there to check ("Did I call Hasan amca at Kurban Bayramı?").

## Three core flows
1. People: add a person (name, relation, circle: elders / family / friends, time zone
   default Europe/Istanbul, which occasions they are in: both Bayrams by default,
   optionally kandil, Anneler Günü, Babalar Günü, their birthday). Reorder within circle.
2. Round: for the current or next occasion, the ordered checklist with local time per
   person; mark Called / Messaged / Visited or undo; note one line ("asked about exams").
3. Upcoming: the next occasions with Gregorian and Hijri date, day of week, days to go,
   and "arefe" for Bayrams; past rounds with who was reached.

## Left out
Calling or messaging from the app (url_launcher has native code; the user calls with
the phone or WhatsApp), notifications and reminders (native plugin), greeting-message
templates (ad-app territory and kitsch), contacts import (native plugin), prayer times,
fasting times, sync. No religious guidance.

## Data model
- Person { id, name, relation?, circle: elders | family | friends, timeZone (IANA id),
  occasions: Set<OccasionKind>, birthday?, order }
- OccasionKind { ramazanBayrami, kurbanBayrami, kandil (five kinds), anneler, babalar,
  birthday }
- Occasion { kind, startDate, endDate, arefe?, hijriLabel } (derived from bundled table
  or computed rule)
- Round { occasionKey (kind + year), entries: { personId, status: open | called |
  messaged | visited, at?, note? } }
Stored as one JSON file via path_provider.

## Content needs and honesty
- Bayram and kandil dates are not computed astronomically in the app. They are bundled as
  a table from Diyanet İşleri Başkanlığı's official "Dini Günler" lists
  (vakithesaplama.diyanet.gov.tr), which Diyanet publishes several years ahead, for every
  year it has published (target 2026-2031), each entry cross-checked against a second
  source (takvim.ihya.org or takvim.com) and a unit test with the table. The app shows
  "Dates from Diyanet's calendar, as of 2026" and, after the last bundled year, says so
  plainly and lets the user enter the date. Ramazan Bayramı 2026 = 20-22 March, Kurban
  Bayramı 2026 = 27-30 May, 2027: 9-11 March and 16-19 May (to be re-verified at build).
- Hijri labels come from the same table, not from a computed calendar.
- Anneler Günü (second Sunday of May) and Babalar Günü (third Sunday of June, Turkish
  rule) are computed; unit-tested for 2026-2035.
- Time zones: the `timezone` package (pure Dart, bundled IANA database) for local times;
  justified in SPEC.md. Turkey fixed at UTC+3 since 2016 is in the database.
- No government extra holidays (idari izin) are shown: they do not change when to call.

## Risks
- Audience is Turkish families abroad (about 3 million in Germany, plus the Netherlands,
  Austria, UK, US) and inside Turkey too; store copy must be Turkish-first. The app is
  seasonal (heavy use a few days a year), which is fine for a free, calm utility.
- Must not feel religious or preachy: it is about family, not worship; kandil is opt-in.
- Scope creep toward a CRM: keep only occasion rounds, no "contact every N weeks".
- Small core; polish is what makes it worth it (order, local time, round history).

## Design
Accent: plum #7A3E8E (light) / #CFA2E6 (dark).
Personality: a warm, organised aunt who knows the dates and never scolds.

## Name
"Bayram Rounds" (Turkish store name idea "Bayramlaşma Listesi"): no App Store app with
either name found (searched 2026-09-24; only Bayram message and Bayram FM apps). The
English word "Rounds" alone is too generic. Check again before submission.
