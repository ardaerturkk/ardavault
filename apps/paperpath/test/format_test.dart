import 'package:flutter_test/flutter_test.dart';
import 'package:paperpath/l10n/app_localizations_en.dart';
import 'package:paperpath/ui/format.dart';

void main() {
  final l = AppLocalizationsEn();

  test('due labels', () {
    final today = DateTime(2026, 10, 6, 23, 30);
    expect(dueLabel(l, null, today), isNull);
    expect(dueLabel(l, DateTime(2026, 10, 6), today)!.$1, 'Due today');
    expect(dueLabel(l, DateTime(2026, 10, 7), today)!.$1, 'Due tomorrow');
    expect(dueLabel(l, DateTime(2026, 10, 9), today)!.$1, 'Due in 3 days');
    expect(dueLabel(l, DateTime(2026, 10, 9), today)!.$2, DueTone.soon);
    expect(dueLabel(l, DateTime(2026, 10, 15), today)!.$2, DueTone.normal);
    expect(dueLabel(l, DateTime(2026, 10, 4), today)!.$1, '2 days overdue');
  });

  test('day counts ignore clock changes', () {
    // Europe: clocks go forward on 28 Mar 2027 and back on 25 Oct 2026.
    expect(
      dueLabel(l, DateTime(2027, 3, 29), DateTime(2027, 3, 28))!.$1,
      'Due tomorrow',
    );
    expect(
      dueLabel(l, DateTime(2026, 11, 3), DateTime(2026, 10, 20))!.$1,
      'Due in 14 days',
    );
    expect(
      dueLabel(l, DateTime(2026, 10, 27), DateTime(2026, 10, 24))!.$1,
      'Due in 3 days',
    );
  });

  test('needs label', () {
    expect(needsLabel(l, []), isNull);
    expect(needsLabel(l, ['A']), 'Needs A');
    expect(needsLabel(l, ['A', 'B', 'C']), 'Needs A and 2 more');
  });
}
