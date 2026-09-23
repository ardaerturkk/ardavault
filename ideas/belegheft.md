# Idea: Year-round study cost log for the German tax return (working name "Belegheft")

Date: 2026-09-23. Stage: Discover, candidate (passes the wedge test, lower confidence).

## Pain (Arda first)
A master's after a first degree usually counts as a second education in Germany: study
costs are Werbungskosten, and with little income they become a loss carried forward
(Verlustvortrag) that lowers tax once Arda works in Germany. That can be worth hundreds
or thousands of euros, but only if he can list the costs years later: the move from
Turkey, the laptop, books, semester fees, travel to the university, a German course,
application costs. Receipts end up in a drawer, bank statements mix TRY and EUR, and
nobody remembers which paper belongs to which cost.

## Competitors (searched 2026-09-23)
- MeinELSTER+ (official, free): photograph receipts and sort them, but needs an ELSTER
  account and certificate, is photo-first, and knows nothing about study-specific
  categories or the loss carried forward.
- Taxfix / WISO Steuer / Steuerbot: file the return once a year with an account; they
  do not help you collect costs during the year, and filing features are paid.
- Receipt scanners (meinBeleg, Kassenbelege, Mei Marie, Belege Steuer Nebenverdienst):
  built for freelancers and sellers, OCR and cloud sync, business categories.
- Notes / spreadsheets: no categories, no per-year totals, no link to the paper.

## Wedge (one sentence)
Unlike MeinELSTER+, Taxfix or a receipt scanner, Belegheft is a calm offline log made
for students: each study cost goes into the category the tax form asks for (work
equipment, literature, travel, fees, move), gets a number to write on the paper
receipt, and adds up per tax year so the totals are ready to type into ELSTER.

## Why it can be great
Log "Laptop, 899 EUR, work equipment": the app answers "Receipt 14. Write 14 on it."
The paper drawer becomes an ordered archive without a camera or a cloud. In spring,
one screen per tax year shows totals by category, ready to copy.

## Three core flows
1. Add a cost: date, amount (EUR, or TRY with a manual rate as text note), category,
   short description, share for study use (100% default, e.g. 50% for a laptop), gets
   the next receipt number of that year.
2. Tax year: totals per category with the list behind each, copy as plain text.
3. Find a receipt: search by number, text or amount; mark "paper missing" to see gaps.

## Left out
Photos and OCR (camera plugin), filing a return, tax calculation, advice on what is
deductible, depreciation schedules beyond one plain hint, sync, bank import.

## Data model
- Cost { id, taxYear, number, date, amountCents, currency, fxNote?, categoryId,
  description, studyShare (0-100), paperStatus: filed | missing | digital }
- Category { id, titleKey, formHint (e.g. "Anlage N, Werbungskosten") , builtIn }
- Year totals derived. JSON via path_provider.

## Content needs and honesty
Six to eight categories with a one-line plain description each, and a short, dated
"what usually counts" page that links nothing and says clearly: not tax advice, rules
can differ, ask a Lohnsteuerhilfeverein or the Finanzamt. No amounts or rates hard
coded as facts (distance allowance, depreciation) beyond editable hints.

## Risks
- Tax content is sensitive: a wrong hint costs users money. Keep hints general and
  sourced, and let the app be a log, not an advisor.
- Close to an expense tracker (killed category); the difference must show in every
  screen: tax categories, receipt numbers, tax years, no budgets or charts of spending.
- MeinELSTER+ is free and official; the wedge is "no account, student categories,
  numbered paper trail". If Arda already uses MeinELSTER+, confidence drops.

## Design
Accent: amber #9A6700 (light) / #E3A63B (dark).
Personality: a tidy accountant friend with a numbered folder, never a salesman.

## Name
"Belegheft" (receipt booklet): no App Store app found by that name (searched
2026-09-23; near names: Belegmeister, Beleger, meinBeleg).
