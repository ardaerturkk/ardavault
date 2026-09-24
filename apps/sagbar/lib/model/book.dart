/// Data model: the user's details, per-visit values, their own lines and
/// hidden built-in lines. Everything is immutable; edits return a new [Book].
library;

import 'content.dart';

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

const _months = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember',
];

String _two(int n) => n.toString().padLeft(2, '0');

/// "12. März 2001": how a date is said in a German sentence.
String germanDate(DateTime d, {bool withYear = true}) =>
    '${d.day}. ${_months[d.month - 1]}${withYear ? ' ${d.year}' : ''}';

/// "12.03.2001": the numeric form, readable in any language.
String numericDate(DateTime d, {bool withYear = true}) =>
    '${_two(d.day)}.${_two(d.month)}.${withYear ? d.year : ''}';

/// "10:40": German times are always 24-hour.
String germanTime(DateTime d) => '${_two(d.hour)}:${_two(d.minute)}';

/// "A-R-D-A, E-R-T-Ü-R-K".
String spellName(String name) => name
    .trim()
    .split(RegExp(r'\s+'))
    .where((w) => w.isNotEmpty)
    .map((w) => w.toUpperCase().split('').join('-'))
    .join(', ');

/// Values for one visit to one situation.
class Visit {
  const Visit({this.ref = '', this.appointment});
  final String ref;
  final DateTime? appointment;

  bool get isEmpty => ref.isEmpty && appointment == null;

  Visit copyWith({
    String? ref,
    DateTime? appointment,
    bool clearAppointment = false,
  }) => Visit(
    ref: ref ?? this.ref,
    appointment: clearAppointment ? null : (appointment ?? this.appointment),
  );

  Map<String, Object?> toJson() => {
    if (ref.isNotEmpty) 'ref': ref,
    if (appointment != null) 'appointment': appointment!.toIso8601String(),
  };

  factory Visit.fromJson(Map<String, Object?> j) => Visit(
    ref: (j['ref'] as String?) ?? '',
    appointment: j['appointment'] is String
        ? DateTime.tryParse(j['appointment']! as String)
        : null,
  );
}

/// A line the user wrote, in German, with an optional meaning.
class CustomLine {
  const CustomLine({
    required this.id,
    required this.situationId,
    required this.german,
    this.meaning = '',
  });

  final String id;
  final String situationId;
  final String german;
  final String meaning;

  Map<String, Object?> toJson() => {
    'id': id,
    'situation': situationId,
    'german': german,
    if (meaning.isNotEmpty) 'meaning': meaning,
  };

  factory CustomLine.fromJson(Map<String, Object?> j) => CustomLine(
    id: j['id']! as String,
    situationId: j['situation']! as String,
    german: j['german']! as String,
    meaning: (j['meaning'] as String?) ?? '',
  );
}

/// One line as shown in a situation: built in or the user's own.
class LineView {
  const LineView({
    required this.id,
    required this.german,
    required this.meaning,
    this.custom,
  });
  final String id;

  /// Template with {slot} placeholders (built-in) or plain text (custom).
  final String german;

  /// Template in the reader's language, or the user's own meaning.
  final String meaning;
  final CustomLine? custom;
  bool get isCustom => custom != null;
}

/// A piece of a filled line: plain text, or a slot with its value (null when
/// the user has not given it yet).
class Piece {
  const Piece.text(this.text) : slot = null;
  const Piece.slot(this.slot, this.text);
  final Slot? slot;
  final String? text;
  bool get isSlot => slot != null;
  bool get isMissing => slot != null && text == null;
}

final _slotPattern = RegExp(r'\{(\w+)\}');

class Book {
  const Book({
    this.profile = const {},
    this.birthDate,
    this.visits = const {},
    this.custom = const [],
    this.hidden = const {},
    this.nextId = 1,
  });

  /// Text details by slot name (name, address...). Birth date is separate.
  final Map<String, String> profile;
  final DateTime? birthDate;
  final Map<String, Visit> visits;
  final List<CustomLine> custom;

  /// Ids of built-in lines the user hid.
  final Set<String> hidden;
  final int nextId;

  bool get hasProfile => profile.isNotEmpty || birthDate != null;

  /// A text detail (name, address...), or null when not given.
  String? detail(Slot s) {
    final v = profile[s.name];
    return v == null || v.isEmpty ? null : v;
  }

  Visit visit(String situationId) => visits[situationId] ?? const Visit();

  Book copyWith({
    Map<String, String>? profile,
    DateTime? birthDate,
    bool clearBirthDate = false,
    Map<String, Visit>? visits,
    List<CustomLine>? custom,
    Set<String>? hidden,
    int? nextId,
  }) => Book(
    profile: profile ?? this.profile,
    birthDate: clearBirthDate ? null : (birthDate ?? this.birthDate),
    visits: visits ?? this.visits,
    custom: custom ?? this.custom,
    hidden: hidden ?? this.hidden,
    nextId: nextId ?? this.nextId,
  );

  /// Sets a text detail; an empty value removes it.
  Book withDetail(Slot s, String value) {
    final v = value.trim();
    final next = Map.of(profile);
    if (v.isEmpty) {
      next.remove(s.name);
    } else {
      next[s.name] = v;
    }
    return copyWith(profile: next);
  }

  Book withVisit(String situationId, Visit v) {
    final next = Map.of(visits);
    if (v.isEmpty) {
      next.remove(situationId);
    } else {
      next[situationId] = v;
    }
    return copyWith(visits: next);
  }

  Book addLine(String situationId, String german, String meaning) => copyWith(
    custom: [
      ...custom,
      CustomLine(
        id: 'c$nextId',
        situationId: situationId,
        german: german.trim(),
        meaning: meaning.trim(),
      ),
    ],
    nextId: nextId + 1,
  );

  Book editLine(String id, String german, String meaning) => copyWith(
    custom: [
      for (final c in custom)
        c.id == id
            ? CustomLine(
                id: id,
                situationId: c.situationId,
                german: german.trim(),
                meaning: meaning.trim(),
              )
            : c,
    ],
  );

  Book removeLine(String id) =>
      copyWith(custom: [for (final c in custom) if (c.id != id) c]);

  Book hide(String builtInId) => copyWith(hidden: {...hidden, builtInId});

  /// Shows every hidden line of one situation again.
  Book unhideAll(String situationId) => copyWith(
    hidden: {
      for (final h in hidden)
        if (!h.startsWith('$situationId:')) h,
    },
  );

  int hiddenCount(String situationId) =>
      hidden.where((h) => h.startsWith('$situationId:')).length;

  CustomLine? customLine(String id) {
    for (final c in custom) {
      if (c.id == id) return c;
    }
    return null;
  }

  /// The visible lines of a situation: built-in first, then the user's own.
  /// [locale] picks the meaning language; German falls back to English.
  List<LineView> linesFor(Situation s, String locale) => [
    for (final b in s.lines)
      if (!hidden.contains(b.id))
        LineView(id: b.id, german: b.german, meaning: locale == 'tr' ? b.tr : b.en),
    for (final c in custom)
      if (c.situationId == s.id)
        LineView(id: c.id, german: c.german, meaning: c.meaning, custom: c),
  ];

  /// The value for a slot in a German sentence, or null if missing.
  String? valueFor(Slot slot, String situationId, {bool numeric = false}) {
    final v = visit(situationId);
    final appt = v.appointment;
    return switch (slot) {
      Slot.birthDate =>
        birthDate == null
            ? null
            : numeric
            ? numericDate(birthDate!)
            : germanDate(birthDate!),
      Slot.nameSpelled => detail(Slot.name) == null
          ? null
          : spellName(detail(Slot.name)!),
      Slot.ref => v.ref.isEmpty ? null : v.ref,
      Slot.time => appt == null ? null : germanTime(appt),
      Slot.date =>
        appt == null
            ? null
            : numeric
            ? numericDate(appt, withYear: false)
            : germanDate(appt, withYear: false),
      _ => detail(slot),
    };
  }

  /// Splits a template into text and filled (or missing) slots. Unknown
  /// braces stay as text, so a user's own line is shown as typed.
  List<Piece> fill(String template, String situationId, {bool numeric = false}) {
    final out = <Piece>[];
    var at = 0;
    for (final m in _slotPattern.allMatches(template)) {
      final slot = Slot.values.where((s) => s.name == m.group(1)).firstOrNull;
      if (slot == null) continue;
      if (m.start > at) out.add(Piece.text(template.substring(at, m.start)));
      out.add(Piece.slot(slot, valueFor(slot, situationId, numeric: numeric)));
      at = m.end;
    }
    if (at < template.length) out.add(Piece.text(template.substring(at)));
    return out;
  }

  /// Slots used by the visible lines of a situation that have no value yet.
  List<Slot> missingFor(Situation s, String locale) {
    final seen = <Slot>{};
    for (final line in linesFor(s, locale)) {
      if (line.isCustom) continue;
      for (final p in fill(line.german, s.id)) {
        if (p.isMissing) seen.add(p.slot!);
      }
    }
    // Spelling comes from the name: ask for the name once.
    if (seen.remove(Slot.nameSpelled)) seen.add(Slot.name);
    return [for (final slot in Slot.values) if (seen.contains(slot)) slot];
  }

  Map<String, Object?> toJson() => {
    'version': 1,
    'profile': profile,
    if (birthDate != null)
      'birthDate':
          '${birthDate!.year.toString().padLeft(4, '0')}-${_two(birthDate!.month)}-${_two(birthDate!.day)}',
    'visits': {for (final e in visits.entries) e.key: e.value.toJson()},
    'custom': [for (final c in custom) c.toJson()],
    'hidden': hidden.toList()..sort(),
    'nextId': nextId,
  };

  factory Book.fromJson(Map<String, Object?> j) {
    final birth = j['birthDate'];
    return Book(
      profile: {
        for (final e in ((j['profile'] as Map?) ?? const {}).entries)
          if (e.value is String) e.key as String: e.value as String,
      },
      birthDate: birth is String ? DateTime.tryParse(birth) : null,
      visits: {
        for (final e in ((j['visits'] as Map?) ?? const {}).entries)
          e.key as String: Visit.fromJson(
            (e.value as Map).cast<String, Object?>(),
          ),
      },
      custom: [
        for (final c in (j['custom'] as List?) ?? const <Object?>[])
          CustomLine.fromJson((c! as Map).cast<String, Object?>()),
      ],
      hidden: {
        for (final h in (j['hidden'] as List?) ?? const <Object?>[])
          h! as String,
      },
      nextId: (j['nextId'] as int?) ?? 1,
    );
  }
}
