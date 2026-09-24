/// Data model: the people you call and the ticks of each round. Everything
/// is immutable; edits return a new [Book].
library;

import 'cities.dart';
import 'occasion.dart';

/// Elders are called first, then family, then friends.
enum Circle { elders, family, friends }

enum Reach { called, messaged, visited }

class Birthday {
  const Birthday(this.month, this.day, [this.year]);
  final int month;
  final int day;
  final int? year;

  Map<String, Object?> toJson() => {
    'month': month,
    'day': day,
    if (year != null) 'year': year,
  };

  static Birthday? fromJson(Object? v) {
    if (v is! Map) return null;
    final month = v['month'];
    final day = v['day'];
    if (month is! int || day is! int) return null;
    return Birthday(month, day, v['year'] as int?);
  }

  @override
  bool operator ==(Object other) =>
      other is Birthday &&
      other.month == month &&
      other.day == day &&
      other.year == year;

  @override
  int get hashCode => Object.hash(month, day, year);
}

class Person {
  const Person({
    required this.id,
    required this.name,
    this.relation = '',
    this.phone = '',
    this.circle = Circle.family,
    this.cityId = defaultCityId,
    this.kinds = const {
      OccasionKind.ramazanBayrami,
      OccasionKind.kurbanBayrami,
    },
    this.birthday,
    this.order = 0,
  });

  final String id;
  final String name;
  final String relation;
  final String phone;
  final Circle circle;
  final String cityId;

  /// Shared occasions this person is part of. Their birthday counts when
  /// [birthday] is set.
  final Set<OccasionKind> kinds;
  final Birthday? birthday;

  /// Position within the circle; lower comes first.
  final int order;

  City get city => cityById(cityId);

  bool takesPartIn(Occasion o) => o.kind == OccasionKind.birthday
      ? o.personId == id
      : kinds.contains(o.kind);

  Person copyWith({
    String? name,
    String? relation,
    String? phone,
    Circle? circle,
    String? cityId,
    Set<OccasionKind>? kinds,
    Birthday? birthday,
    bool clearBirthday = false,
    int? order,
  }) => Person(
    id: id,
    name: name ?? this.name,
    relation: relation ?? this.relation,
    phone: phone ?? this.phone,
    circle: circle ?? this.circle,
    cityId: cityId ?? this.cityId,
    kinds: kinds ?? this.kinds,
    birthday: clearBirthday ? null : (birthday ?? this.birthday),
    order: order ?? this.order,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    if (relation.isNotEmpty) 'relation': relation,
    if (phone.isNotEmpty) 'phone': phone,
    'circle': circle.name,
    'city': cityId,
    'kinds': [for (final k in choosableKinds) if (kinds.contains(k)) k.name],
    if (birthday != null) 'birthday': birthday!.toJson(),
    'order': order,
  };

  factory Person.fromJson(Map<String, Object?> j) => Person(
    id: j['id']! as String,
    name: (j['name'] as String?) ?? '',
    relation: (j['relation'] as String?) ?? '',
    phone: (j['phone'] as String?) ?? '',
    circle: Circle.values.asNameMap()[j['circle']] ?? Circle.family,
    cityId: (j['city'] as String?) ?? defaultCityId,
    kinds: {
      for (final n in (j['kinds'] as List?) ?? const <Object?>[])
        ?OccasionKind.values.asNameMap()[n],
    },
    birthday: Birthday.fromJson(j['birthday']),
    order: (j['order'] as int?) ?? 0,
  );
}

/// One tick in a round: how you reached the person, when, and a short note.
class Entry {
  const Entry({this.reach, this.at, this.note = ''});
  final Reach? reach;
  final DateTime? at;
  final String note;

  bool get reached => reach != null;
  bool get isEmpty => reach == null && note.isEmpty;

  Map<String, Object?> toJson() => {
    if (reach != null) 'reach': reach!.name,
    if (at != null) 'at': at!.toIso8601String(),
    if (note.isNotEmpty) 'note': note,
  };

  factory Entry.fromJson(Map<String, Object?> j) => Entry(
    reach: Reach.values.asNameMap()[j['reach']],
    at: j['at'] is String ? DateTime.tryParse(j['at']! as String) : null,
    note: (j['note'] as String?) ?? '',
  );
}

class Book {
  const Book({this.people = const [], this.rounds = const {}, this.nextId = 1});

  final List<Person> people;

  /// Occasion key to person id to entry.
  final Map<String, Map<String, Entry>> rounds;
  final int nextId;

  static const version = 1;

  bool get isEmpty => people.isEmpty;

  Person? person(String id) {
    for (final p in people) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// People of one circle in their order.
  List<Person> inCircle(Circle c) =>
      [for (final p in people) if (p.circle == c) p]
        ..sort((a, b) => a.order.compareTo(b.order));

  /// Everyone, elders first, each circle in its order.
  List<Person> get ordered => [for (final c in Circle.values) ...inCircle(c)];

  Entry entry(Occasion o, String personId) =>
      rounds[o.key]?[personId] ?? const Entry();

  /// Who belongs in this round: everyone who takes part now, plus anyone
  /// with a tick in it (so history stays when occasions change).
  List<Person> participants(Occasion o) {
    final ticks = rounds[o.key] ?? const {};
    return [
      for (final p in ordered)
        if (p.takesPartIn(o) || ticks.containsKey(p.id)) p,
    ];
  }

  int reachedCount(Occasion o) => participants(
    o,
  ).where((p) => entry(o, p.id).reached).length;

  Book addPerson(Person Function(String id) make) {
    final id = 'p$nextId';
    final p = make(id);
    final last = inCircle(p.circle);
    final placed = p.copyWith(
      order: last.isEmpty ? 0 : last.last.order + 1,
    );
    return Book(
      people: [...people, placed],
      rounds: rounds,
      nextId: nextId + 1,
    );
  }

  Book withPerson(Person p) {
    final old = person(p.id);
    var next = p;
    if (old != null && old.circle != p.circle) {
      // Moving to another circle: goes to the end of it.
      final there = inCircle(p.circle);
      next = p.copyWith(order: there.isEmpty ? 0 : there.last.order + 1);
    }
    return Book(
      people: [for (final x in people) x.id == p.id ? next : x],
      rounds: rounds,
      nextId: nextId,
    );
  }

  Book removePerson(String id) => Book(
    people: [for (final p in people) if (p.id != id) p],
    rounds: {
      for (final e in rounds.entries)
        if (e.value.keys.any((k) => k != id))
          e.key: {
            for (final t in e.value.entries)
              if (t.key != id) t.key: t.value,
          },
    },
    nextId: nextId,
  );

  /// Puts [circle]'s people in the order of [ids].
  Book reorder(Circle circle, List<String> ids) => Book(
    people: [
      for (final p in people)
        if (p.circle == circle && ids.contains(p.id))
          p.copyWith(order: ids.indexOf(p.id))
        else
          p,
    ],
    rounds: rounds,
    nextId: nextId,
  );

  Book withEntry(Occasion o, String personId, Entry e) {
    final round = {...?rounds[o.key]};
    if (e.isEmpty) {
      round.remove(personId);
    } else {
      round[personId] = e;
    }
    return Book(
      people: people,
      rounds: {
        for (final r in rounds.entries)
          if (r.key != o.key) r.key: r.value,
        if (round.isNotEmpty) o.key: round,
      },
      nextId: nextId,
    );
  }

  Book mark(Occasion o, String personId, Reach reach, DateTime at) {
    final e = entry(o, personId);
    return withEntry(o, personId, Entry(reach: reach, at: at, note: e.note));
  }

  Book unmark(Occasion o, String personId) =>
      withEntry(o, personId, Entry(note: entry(o, personId).note));

  Book withNote(Occasion o, String personId, String note) {
    final e = entry(o, personId);
    return withEntry(o, personId, Entry(reach: e.reach, at: e.at, note: note));
  }

  /// Birthdays of everyone who has one, in [year].
  List<Occasion> birthdaysIn(int year) => [
    for (final p in people)
      if (p.birthday case final b?)
        Occasion(
          kind: OccasionKind.birthday,
          start: birthdayIn(year, b.month, b.day),
          personId: p.id,
        ),
  ];

  /// Every occasion around [today] (last year to next year) that has at
  /// least one participant, by date.
  List<Occasion> occasionsAround(DateTime today) {
    final all = <Occasion>[
      for (var y = today.year - 1; y <= today.year + 1; y++) ...[
        ...occasionsInYear(y),
        ...birthdaysIn(y),
      ],
    ]..sort((a, b) => a.start.compareTo(b.start));
    return [
      for (final o in all)
        if (participants(o).isNotEmpty) o,
    ];
  }

  /// Rounds open today: from the eve to the day after.
  List<Occasion> openOn(DateTime today) => [
    for (final o in occasionsAround(today))
      if (o.phaseOn(today) case Phase.eve || Phase.during || Phase.after) o,
  ];

  /// What comes next, within about a year.
  List<Occasion> upcomingFrom(DateTime today) => [
    for (final o in occasionsAround(today))
      if (o.phaseOn(today) == Phase.upcoming &&
          daysBetween(today, o.start) <= 366)
        o,
  ];

  /// Finished rounds with at least one tick, newest first.
  List<Occasion> pastBefore(DateTime today) => [
    for (final o in occasionsAround(today).reversed)
      if (o.phaseOn(today) == Phase.past && rounds.containsKey(o.key)) o,
  ];

  Map<String, Object?> toJson() => {
    'version': version,
    'nextId': nextId,
    'people': [for (final p in people) p.toJson()],
    'rounds': {
      for (final r in rounds.entries)
        r.key: {for (final e in r.value.entries) e.key: e.value.toJson()},
    },
  };

  factory Book.fromJson(Map<String, Object?> j) {
    final v = j['version'];
    if (v is int && v > version) {
      throw FormatException('Saved by a newer version ($v)');
    }
    final people = [
      for (final p in (j['people'] as List?) ?? const <Object?>[])
        Person.fromJson((p as Map).cast<String, Object?>()),
    ];
    final rounds = <String, Map<String, Entry>>{
      for (final r in ((j['rounds'] as Map?) ?? const {}).entries)
        r.key as String: {
          for (final e in (r.value as Map).entries)
            e.key as String: Entry.fromJson(
              (e.value as Map).cast<String, Object?>(),
            ),
        },
    };
    return Book(
      people: people,
      rounds: rounds,
      nextId: (j['nextId'] as int?) ?? people.length + 1,
    );
  }
}
