import 'package:flathunt/model/board.dart';

/// "Now" for every golden and screenshot, so dates never drift: a Tuesday
/// morning in October.
final demoToday = DateTime(2026, 10, 6, 10);

const _titles = {
  'en': [
    'WG Room Near Campus',
    'Bright 1-Room Flat',
    'Room in a 3-Person WG',
    'Studentenwerk Dorm Room',
    'Sublet Until March',
    'Attic Flat With Balcony',
    'Cheap Room, Deposit First',
    'Room via a Friend',
  ],
  'de': [
    'WG-Zimmer nahe Campus',
    'Helle 1-Zimmer-Wohnung',
    'Zimmer in 3er-WG',
    'Wohnheimzimmer Studentenwerk',
    'Zwischenmiete bis März',
    'Dachwohnung mit Balkon',
    'Günstiges Zimmer, Kaution vorab',
    'Zimmer über eine Freundin',
  ],
  'tr': [
    'Kampüse Yakın WG Odası',
    'Aydınlık Tek Odalı Daire',
    '3 Kişilik WG’de Oda',
    'Studentenwerk Yurt Odası',
    'Mart’a Kadar Geçici Kira',
    'Balkonlu Çatı Katı',
    'Ucuz Oda, Önce Depozito',
    'Bir Arkadaş Aracılığıyla Oda',
  ],
};

DateTime _d(int day, [int hour = 10, int minute = 0]) =>
    DateTime(2026, 10, day, hour, minute);

Flat _flat(
  String id,
  String title,
  Source source, {
  int? warm,
  int? cold,
  double? size,
  String district = '',
  String link = '',
  String notes = '',
  Stage stage = Stage.interested,
  required DateTime since,
  DateTime? viewing,
  Set<Check> checks = const {},
}) => Flat(
  id: id,
  title: title,
  source: source,
  warmCents: warm == null ? null : warm * 100,
  coldCents: cold == null ? null : cold * 100,
  sizeSqm: size,
  district: district,
  link: link,
  notes: notes,
  stage: stage,
  stageSince: since,
  viewing: viewing,
  checks: checks,
  createdAt: DateTime(2026, 9, 28),
);

/// A student a week into the hunt in Kiel.
Board typicalBoard([String locale = 'en']) {
  final t = _titles[locale]!;
  return Board(
    nextId: 9,
    flats: [
      _flat(
        'f1',
        t[0],
        Source.wgGesucht,
        warm: 450,
        cold: 360,
        size: 16,
        district: 'Ravensberg',
        link: 'https://www.wg-gesucht.de/wg-zimmer-in-Kiel-Ravensberg.1234567.html',
        notes: 'Ask about the Wohnungsgeberbestätigung.',
        stage: Stage.viewing,
        since: _d(4),
        viewing: _d(8, 17, 30),
        checks: {Check.noPrepay},
      ),
      _flat(
        'f2',
        t[1],
        Source.immoscout,
        warm: 620,
        cold: 480,
        size: 28,
        district: 'Südfriedhof',
        stage: Stage.applied,
        since: _d(3),
        viewing: _d(2, 16),
        checks: {
          Check.viewed,
          Check.noPrepay,
          Check.accountInName,
          Check.idLater,
        },
      ),
      _flat(
        'f3',
        t[2],
        Source.kleinanzeigen,
        warm: 395,
        size: 14,
        district: 'Gaarden',
        stage: Stage.messaged,
        since: _d(2),
      ),
      _flat(
        'f4',
        t[3],
        Source.studentenwerk,
        warm: 310,
        size: 12.5,
        district: 'Westring',
        since: _d(5),
      ),
      _flat(
        'f5',
        t[4],
        Source.facebook,
        warm: 500,
        district: 'Holtenau',
        stage: Stage.messaged,
        since: _d(4),
      ),
      _flat(
        'f6',
        t[5],
        Source.immoscout,
        warm: 780,
        cold: 610,
        size: 42,
        district: 'Düsternbrook',
        stage: Stage.viewing,
        since: _d(1),
        viewing: _d(3, 11),
        checks: {Check.viewed},
      ),
      _flat(
        'f7',
        t[6],
        Source.facebook,
        warm: 250,
        size: 20,
        district: 'Blücherplatz',
        stage: Stage.declined,
        since: _d(3),
      ),
      _flat('f8', t[7], Source.friends, since: _d(5, 20)),
    ],
  );
}

/// Late in the hunt: long titles, every stage, an answer.
Board heavyBoard() {
  var b = typicalBoard();
  b = b.withFlat(
    b.flat('f2')!.copyWith(stage: Stage.accepted, stageSince: _d(6, 9)),
  );
  final extra = [
    (
      'Möbliertes Zimmer in ruhiger Lage direkt an der Kiellinie mit Blick auf die Förde',
      540,
      19.5,
      'Düsternbrook',
    ),
    ('Two Rooms, Shared Kitchen', 710, 36.0, 'Wik'),
    ('Room With Own Bathroom', 480, 18.0, 'Brunswik'),
    ('Tiny Room Above a Bakery', 330, 9.0, 'Gaarden'),
    (
      'Flat Share With Two Engineering Students, Available From November',
      420,
      15.0,
      'Hassee',
    ),
  ];
  var i = 0;
  for (final (title, warm, size, district) in extra) {
    final stage = [
      Stage.interested,
      Stage.messaged,
      Stage.viewing,
      Stage.viewing,
      Stage.declined,
    ][i];
    b = b.add(
      (id) => _flat(
        id,
        title,
        Source.values[i % Source.values.length],
        warm: warm,
        size: size,
        district: district,
        stage: stage,
        since: _d(1 + i),
        viewing: i == 2 ? _d(12, 18) : null,
      ),
    );
    i++;
  }
  return b;
}
