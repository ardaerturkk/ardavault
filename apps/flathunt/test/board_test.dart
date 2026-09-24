import 'package:flathunt/model/board.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/demo.dart';

Flat flat(
  String id, {
  int? warm,
  double? size,
  Stage stage = Stage.interested,
}) => Flat(
  id: id,
  title: id,
  warmCents: warm,
  sizeSqm: size,
  stage: stage,
  stageSince: DateTime(2026, 10),
  createdAt: DateTime(2026, 10),
);

void main() {
  group('parseCents', () {
    test('plain and decimal amounts', () {
      expect(parseCents('480'), 48000);
      expect(parseCents('480,50'), 48050);
      expect(parseCents('480.5'), 48050);
      expect(parseCents(' 480 € '), 48000);
      expect(parseCents('€480'), 48000);
    });

    test('grouping in either style', () {
      expect(parseCents('1.200'), 120000);
      expect(parseCents('1,200'), 120000);
      expect(parseCents('1.200,50'), 120050);
      expect(parseCents('1,200.50'), 120050);
    });

    test('rejects nonsense and empty input', () {
      expect(parseCents(''), isNull);
      expect(parseCents('abc'), isNull);
      expect(parseCents('4 8 0x'), isNull);
      expect(parseCents('-5'), isNull);
      expect(parseCents('.'), isNull);
    });
  });

  group('parseSize', () {
    test('sizes with and without unit', () {
      expect(parseSize('18'), 18);
      expect(parseSize('18,5'), 18.5);
      expect(parseSize('18.5 m²'), 18.5);
      expect(parseSize('42qm'), 42);
    });

    test('rejects zero and nonsense', () {
      expect(parseSize('0'), isNull);
      expect(parseSize('big'), isNull);
    });
  });

  test('warm per square metre', () {
    expect(flat('a', warm: 45000, size: 18).warmPerSqmCents, 2500);
    expect(flat('a', warm: 45000).warmPerSqmCents, isNull);
    expect(flat('a', size: 18).warmPerSqmCents, isNull);
  });

  test('next stage follows the pipeline and stops at the answer', () {
    expect(Stage.interested.next, Stage.messaged);
    expect(Stage.messaged.next, Stage.viewing);
    expect(Stage.viewing.next, Stage.applied);
    expect(Stage.applied.next, isNull);
    expect(Stage.accepted.next, isNull);
    expect(Stage.declined.isAnswer, isTrue);
  });

  test('add hands out fresh ids', () {
    var b = const Board();
    b = b.add(flat);
    b = b.add(flat);
    expect(b.flats.map((f) => f.id), ['f1', 'f2']);
    b = b.remove('f2').add(flat);
    expect(b.flats.last.id, 'f3');
  });

  test('moving stamps the time; staying keeps it', () {
    final now = DateTime(2026, 10, 6, 12);
    var b = const Board().add(flat);
    b = b.moveTo('f1', Stage.messaged, now);
    expect(b.flat('f1')!.stage, Stage.messaged);
    expect(b.flat('f1')!.stageSince, now);
    final later = DateTime(2026, 10, 7);
    final v = DateTime(2026, 10, 9, 17);
    b = b.moveTo('f1', Stage.viewing, later, viewing: v);
    expect(b.flat('f1')!.viewing, v);
    b = b.moveTo('f1', Stage.viewing, DateTime(2026, 10, 8), viewing: v);
    expect(b.flat('f1')!.stageSince, later);
    expect(b.moveTo('nope', Stage.applied, now), same(b));
  });

  test('toggling a check adds and removes it', () {
    var b = const Board().add(flat);
    b = b.toggleCheck('f1', Check.viewed);
    expect(b.flat('f1')!.checks, {Check.viewed});
    b = b.toggleCheck('f1', Check.viewed);
    expect(b.flat('f1')!.checks, isEmpty);
  });

  test('viewings sort by time, flats without a time last', () {
    final b = heavyBoard();
    final viewing = b.inStage(Stage.viewing);
    expect(viewing.first.id, 'f6');
    expect(viewing.last.viewing, isNull);
    for (var i = 1; i < viewing.length - 1; i++) {
      expect(viewing[i].viewing!.isAfter(viewing[i - 1].viewing!), isTrue);
    }
  });

  test('other stages sort by how long they waited', () {
    final messaged = typicalBoard().inStage(Stage.messaged);
    expect(messaged.map((f) => f.id), ['f3', 'f5']);
  });

  test('compare per month: cheapest first, declined left out', () {
    final (ranked, missing) = typicalBoard().compare(CompareBy.month);
    expect(ranked.map((f) => f.id), ['f4', 'f3', 'f1', 'f5', 'f2', 'f6']);
    expect(missing.map((f) => f.id), ['f8']);
  });

  test('compare per m²: flats without size are listed as missing', () {
    final (ranked, missing) = typicalBoard().compare(CompareBy.sqm);
    // 310/12.5=24.8, 450/16=28.1, 395/14=28.2, 620/28=22.1, 780/42=18.6
    expect(ranked.map((f) => f.id), ['f6', 'f2', 'f4', 'f1', 'f3']);
    expect(missing.map((f) => f.id), ['f5', 'f8']);
  });

  test('JSON round trip keeps everything', () {
    final b = typicalBoard();
    final again = Board.fromJson(b.toJson());
    expect(again.toJson(), b.toJson());
    final f = again.flat('f1')!;
    expect(f.viewing, DateTime(2026, 10, 8, 17, 30));
    expect(f.checks, {Check.noPrepay});
    expect(f.sizeSqm, 16);
    expect(again.flat('f4')!.sizeSqm, 12.5);
  });

  test('reading tolerates unknown values and a wrong nextId', () {
    final b = Board.fromJson({
      'nextId': 1,
      'flats': [
        {
          'id': 'f7',
          'title': 'X',
          'source': 'someday',
          'stage': 'weird',
          'checks': ['viewed', 'unknown'],
        },
      ],
    });
    final f = b.flat('f7')!;
    expect(f.source, Source.other);
    expect(f.stage, Stage.interested);
    expect(f.checks, {Check.viewed});
    expect(b.nextId, 8);
  });
}
