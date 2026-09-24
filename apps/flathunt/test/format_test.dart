import 'package:flathunt/l10n/app_localizations.dart';
import 'package:flathunt/model/board.dart';
import 'package:flathunt/ui/format.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  final en = lookupAppLocalizations(const Locale('en'));
  final de = lookupAppLocalizations(const Locale('de'));
  final tr = lookupAppLocalizations(const Locale('tr'));

  setUpAll(() async {
    await initializeDateFormatting('de');
    await initializeDateFormatting('tr');
  });

  test('money: whole euros without decimals, cents with two', () {
    expect(money(en, 48000), '€480');
    expect(money(en, 48050), '€480.50');
    expect(money(en, 120000), '€1,200');
    expect(money(de, 48050), '480,50 €');
    expect(money(tr, 48000), contains('480'));
  });

  test('per m² always has cents', () {
    expect(moneyExact(en, 2812.5), '€28.13');
    expect(moneyExact(de, 2500), '25,00 €');
  });

  test('sizes', () {
    expect(sizeNumber(en, 18), '18');
    expect(sizeNumber(en, 12.5), '12.5');
    expect(sizeNumber(de, 12.5), '12,5');
  });

  test('editable values round-trip through the parser', () {
    for (final l in [en, de, tr]) {
      for (final cents in [48000, 48050, 123456]) {
        expect(parseCents(editableCents(l, cents)), cents);
      }
      expect(parseSize(editableSize(l, 12.5)), 12.5);
    }
    expect(editableCents(de, 48050), '480,50');
    expect(editableCents(en, null), '');
  });

  test('stage line says where a flat stands', () {
    final now = DateTime(2026, 10, 6, 10);
    Flat f(Stage s, {DateTime? viewing}) => Flat(
      id: 'f1',
      title: 'X',
      stage: s,
      stageSince: DateTime(2026, 10, 2, 9),
      viewing: viewing,
      createdAt: DateTime(2026, 10),
    );
    expect(stageLine(en, f(Stage.interested), now), 'Added Oct 2');
    expect(stageLine(en, f(Stage.messaged), now), 'Messaged Oct 2');
    expect(stageLine(en, f(Stage.viewing), now), 'No viewing time yet');
    expect(
      stageLine(
        en,
        f(Stage.viewing, viewing: DateTime(2026, 10, 8, 17, 30)),
        now,
      ),
      'Viewing Thu, Oct 8, 17:30',
    );
    expect(
      stageLine(
        en,
        f(Stage.viewing, viewing: DateTime(2026, 10, 3, 11)),
        now,
        use24h: false,
      ),
      matches(RegExp(r'^Viewed Sat, Oct 3, 11:00.AM$')),
    );
    expect(stageLine(de, f(Stage.applied), now), 'Beworben 2. Okt.');
  });

  test('every stage but the answers has a next action', () {
    for (final s in Stage.values) {
      expect(nextActionLabel(en, s) == null, s.isAnswer);
    }
  });
}
