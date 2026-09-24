import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sagbar/model/book.dart';
import 'package:sagbar/model/content.dart';

String plain(List<Piece> pieces) =>
    pieces.map((p) => p.text ?? '[${p.slot!.name}]').join();

void main() {
  final amt = situationById('buergeramt')!;
  final arda = const Book()
      .withDetail(Slot.name, 'Arda Ertürk')
      .withDetail(Slot.address, 'Holtenauer Straße 12, 24105 Kiel')
      .copyWith(birthDate: DateTime(2001, 3, 12));

  group('formats', () {
    test('German dates and times', () {
      expect(germanDate(DateTime(2001, 3, 12)), '12. März 2001');
      expect(germanDate(DateTime(2026, 10, 3), withYear: false), '3. Oktober');
      expect(numericDate(DateTime(2001, 3, 2)), '02.03.2001');
      expect(numericDate(DateTime(2026, 10, 14), withYear: false), '14.10.');
      expect(germanTime(DateTime(2026, 10, 14, 9, 5, 30)), '09:05');
    });

    test('names are spelled letter by letter', () {
      expect(spellName(' Arda  Ertürk '), 'A-R-D-A, E-R-T-Ü-R-K');
      expect(spellName('Li'), 'L-I');
    });
  });

  group('content', () {
    test('eight situations with five to eight lines each', () {
      expect(situations, hasLength(8));
      for (final s in situations) {
        expect(s.lines.length, inInclusiveRange(5, 8), reason: s.id);
      }
    });

    test('ids are unique and every slot is known', () {
      final ids = <String>{};
      final names = {for (final s in Slot.values) s.name};
      for (final s in situations) {
        for (final l in s.lines) {
          expect(ids.add(l.id), isTrue, reason: l.id);
          expect(l.id.startsWith('${s.id}:'), isTrue);
          for (final text in [l.german, l.en, l.tr]) {
            for (final m in RegExp(r'\{(\w+)\}').allMatches(text)) {
              expect(names, contains(m.group(1)), reason: l.id);
            }
          }
          // The meaning uses the same details as the German line.
          Set<String> slots(String t) => {
            for (final m in RegExp(r'\{(\w+)\}').allMatches(t)) m.group(1)!,
          };
          expect(slots(l.en), slots(l.german), reason: l.id);
          expect(slots(l.tr), slots(l.german), reason: l.id);
        }
      }
    });

    test('ref and time slots only where the situation has them', () {
      for (final s in situations) {
        for (final l in s.lines) {
          if (l.german.contains('{ref}')) {
            expect(s.refLabel, isNotNull, reason: l.id);
            expect(l.german, contains(s.refLabel), reason: l.id);
          }
          if (l.german.contains('{time}') || l.german.contains('{date}')) {
            expect(s.hasAppointment, isTrue, reason: l.id);
          }
        }
      }
    });

    test('lines are polite and plain', () {
      for (final s in situations) {
        for (final l in s.lines) {
          expect(l.german, isNot(contains('!')));
          expect(l.german, isNot(matches(RegExp(r'\b(du|dich|dir|dein)\b'))));
          expect(l.german.trim(), l.german);
          expect(RegExp(r'[.?:]$').hasMatch(l.german), isTrue, reason: l.id);
        }
      }
    });
  });

  group('filling', () {
    test('details fill the German line', () {
      expect(
        plain(arda.fill('Ich bin am {birthDate} geboren.', amt.id)),
        'Ich bin am 12. März 2001 geboren.',
      );
      expect(
        plain(arda.fill('Meine neue Adresse lautet: {address}.', amt.id)),
        'Meine neue Adresse lautet: Holtenauer Straße 12, 24105 Kiel.',
      );
    });

    test('meanings get the numeric date', () {
      expect(
        plain(arda.fill('Doğum tarihim {birthDate}.', amt.id, numeric: true)),
        'Doğum tarihim 12.03.2001.',
      );
    });

    test('missing values stay visible as slots', () {
      final pieces = const Book().fill('Mein Name ist {name}.', amt.id);
      expect(pieces, hasLength(3));
      expect(pieces[1].isMissing, isTrue);
      expect(pieces[1].slot, Slot.name);
    });

    test('unknown braces are kept as text', () {
      expect(
        plain(arda.fill('Code {abc} and {name}', amt.id)),
        'Code {abc} and Arda Ertürk',
      );
    });

    test('visit values fill ref, time and date', () {
      final b = arda.withVisit(
        amt.id,
        Visit(ref: 'KI-2026-0415', appointment: DateTime(2026, 10, 14, 10, 40)),
      );
      expect(
        plain(b.fill('um {time} Uhr am {date}, Nr. {ref}', amt.id)),
        'um 10:40 Uhr am 14. Oktober, Nr. KI-2026-0415',
      );
      // Another situation has its own visit.
      expect(b.valueFor(Slot.time, 'bank'), isNull);
    });

    test('missing details list what the situation needs, in order', () {
      expect(const Book().missingFor(amt, 'en'), [
        Slot.birthDate,
        Slot.address,
        Slot.ref,
        Slot.time,
      ]);
      // Spelling asks for the name.
      expect(const Book().missingFor(situations.first, 'en'), [Slot.name]);
      expect(arda.missingFor(situations.first, 'en'), isEmpty);
    });
  });

  group('editing', () {
    test('empty details are removed', () {
      final b = arda.withDetail(Slot.name, '  ');
      expect(b.detail(Slot.name), isNull);
      expect(b.profile.containsKey('name'), isFalse);
    });

    test('own lines: add, edit, remove', () {
      var b = arda.addLine(amt.id, ' Hallo. ', ' Hello ');
      expect(b.custom.single.german, 'Hallo.');
      final id = b.custom.single.id;
      b = b.editLine(id, 'Guten Tag.', '');
      expect(b.customLine(id)!.german, 'Guten Tag.');
      expect(b.linesFor(amt, 'en').last.isCustom, isTrue);
      b = b.addLine('bank', 'Danke.', '');
      expect(b.custom.last.id, isNot(id));
      b = b.removeLine(id);
      expect(b.custom.single.situationId, 'bank');
    });

    test('hiding and showing built-in lines', () {
      var b = arda.hide('buergeramt:2').hide('buergeramt:7').hide('bank:1');
      expect(b.linesFor(amt, 'en'), hasLength(amt.lines.length - 2));
      expect(b.hiddenCount(amt.id), 2);
      b = b.unhideAll(amt.id);
      expect(b.hiddenCount(amt.id), 0);
      expect(b.hidden, {'bank:1'});
    });

    test('meanings follow the language, German falls back to English', () {
      expect(arda.linesFor(amt, 'tr').first.meaning, amt.lines.first.tr);
      expect(arda.linesFor(amt, 'de').first.meaning, amt.lines.first.en);
    });

    test('clearing a visit removes it', () {
      final b = arda
          .withVisit('bank', const Visit(ref: '1'))
          .withVisit('bank', const Visit());
      expect(b.visits, isEmpty);
    });
  });

  test('JSON round trip', () {
    final b = arda
        .withVisit(
          amt.id,
          Visit(ref: 'X1', appointment: DateTime(2026, 10, 14, 10, 40)),
        )
        .addLine(amt.id, 'Danke.', 'Thanks')
        .hide('bank:3');
    final again = Book.fromJson(
      (jsonDecode(jsonEncode(b.toJson())) as Map).cast<String, Object?>(),
    );
    expect(again.detail(Slot.name), 'Arda Ertürk');
    expect(again.birthDate, DateTime(2001, 3, 12));
    expect(again.visit(amt.id).ref, 'X1');
    expect(again.visit(amt.id).appointment, DateTime(2026, 10, 14, 10, 40));
    expect(again.custom.single.meaning, 'Thanks');
    expect(again.hidden, {'bank:3'});
    expect(again.nextId, 2);
    expect(Book.fromJson(const {}).hasProfile, isFalse);
  });
}
