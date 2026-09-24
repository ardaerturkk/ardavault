# Sagbar: spec

Personality: a friend who writes your lines the night before and holds up the card.
Accent: burnt orange (light #C2410C, dark #FF8A50). Everything else is system colors.

## User and job
A newcomer in Germany with little German yet (first: Arda, a Turkish master's student in
Kiel). Job: "Give me the exact German sentences for this appointment, with my own details
already in them, so I can read them out or hold up the phone."

## Core flows
1. My Details: a short list of optional fields (full name, date of birth, address,
   phone, email, health insurer, insurance number, student number). Stored only on the
   device. The Situations tab teaches this first action until something is filled in.
2. Prepare a situation: pick one of 8 situations (Allgemein, Bürgeramt,
   Ausländerbehörde, Bank, Krankenkasse, Arztpraxis, Vermieter, Hochschule). Its 7-8
   German lines show with the details filled in (highlighted in the accent) and the
   meaning underneath. Situations with a visit get "This Visit": appointment date and
   time, and the reference number under its German name (Vorgangsnummer, Aktenzeichen,
   Kundennummer). Missing details are listed in one row that opens the right editor.
   Add your own lines; hide built-in lines you do not need (and show them again).
3. Show: tap a line (or Show Cards) for a full-screen card in large type, meaning below,
   swipe or use the arrows to move between lines, copy a line for a message.

## Language rules
- The German lines never change with the UI language. Meanings show in the UI language
  (English or Turkish); with a German UI the English meaning is shown.
- Dates inside German lines are written the spoken way ("12. März 2001"), times are
  24-hour ("10:40 Uhr"). Meanings use the numeric date ("12.03.2001").
- Lines are generic, polite Standard German (Sie form), no legal or medical claims.

## Left out (v1)
Speech output (native TTS plugin), speech recognition, free-text translation, lessons,
quizzes, custom situations, detail slots inside the user's own lines, keeping the screen
awake on the card (needs a plugin), sync, iPad, landscape. Paperwork steps and document
checklists belong to Paperpath and are not duplicated here.

## Data model (JSON file `sagbar.json` in the app documents directory)
- Book: version, profile {slotName: text}, birthDate (date), visits {situationId:
  Visit}, custom [CustomLine], hidden [builtInLineId], nextId.
- Visit: ref (text), appointment (date-time).
- CustomLine: id, situation, german, meaning.
- Built-in content (situations, lines with {slot} templates, en/tr meanings, purposes
  in en/de/tr) is a Dart constant in lib/model/content.dart.

## Dependencies
- flutter_localizations, intl (SDK / Dart team): localized strings and UI dates.
- path_provider: the one plugin with native iOS code, to find the documents directory
  for the JSON file. Maintained by the Flutter team; no permissions, no network.
- Copy uses Flutter's built-in Clipboard service (no plugin).
- No other packages. No network access at all.
