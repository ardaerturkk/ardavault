/// Courses, their exercise sheets and the admission rule the user typed in
/// from the course page. Pure data: every number shown is derived in
/// admission.dart.
library;

enum SheetState {
  /// Not graded yet: the points can still come.
  open,

  /// Graded with [Sheet.points].
  graded,

  /// Not handed in: counts as zero points.
  missed,

  /// Excused (for example with a doctor's note): leaves the total.
  excused,
}

class Sheet {
  const Sheet({
    required this.id,
    required this.max,
    this.points,
    this.state = SheetState.open,
    this.extra = false,
  }) : assert(state != SheetState.graded || points != null);

  final String id;

  /// Points available on this sheet. May be zero (a practice sheet).
  final double max;

  /// Points received; only meaningful when [state] is graded. May exceed
  /// [max] when a sheet has bonus tasks.
  final double? points;
  final SheetState state;

  /// An extra sheet: its points count, its maximum does not add to the
  /// total, and it is never needed for the minimum per sheet.
  final bool extra;

  double get earned => state == SheetState.graded ? points ?? 0 : 0;
  bool get isOpen => state == SheetState.open;

  Sheet copyWith({
    double? max,
    double? points,
    SheetState? state,
    bool? extra,
  }) => Sheet(
    id: id,
    max: max ?? this.max,
    points: (state ?? this.state) == SheetState.graded
        ? points ?? this.points
        : null,
    state: state ?? this.state,
    extra: extra ?? this.extra,
  );

  /// Enters a grade.
  Sheet graded(double p) => Sheet(
    id: id,
    max: max,
    points: p,
    state: SheetState.graded,
    extra: extra,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'max': max,
    if (points != null) 'points': points,
    'state': state.name,
    if (extra) 'extra': true,
  };

  factory Sheet.fromJson(Map<String, Object?> j) {
    final state = SheetState.values.byName(j['state']! as String);
    final points = (j['points'] as num?)?.toDouble();
    return Sheet(
      id: j['id']! as String,
      max: (j['max']! as num).toDouble(),
      points: state == SheetState.graded ? points ?? 0 : null,
      state: state,
      extra: j['extra'] as bool? ?? false,
    );
  }
}

/// How the share of points is stated on the course page.
enum TotalKind {
  /// "50 % of all points".
  percent,

  /// "at least 60 points".
  points,

  /// No condition on the total (for example only a minimum per sheet).
  none,
}

/// "From 80 %: 0.3 grade bonus". The label is the user's own words.
class BonusTier {
  const BonusTier({required this.percent, this.label = ''});
  final double percent;
  final String label;

  Map<String, Object?> toJson() => {'percent': percent, 'label': label};

  factory BonusTier.fromJson(Map<String, Object?> j) => BonusTier(
    percent: (j['percent']! as num).toDouble(),
    label: j['label'] as String? ?? '',
  );

  @override
  bool operator ==(Object other) =>
      other is BonusTier && other.percent == percent && other.label == label;

  @override
  int get hashCode => Object.hash(percent, label);
}

class Rule {
  const Rule({
    this.kind = TotalKind.percent,
    this.value = 50,
    this.bestOf,
    this.minSheetPercent,
    this.minSheetCount,
    this.presentations = 0,
    this.bonus = const [],
  });

  final TotalKind kind;

  /// Percent (0-100) or points, depending on [kind].
  final double value;

  /// Only the best n regular sheets count. Null: all of them count.
  final int? bestOf;

  /// Each sheet must reach this share of its points (0-100). Null: no
  /// minimum per sheet.
  final double? minSheetPercent;

  /// How many sheets must reach [minSheetPercent]. Null: every counted
  /// sheet (all of them, or the best n).
  final int? minSheetCount;

  /// Presentations at the board (Vorrechnen) needed. Zero: none.
  final int presentations;

  /// Bonus tiers, as a share of the counted total, lowest first.
  final List<BonusTier> bonus;

  /// True when the rule asks for anything at all.
  bool get hasCondition =>
      kind != TotalKind.none || minSheetPercent != null || presentations > 0;

  Rule copyWith({
    TotalKind? kind,
    double? value,
    int? Function()? bestOf,
    double? Function()? minSheetPercent,
    int? Function()? minSheetCount,
    int? presentations,
    List<BonusTier>? bonus,
  }) => Rule(
    kind: kind ?? this.kind,
    value: value ?? this.value,
    bestOf: bestOf == null ? this.bestOf : bestOf(),
    minSheetPercent: minSheetPercent == null
        ? this.minSheetPercent
        : minSheetPercent(),
    minSheetCount: minSheetCount == null ? this.minSheetCount : minSheetCount(),
    presentations: presentations ?? this.presentations,
    bonus: bonus ?? this.bonus,
  );

  Map<String, Object?> toJson() => {
    'kind': kind.name,
    'value': value,
    if (bestOf != null) 'bestOf': bestOf,
    if (minSheetPercent != null) 'minSheetPercent': minSheetPercent,
    if (minSheetCount != null) 'minSheetCount': minSheetCount,
    if (presentations > 0) 'presentations': presentations,
    if (bonus.isNotEmpty) 'bonus': [for (final b in bonus) b.toJson()],
  };

  factory Rule.fromJson(Map<String, Object?> j) => Rule(
    kind: TotalKind.values.byName(j['kind']! as String),
    value: (j['value']! as num).toDouble(),
    bestOf: j['bestOf'] as int?,
    minSheetPercent: (j['minSheetPercent'] as num?)?.toDouble(),
    minSheetCount: j['minSheetCount'] as int?,
    presentations: j['presentations'] as int? ?? 0,
    bonus: [
      for (final b in (j['bonus'] as List?) ?? const <Object?>[])
        BonusTier.fromJson((b! as Map).cast<String, Object?>()),
    ]..sort((a, b) => a.percent.compareTo(b.percent)),
  );

  @override
  bool operator ==(Object other) =>
      other is Rule &&
      other.kind == kind &&
      other.value == value &&
      other.bestOf == bestOf &&
      other.minSheetPercent == minSheetPercent &&
      other.minSheetCount == minSheetCount &&
      other.presentations == presentations &&
      _sameTiers(other.bonus, bonus);

  static bool _sameTiers(List<BonusTier> a, List<BonusTier> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(
    kind,
    value,
    bestOf,
    minSheetPercent,
    minSheetCount,
    presentations,
    Object.hashAll(bonus),
  );
}

class Course {
  const Course({
    required this.id,
    required this.name,
    this.sheets = const [],
    this.rule = const Rule(),
    this.presentationsDone = 0,
    this.note = '',
  });

  final String id;
  final String name;
  final List<Sheet> sheets;
  final Rule rule;
  final int presentationsDone;
  final String note;

  /// Regular sheets in order (extra sheets are numbered separately).
  List<Sheet> get regular => [
    for (final s in sheets)
      if (!s.extra) s,
  ];

  List<Sheet> get extras => [
    for (final s in sheets)
      if (s.extra) s,
  ];

  Sheet? sheet(String id) {
    for (final s in sheets) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// 1-based number among sheets of the same kind: "Sheet 3", "Extra Sheet 1".
  int numberOf(Sheet sheet) {
    var n = 0;
    for (final s in sheets) {
      if (s.extra == sheet.extra) n++;
      if (s.id == sheet.id) return n;
    }
    return n;
  }

  /// The next sheet waiting for a grade, regular sheets first.
  Sheet? get nextOpen {
    for (final s in regular) {
      if (s.isOpen) return s;
    }
    for (final s in extras) {
      if (s.isOpen) return s;
    }
    return null;
  }

  /// The most common maximum among regular sheets; the default for new ones.
  double get usualMax {
    final counts = <double, int>{};
    for (final s in regular) {
      counts[s.max] = (counts[s.max] ?? 0) + 1;
    }
    if (counts.isEmpty) return 10;
    return counts.entries.reduce((a, b) => b.value > a.value ? b : a).key;
  }

  Course copyWith({
    String? name,
    List<Sheet>? sheets,
    Rule? rule,
    int? presentationsDone,
    String? note,
  }) => Course(
    id: id,
    name: name ?? this.name,
    sheets: sheets ?? this.sheets,
    rule: rule ?? this.rule,
    presentationsDone: presentationsDone ?? this.presentationsDone,
    note: note ?? this.note,
  );

  Course withSheet(Sheet sheet) =>
      copyWith(sheets: [for (final s in sheets) s.id == sheet.id ? sheet : s]);

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'sheets': [for (final s in sheets) s.toJson()],
    'rule': rule.toJson(),
    if (presentationsDone > 0) 'presentationsDone': presentationsDone,
    if (note.isNotEmpty) 'note': note,
  };

  factory Course.fromJson(Map<String, Object?> j) => Course(
    id: j['id']! as String,
    name: j['name']! as String,
    sheets: [
      for (final s in (j['sheets'] as List?) ?? const <Object?>[])
        Sheet.fromJson((s! as Map).cast<String, Object?>()),
    ],
    rule: Rule.fromJson((j['rule']! as Map).cast<String, Object?>()),
    presentationsDone: j['presentationsDone'] as int? ?? 0,
    note: j['note'] as String? ?? '',
  );
}

/// Everything the app stores.
class Book {
  const Book({this.courses = const [], this.nextId = 1});

  final List<Course> courses;

  /// Counter for new ids; never reused, so a deleted course's id is never
  /// handed to a new one.
  final int nextId;

  bool get isEmpty => courses.isEmpty;

  Course? course(String id) {
    for (final c in courses) {
      if (c.id == id) return c;
    }
    return null;
  }

  /// Adds a course built by [make] with fresh ids for it and [sheetCount]
  /// sheets of [max] points each.
  (Book, String) addCourse({
    required String name,
    required int sheetCount,
    required double max,
    required Rule rule,
    String note = '',
  }) {
    var next = nextId;
    final id = 'c${next++}';
    final sheets = [
      for (var i = 0; i < sheetCount; i++) Sheet(id: 's${next++}', max: max),
    ];
    return (
      Book(
        courses: [
          ...courses,
          Course(id: id, name: name, sheets: sheets, rule: rule, note: note),
        ],
        nextId: next,
      ),
      id,
    );
  }

  Book withCourse(Course course) => Book(
    courses: [for (final c in courses) c.id == course.id ? course : c],
    nextId: nextId,
  );

  Book removeCourse(String id) => Book(
    courses: [
      for (final c in courses)
        if (c.id != id) c,
    ],
    nextId: nextId,
  );

  /// Appends a sheet to a course. Returns the new sheet's id.
  (Book, String) addSheet(
    String courseId, {
    required double max,
    bool extra = false,
  }) {
    final c = course(courseId)!;
    final id = 's$nextId';
    final b = Book(courses: courses, nextId: nextId + 1).withCourse(
      c.copyWith(
        sheets: [
          ...c.sheets,
          Sheet(id: id, max: max, extra: extra),
        ],
      ),
    );
    return (b, id);
  }

  Book removeSheet(String courseId, String sheetId) {
    final c = course(courseId)!;
    return withCourse(
      c.copyWith(
        sheets: [
          for (final s in c.sheets)
            if (s.id != sheetId) s,
        ],
      ),
    );
  }

  /// Changes the number of regular sheets. New sheets get [max] points.
  /// Only open sheets from the end are removed; returns null when that is
  /// not enough (a graded sheet would be lost).
  Book? resizeCourse(String courseId, int count, {required double max}) {
    final c = course(courseId)!;
    final regular = c.regular;
    if (count == regular.length) return this;
    if (count > regular.length) {
      var next = nextId;
      final added = [
        for (var i = regular.length; i < count; i++)
          Sheet(id: 's${next++}', max: max),
      ];
      // New regular sheets go after the last regular sheet, before extras
      // that were added later stay where they are.
      final sheets = [...c.sheets];
      final lastRegular = sheets.lastIndexWhere((s) => !s.extra);
      sheets.insertAll(lastRegular + 1, added);
      return Book(
        courses: courses,
        nextId: next,
      ).withCourse(c.copyWith(sheets: sheets));
    }
    final remove = regular.sublist(count);
    if (remove.any((s) => !s.isOpen)) return null;
    final ids = {for (final s in remove) s.id};
    return withCourse(
      c.copyWith(
        sheets: [
          for (final s in c.sheets)
            if (!ids.contains(s.id)) s,
        ],
      ),
    );
  }

  Map<String, Object?> toJson() => {
    'version': 1,
    'nextId': nextId,
    'courses': [for (final c in courses) c.toJson()],
  };

  factory Book.fromJson(Map<String, Object?> j) {
    final version = j['version'] as int? ?? 1;
    if (version > 1) {
      throw FormatException('Saved by a newer version ($version)');
    }
    final courses = [
      for (final c in (j['courses'] as List?) ?? const <Object?>[])
        Course.fromJson((c! as Map).cast<String, Object?>()),
    ];
    // Never hand out an id that is already taken, even if the counter was
    // lost.
    var next = j['nextId'] as int? ?? 1;
    for (final c in courses) {
      for (final id in [c.id, for (final s in c.sheets) s.id]) {
        final n = int.tryParse(id.substring(1));
        if (n != null && n >= next) next = n + 1;
      }
    }
    return Book(courses: courses, nextId: next);
  }
}
