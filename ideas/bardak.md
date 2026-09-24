# Idea: Turkish recipe measures to grams, with German packet sizes (working name "Bardak")

Date: 2026-09-24. Stage: Discover, candidate (passes the wedge test, medium confidence).

## Pain (Arda first)
Arda cooks cheaply in Kiel from the recipes his mother sends on WhatsApp and from Turkish
recipe sites: "2 su bardağı un, 1 çay bardağı sıvı yağ, 1 paket kabartma tozu, 3 yemek
kaşığı yoğurt". His German kitchen has a scale and a measuring jug, not his mother's
glass. Worse, the packets differ: a Turkish kabartma tozu packet is 10 g, a German
Backpulver Päckchen (Dr. Oetker Backin) is 16 g, sized for 500 g flour; a Turkish
vanilin sachet is usually 5 g, a German Vanillinzucker 8 g. Following the recipe
literally with German packets makes a cake taste of baking powder. The reverse also
happens: he wants to send his mother a German recipe in bardak and kaşık.

## Competitors (searched 2026-09-24)
- Apple (Spotlight / Calculator unit conversion): cups and ml only, no ingredient density,
  knows nothing about su bardağı (200 ml) or çay bardağı (about 100 ml).
- Gramwise: per-ingredient cups-to-grams with a recipe-paste parser, English only, US
  cups (240 ml), no Turkish units, words or packets.
- Useful Units Recipe Converter and Cooking Units Converter (Units): 300-400 ingredients
  with densities, US/UK/AU/FR/DE measures; no Turkish measures, no Turkish text parsing.
- Kitchen Converter & Recipes: 35 ingredients, English.
- Turkish "mutfak ölçüleri" tables exist only as web pages (lezzet, nefisyemektarifleri,
  yemek.com) and web converters; no App Store app was found for them.

## Wedge (one sentence)
Unlike Gramwise, Units or Apple's converter, Bardak reads a Turkish recipe as written
(su bardağı, çay bardağı, yemek/tatlı/çay kaşığı, paket, tutam) and turns every line into
grams or millilitres for the actual ingredient, including the German packet equivalent,
and back again, offline.

## Why it can be great
Paste mother's message. Each line gets a quiet right-hand column: "2 su bardağı un ->
240 g", "1 paket kabartma tozu -> 10 g (about 2/3 Päckchen Backpulver)". A servings
stepper halves the whole recipe at once. The moment: the thing he could not trust
becomes a list he can put on the scale.

## Three core flows
1. Paste and convert: paste Turkish recipe text; a pure Dart parser finds amount
   (including "yarım", "1,5", "bir buçuk", "2-3"), unit and ingredient per line; unknown
   lines stay unchanged and marked; tap a line to fix ingredient or unit. Scale servings.
2. Quick line: pick amount, Turkish unit and ingredient; see grams/ml, plus the German
   shopping name (un -> Weizenmehl Type 405 or 550) and packet equivalent where relevant.
3. Reverse: type a German amount ("250 g Mehl") and see it in su bardağı and kaşık, to
   send home; copy result as text (Clipboard, no share plugin).
Saved recipes: a simple list of converted recipes (title, original text, servings).

## Left out
Recipe discovery, photos, meal planning, shopping lists, nutrition, OCR, other
languages' recipe text (only Turkish in, German and English UI hints), US cups. No
brand claims beyond "a common packet size" with the gram number shown.

## Data model
- Unit { id: suBardagi | cayBardagi | kahveFincani | yemekKasigi | tatliKasigi |
  cayKasigi | paket | tutam | gram | ml | adet, ml? }
- Ingredient { id, trNames[] (with inflections: un, unu; şeker, şekeri), deName, enName,
  gramsPerMl (density), packetGrams?, dePacketGrams?, note? }
- Recipe { id, title, originalText, servings, lines: ParsedLine[] }
- ParsedLine { raw, amount?, unitId?, ingredientId?, userOverride? }
Bundled ingredient table as a Dart const (about 60 items); recipes as one JSON file via
path_provider.

## Content needs and honesty
- Units: su bardağı 200 ml, çay bardağı 100 ml, yemek kaşığı 15 ml, tatlı kaşığı 10 ml,
  çay kaşığı 5 ml (the convention on major Turkish recipe sites; there is variation, so
  the UI says "about" and shows the assumption once).
- Densities: each ingredient's grams per su bardağı taken from at least two Turkish
  tables (lezzet.com.tr, nefisyemektarifleri.com, yemek.com) and checked against a
  density reference (USDA); where they disagree (flour 110-125 g, sifted or not), show
  the value used and the range. The sources list lives in the repo next to the table.
- Packets: Turkish kabartma tozu 10 g, vanilin 5 g, instant maya 10 g; German Backpulver
  16 g, Vanillinzucker 8 g, Trockenhefe 7 g; verified on manufacturer pages before build
  and dated in the app ("packet sizes as of 2026").
- Kitchen measures are approximate by nature: results rounded sensibly (5 g steps above
  50 g), never false precision.

## Risks
- Converter category is crowded; the wedge rests fully on Turkish units, Turkish text
  parsing and packet mapping. The audience (Turkish speakers abroad, about 3 million in
  Germany alone, plus people cooking from Turkish sites) searches in Turkish, so store
  copy and keywords must be Turkish-first.
- Parser quality is the product: build a test corpus of 100 real recipe lines first.
- Content effort (60 ingredients, two sources each) is the bulk of the work; keep the
  table small and correct rather than large.

## Design
Accent: tea red #B03A2E (light) / #FF8A7A (dark).
Personality: a calm older cousin who has cooked in both countries and just gives you the
number.

## Name
"Bardak" ("glass"): no App Store recipe or kitchen app by that name found (searched
2026-09-24; only a food-delivery app on Google Play). Store name idea "Bardak: Tarif
Ölçüleri Gram". Check again before submission.
