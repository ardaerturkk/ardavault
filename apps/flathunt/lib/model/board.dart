/// Data model: flats on their way from "interested" to an answer.
/// Everything is immutable; edits return a new [Board].
library;

enum Stage { interested, messaged, viewing, applied, accepted, declined }

/// Where a listing was found.
enum Source {
  wgGesucht,
  kleinanzeigen,
  immoscout,
  facebook,
  studentenwerk,
  friends,
  other;

  static Source fromKey(Object? key) {
    for (final s in values) {
      if (s.name == key) return s;
    }
    return other;
  }
}

/// The scam checklist, in display order. Each is confirmed by the user.
enum Check { viewed, noPrepay, accountInName, idLater, plausibleRent }

extension StageX on Stage {
  /// The stage the primary button moves to. Applied has two answers and the
  /// answers are final, so both return null.
  Stage? get next => switch (this) {
    Stage.interested => Stage.messaged,
    Stage.messaged => Stage.viewing,
    Stage.viewing => Stage.applied,
    Stage.applied || Stage.accepted || Stage.declined => null,
  };

  bool get isAnswer => this == Stage.accepted || this == Stage.declined;
}

String? _dateToJson(DateTime? d) => d?.toIso8601String();
DateTime? _dateFromJson(Object? v) => v is String ? DateTime.tryParse(v) : null;

class Flat {
  const Flat({
    required this.id,
    required this.title,
    this.source = Source.other,
    this.link = '',
    this.warmCents,
    this.coldCents,
    this.sizeSqm,
    this.district = '',
    this.notes = '',
    this.stage = Stage.interested,
    required this.stageSince,
    this.viewing,
    this.checks = const {},
    required this.createdAt,
  });

  final String id;
  final String title;
  final Source source;
  final String link;
  final int? warmCents;
  final int? coldCents;
  final double? sizeSqm;
  final String district;
  final String notes;
  final Stage stage;
  final DateTime stageSince;
  final DateTime? viewing;
  final Set<Check> checks;
  final DateTime createdAt;

  /// Warm rent per square metre in cents, or null if either is missing.
  double? get warmPerSqmCents {
    final w = warmCents;
    final s = sizeSqm;
    if (w == null || s == null || s <= 0) return null;
    return w / s;
  }

  Flat copyWith({
    String? title,
    Source? source,
    String? link,
    int? warmCents,
    bool clearWarm = false,
    int? coldCents,
    bool clearCold = false,
    double? sizeSqm,
    bool clearSize = false,
    String? district,
    String? notes,
    Stage? stage,
    DateTime? stageSince,
    DateTime? viewing,
    bool clearViewing = false,
    Set<Check>? checks,
  }) => Flat(
    id: id,
    title: title ?? this.title,
    source: source ?? this.source,
    link: link ?? this.link,
    warmCents: clearWarm ? null : (warmCents ?? this.warmCents),
    coldCents: clearCold ? null : (coldCents ?? this.coldCents),
    sizeSqm: clearSize ? null : (sizeSqm ?? this.sizeSqm),
    district: district ?? this.district,
    notes: notes ?? this.notes,
    stage: stage ?? this.stage,
    stageSince: stageSince ?? this.stageSince,
    viewing: clearViewing ? null : (viewing ?? this.viewing),
    checks: checks ?? this.checks,
    createdAt: createdAt,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'source': source.name,
    if (link.isNotEmpty) 'link': link,
    if (warmCents != null) 'warmCents': warmCents,
    if (coldCents != null) 'coldCents': coldCents,
    if (sizeSqm != null) 'sizeSqm': sizeSqm,
    if (district.isNotEmpty) 'district': district,
    if (notes.isNotEmpty) 'notes': notes,
    'stage': stage.name,
    'stageSince': _dateToJson(stageSince),
    if (viewing != null) 'viewing': _dateToJson(viewing),
    'checks': [
      for (final c in Check.values)
        if (checks.contains(c)) c.name,
    ],
    'createdAt': _dateToJson(createdAt),
  };

  factory Flat.fromJson(Map<String, Object?> j) {
    final created = _dateFromJson(j['createdAt']) ?? DateTime(2026);
    return Flat(
      id: j['id']! as String,
      title: (j['title'] as String?) ?? '',
      source: Source.fromKey(j['source']),
      link: (j['link'] as String?) ?? '',
      warmCents: (j['warmCents'] as num?)?.toInt(),
      coldCents: (j['coldCents'] as num?)?.toInt(),
      sizeSqm: (j['sizeSqm'] as num?)?.toDouble(),
      district: (j['district'] as String?) ?? '',
      notes: (j['notes'] as String?) ?? '',
      stage: Stage.values.firstWhere(
        (s) => s.name == j['stage'],
        orElse: () => Stage.interested,
      ),
      stageSince: _dateFromJson(j['stageSince']) ?? created,
      viewing: _dateFromJson(j['viewing']),
      checks: {
        for (final c in Check.values)
          if (((j['checks'] as List?) ?? const <Object?>[]).contains(c.name)) c,
      },
      createdAt: created,
    );
  }
}

enum CompareBy { month, sqm }

class Board {
  const Board({this.flats = const [], this.nextId = 1});

  static const int schemaVersion = 1;

  final List<Flat> flats;

  /// Counter for new ids, so ids stay short and never repeat.
  final int nextId;

  bool get isEmpty => flats.isEmpty;

  Flat? flat(String id) {
    for (final f in flats) {
      if (f.id == id) return f;
    }
    return null;
  }

  Board add(Flat Function(String id) build) =>
      Board(flats: [...flats, build('f$nextId')], nextId: nextId + 1);

  Board withFlat(Flat f) => Board(
    flats: [for (final x in flats) x.id == f.id ? f : x],
    nextId: nextId,
  );

  Board remove(String id) => Board(
    flats: [
      for (final f in flats)
        if (f.id != id) f,
    ],
    nextId: nextId,
  );

  /// Moves a flat to [stage], stamping when. A viewing time is kept so the
  /// user still sees when they viewed it.
  Board moveTo(String id, Stage stage, DateTime now, {DateTime? viewing}) {
    final f = flat(id);
    if (f == null) return this;
    if (f.stage == stage && viewing == null) return this;
    return withFlat(
      f.copyWith(
        stage: stage,
        stageSince: f.stage == stage ? f.stageSince : now,
        viewing: viewing,
      ),
    );
  }

  Board toggleCheck(String id, Check c) {
    final f = flat(id);
    if (f == null) return this;
    final next = {...f.checks};
    if (!next.remove(c)) next.add(c);
    return withFlat(f.copyWith(checks: next));
  }

  /// Flats in one stage, in the order the list shows them. Viewings by time
  /// (flats without a time last); the rest by how long they have waited in
  /// the stage, longest first, since those need a nudge.
  List<Flat> inStage(Stage stage) {
    final order = {for (var i = 0; i < flats.length; i++) flats[i].id: i};
    final list = [
      for (final f in flats)
        if (f.stage == stage) f,
    ];
    int key(Flat f) {
      if (stage == Stage.viewing) {
        return f.viewing?.millisecondsSinceEpoch ?? (1 << 52);
      }
      return f.stageSince.millisecondsSinceEpoch;
    }

    list.sort((a, b) {
      final c = key(a).compareTo(key(b));
      return c != 0 ? c : order[a.id]!.compareTo(order[b.id]!);
    });
    return list;
  }

  /// Flats still in the running (not declined), split into those that can
  /// be compared by [by], cheapest first, and those missing a number.
  (List<Flat>, List<Flat>) compare(CompareBy by) {
    double? value(Flat f) => switch (by) {
      CompareBy.month => f.warmCents?.toDouble(),
      CompareBy.sqm => f.warmPerSqmCents,
    };
    final order = {for (var i = 0; i < flats.length; i++) flats[i].id: i};
    final ranked = <Flat>[];
    final missing = <Flat>[];
    for (final f in flats) {
      if (f.stage == Stage.declined) continue;
      (value(f) == null ? missing : ranked).add(f);
    }
    ranked.sort((a, b) {
      final c = value(a)!.compareTo(value(b)!);
      return c != 0 ? c : order[a.id]!.compareTo(order[b.id]!);
    });
    return (ranked, missing);
  }

  Map<String, Object?> toJson() => {
    'version': schemaVersion,
    'nextId': nextId,
    'flats': [for (final f in flats) f.toJson()],
  };

  factory Board.fromJson(Map<String, Object?> j) {
    final flats = [
      for (final f in (j['flats'] as List?) ?? const <Object?>[])
        Flat.fromJson((f as Map).cast<String, Object?>()),
    ];
    // Never hand out an id that is already taken, even if nextId is wrong.
    var next = (j['nextId'] as num?)?.toInt() ?? 1;
    for (final f in flats) {
      final n = int.tryParse(f.id.substring(1));
      if (n != null && n >= next) next = n + 1;
    }
    return Board(flats: flats, nextId: next);
  }
}

/// Parses a typed amount of euros into cents. Accepts "480", "480,50",
/// "480.5", "1.200", "1,200.50", "1.200,50", with or without a euro sign.
/// Returns null for empty or unreadable input.
int? parseCents(String input) {
  final n = _parseNumber(input);
  if (n == null || n < 0 || n > 1000000) return null;
  return (n * 100).round();
}

/// Parses a size in square metres ("18", "18,5", "18.5 m²").
double? parseSize(String input) {
  final n = _parseNumber(
    input.replaceAll(RegExp('m²|m2|qm', caseSensitive: false), ''),
  );
  if (n == null || n <= 0 || n > 10000) return null;
  return (n * 10).round() / 10;
}

double? _parseNumber(String input) {
  var s = input.replaceAll(RegExp(r'[\s€  ]'), '');
  if (s.isEmpty) return null;
  final lastDot = s.lastIndexOf('.');
  final lastComma = s.lastIndexOf(',');
  if (lastDot >= 0 && lastComma >= 0) {
    // Both used: the later one is the decimal separator.
    final dec = lastDot > lastComma ? '.' : ',';
    final group = dec == '.' ? ',' : '.';
    s = s.replaceAll(group, '').replaceAll(dec, '.');
  } else if (lastDot >= 0 || lastComma >= 0) {
    final sep = lastDot >= 0 ? '.' : ',';
    final parts = s.split(sep);
    // "1.200" or "1,200,000": grouping. "480,5" or "480.50": decimals.
    final grouping =
        parts.length > 2 ||
        (parts.length == 2 && parts[1].length == 3 && parts[0].isNotEmpty);
    s = grouping ? parts.join() : parts.join('.');
  }
  if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(s)) return null;
  return double.tryParse(s);
}
