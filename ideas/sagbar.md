# Idea: Prepared German lines for appointments (working name "Sagbar")

Date: 2026-09-23. Stage: Discover, candidate (passes the wedge test, medium confidence).

## Pain (Arda first)
Arda speaks little German yet. At the Bürgeramt, the Ausländerbehörde, the doctor's
reception, the bank or on the phone with the landlord, he needs five or six exact
sentences that contain his own details: name spelling, date of birth, address, the
Aktenzeichen from a letter, his insurance number, "I have an appointment at 10:40".
Translator apps translate what he types in the moment, under stress, and the clerk
waits. Phrasebooks are tourist sentences with no personal details.

## Competitors (searched 2026-09-23)
- Apple Translate / Google Translate: live translation, but nothing is prepared; you
  retype your address every time and cannot show a clean card with it.
- Phrasebooks: Learn German - Phrasebook, German Phrasebook (Travel), Simply Learn
  German. Tourist categories (bars, colors, driving), fixed text, no personal fields,
  many behind paywalls.
- LingoCard: customizable phrase flashcards for learning, not for use at a counter.
- Bureaucracy phrase lists (GoetheCoach pack, lingoni, TheLernen): web pages or PDFs,
  one behind an email sign-up.

## Wedge (one sentence)
Unlike Translate or a phrasebook, Sagbar fills your own details (name, address,
Aktenzeichen, appointment time) into ready German lines for each real appointment and
shows them as a large card you can read aloud or hand over, offline, with an English
and Turkish meaning under each line.

## Why it can be great
The night before the Anmeldung, Arda opens "Bürgeramt: Anmeldung", every line already
contains "Arda Ertürk, Holtenauer Str. 12, 24105 Kiel". At the counter he taps a line
and it fills the screen in large type, readable across the desk.

## Three core flows
1. Me: a short list of personal fields (name, date of birth, address, phone, insurance
   number, IBAN last digits...), each optional, stored only on the device.
2. Situations: pick a situation (Bürgeramt, Ausländerbehörde, doctor reception,
   pharmacy, bank, landlord call, calling in sick to an employer), see its lines with
   fields filled in; add your own lines or a one-off field (Aktenzeichen, time).
3. Show: tap a line for a full-screen card in large type (landscape optional later),
   meaning below in English or Turkish; swipe to the next line; copy for a message.

## Left out
Speech output (native TTS), speech recognition, translation of free text, lessons,
quizzes, streaks, audio. Letters and forms (that is Paperpath's territory).

## Data model
- Profile { fields: Map<fieldKey, String> }
- Situation { id, titleKey or customTitle, lines: [LineId], builtIn }
- Line { id, germanTemplate with {fieldKey} slots, meaningEn, meaningTr, builtIn, hidden }
- Extra one-off values per situation { fieldKey: value }.
JSON via path_provider. Built-in content ships as a Dart constant.

## Content needs and honesty
About 8 situations x 6-8 lines, polite standard German (Sie form), reviewed for
naturalness; meanings in English and Turkish, UI in en/de/tr. Lines are generic
("Ich möchte mich anmelden.", "Mein Aktenzeichen ist {aktenzeichen}."), no legal or
medical advice, no claims about what an office requires. Every line editable.

## Risks
- Content quality decides everything: a stiff or wrong German line is worse than none.
  Needs a careful native-level review pass (fresh-eyes subagent, then Arda in Kiel).
- Translate apps are good and free; the wedge is preparation plus personal fields, and
  the listing must show that in the first screenshot.
- Storing personal details: device only, plain statement in the privacy policy.

## Design
Accent: burnt orange #C2410C (light) / #FF8A50 (dark).
Personality: a friend who writes your lines the night before and holds up the card.

## Name
"Sagbar" (German: "sayable"): no App Store app found by that name (searched
2026-09-23).
