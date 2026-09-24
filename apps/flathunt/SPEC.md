# Flatboard: spec

Personality: a level-headed friend who keeps every flat on one list and your guard up.
Accent: house-door green (light #0E7C66, dark #1C9A7F). Everything else is system colors.

## User and job
A student looking for a room or flat in a German university town (first: Arda, moving
to Kiel). Listings come from many places: WG-Gesucht, Kleinanzeigen, ImmoScout24,
Facebook groups, the Studentenwerk, friends. Job: "Show me every flat I am chasing,
where I stand with each, when my next viewing is, which one is really cheapest, and
whether an offer smells like a scam."

Wedge: portal apps only track their own listings; Notes and spreadsheets have no
pipeline, no viewing view and no rent comparison. Flatboard is one offline pipeline for
flats from every source, with warm rent per month and per square metre side by side and
a careful scam checklist on every flat.

## Core flows
1. Add a flat. Flats tab, "+" (or "Add Flat" in the empty state). Title is the only
   required field. Source (picked from a short list), link (stored as text, copyable),
   warm rent, cold rent, size in m², district, notes. New flats start in Interested.
2. Move it forward. A flat opens to its detail page. The pinned bottom button is the
   next stage: Interested > Messaged > Viewing > Applied > Answer (Accepted or
   Declined). Moving to Viewing asks for the viewing time (or "Set Time Later").
   Stage can also be set directly (Stage row, action sheet). The Flats list groups flats
   by what needs the user next: Accepted, Viewing, Applied, Messaged, Interested,
   Declined. Viewing lists upcoming viewings soonest first (date in the accent color),
   then flats without a time, then past viewings in grey, most recent first.
3. Compare. Compare tab lists every flat that is not declined, sorted by warm rent per
   month or per m² (segmented control), cheapest first, with a thin proportional bar.
   Flats missing warm rent or size are listed below with what is missing.

Scam checklist on every flat detail page: five generic, careful checks the user ticks
once confirmed (viewed in person; no money before viewing and signed contract; payment
only to an account in the landlord's name in Germany, never via cash transfer services;
ID copy only once the contract is ready; rent plausible for the area). Footer says a
"no" on any is a common warning sign and points to the Studentenwerk or local
Mieterverein. The Flats list shows a flat's progress on the checks nowhere else: it is
a per-flat tool, not a score.

## Left out (v1)
Opening links (would need url_launcher; the link is copyable text instead), photos,
maps, notifications (native plugin), import from portals (network), document lists
(Paperpath's job), multiple searches, sync, iPad, landscape, currencies other than EUR.

## Data model (JSON file `flathunt.json` in the app documents directory)
- Board: version, nextId, flats[].
- Flat: id, title, source (key: wgGesucht, kleinanzeigen, immoscout, facebook,
  studentenwerk, friends, other), link, warmCents (int?), coldCents (int?), sizeSqm
  (double?), district, notes, stage (interested, messaged, viewing, applied, accepted,
  declined), stageSince (date-time), viewing (date-time?), checks (list of check keys
  confirmed), createdAt.
- Derived: warm per m² (cents per m²), next stage, sorted sections, compare order.
- Money is stored as integer euro cents; input accepts "480", "480,50", "1.200",
  "1,200.50", "480,-", with or without € or EUR.

## Dependencies
- flutter_localizations, intl (SDK / Dart team): localized dates, money and strings.
- path_provider: the one plugin with native iOS code. Needed to find the app's documents
  directory for the JSON file. Maintained by the Flutter team; iOS implementation is
  path_provider_foundation (no permissions, no data leaves the device). Required-reason
  API: file timestamps declared (C617.1) to be safe.
- Clipboard (Copy Link) is part of Flutter's services library, no plugin.
- No other packages. No network access at all.
