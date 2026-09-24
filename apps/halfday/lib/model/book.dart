/// Data model: jobs, the shifts worked in them, and the limits that apply.
/// Everything is immutable; edits return a new [Book].
library;

import 'day.dart';

enum JobKind {
  /// Counts toward the yearly day limit.
  regular,

  /// Counts toward the day limit; pay is checked against the Minijob limit.
  minijob,

  /// Student assistant or tutor at the university: usually not counted.
  university;

  bool get counts => this != university;

  static JobKind parse(Object? v) =>
      values.firstWhere((k) => k.name == v, orElse: () => regular);
}

class Job {
  const Job({
    required this.id,
    required this.name,
    this.kind = JobKind.regular,
    this.rateCents,
  });

  final String id;
  final String name;
  final JobKind kind;

  /// Hourly pay in cents, used for the Minijob check. Optional.
  final int? rateCents;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'kind': kind.name,
    if (rateCents != null) 'rateCents': rateCents,
  };

  factory Job.fromJson(Map<String, Object?> j) => Job(
    id: j['id']! as String,
    name: (j['name'] as String?) ?? '',
    kind: JobKind.parse(j['kind']),
    rateCents: (j['rateCents'] as num?)?.toInt(),
  );
}

class Shift {
  const Shift({
    required this.id,
    required this.jobId,
    required this.date,
    required this.minutes,
    this.note = '',
  });

  final String id;
  final String jobId;
  final Day date;
  final int minutes;
  final String note;

  Map<String, Object?> toJson() => {
    'id': id,
    'jobId': jobId,
    'date': date.toString(),
    'minutes': minutes,
    if (note.isNotEmpty) 'note': note,
  };

  factory Shift.fromJson(Map<String, Object?> j) => Shift(
    id: j['id']! as String,
    jobId: j['jobId']! as String,
    date: Day.parse(j['date']! as String),
    minutes: (j['minutes']! as num).toInt(),
    note: (j['note'] as String?) ?? '',
  );
}

class Settings {
  const Settings({
    this.fullDayLimit = typicalFullDayLimit,
    this.halfDayMaxMinutes = typicalHalfDayMaxMinutes,
    this.weeklyHourLimit = typicalWeeklyHourLimit,
    this.minijobLimits = typicalMinijobLimits,
  });

  /// Typical values as of 2026 (student residence permit, Minijob limit).
  static const typicalFullDayLimit = 140;
  static const typicalHalfDayMaxMinutes = 240;
  static const typicalWeeklyHourLimit = 20;
  static const typicalMinijobLimits = {2026: 603, 2027: 633};

  final int fullDayLimit;

  /// A day with more counted minutes than this is a full day.
  final int halfDayMaxMinutes;
  final int weeklyHourLimit;

  /// Minijob pay limit in whole euros per month, by year.
  final Map<int, int> minijobLimits;

  bool get isTypical =>
      fullDayLimit == typicalFullDayLimit &&
      halfDayMaxMinutes == typicalHalfDayMaxMinutes &&
      weeklyHourLimit == typicalWeeklyHourLimit &&
      _sameMap(minijobLimits, typicalMinijobLimits);

  static bool _sameMap(Map<int, int> a, Map<int, int> b) =>
      a.length == b.length && a.entries.every((e) => b[e.key] == e.value);

  /// The Minijob limit for [year]: that year's value, else the latest
  /// earlier year, else the earliest known year.
  int minijobLimitFor(int year) {
    if (minijobLimits.isEmpty) return 0;
    final years = minijobLimits.keys.toList()..sort();
    var best = years.first;
    for (final y in years) {
      if (y <= year) best = y;
    }
    return minijobLimits[best]!;
  }

  Settings copyWith({
    int? fullDayLimit,
    int? halfDayMaxMinutes,
    int? weeklyHourLimit,
    Map<int, int>? minijobLimits,
  }) => Settings(
    fullDayLimit: fullDayLimit ?? this.fullDayLimit,
    halfDayMaxMinutes: halfDayMaxMinutes ?? this.halfDayMaxMinutes,
    weeklyHourLimit: weeklyHourLimit ?? this.weeklyHourLimit,
    minijobLimits: minijobLimits ?? this.minijobLimits,
  );

  Settings withMinijobLimit(int year, int euros) =>
      copyWith(minijobLimits: {...minijobLimits, year: euros});

  Map<String, Object?> toJson() => {
    'fullDayLimit': fullDayLimit,
    'halfDayMaxMinutes': halfDayMaxMinutes,
    'weeklyHourLimit': weeklyHourLimit,
    'minijobLimits': {
      for (final e in minijobLimits.entries) '${e.key}': e.value,
    },
  };

  factory Settings.fromJson(Map<String, Object?> j) {
    int read(String key, int fallback, int min) {
      final v = (j[key] as num?)?.toInt();
      return v == null || v < min ? fallback : v;
    }

    final limits = j['minijobLimits'];
    return Settings(
      fullDayLimit: read('fullDayLimit', typicalFullDayLimit, 1),
      halfDayMaxMinutes: read(
        'halfDayMaxMinutes',
        typicalHalfDayMaxMinutes,
        1,
      ),
      weeklyHourLimit: read('weeklyHourLimit', typicalWeeklyHourLimit, 1),
      minijobLimits: limits is Map
          ? {
              for (final e in limits.entries)
                int.parse(e.key as String): (e.value as num).toInt(),
            }
          : typicalMinijobLimits,
    );
  }
}

class Book {
  const Book({
    this.jobs = const [],
    this.shifts = const [],
    this.settings = const Settings(),
    this.lastJobId,
    this.nextId = 1,
  });

  static const version = 1;

  final List<Job> jobs;
  final List<Shift> shifts;
  final Settings settings;

  /// The job picked for the last shift, offered first next time.
  final String? lastJobId;
  final int nextId;

  bool get isEmpty => shifts.isEmpty;

  Job? job(String? id) {
    for (final j in jobs) {
      if (j.id == id) return j;
    }
    return null;
  }

  Shift? shift(String id) {
    for (final s in shifts) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// The job to preselect for a new shift.
  Job? get defaultJob => job(lastJobId) ?? (jobs.isEmpty ? null : jobs.first);

  /// Whether [s] counts toward the day limit. Shifts of a deleted job count,
  /// to stay on the safe side.
  bool counts(Shift s) => job(s.jobId)?.kind.counts ?? true;

  Book copyWith({
    List<Job>? jobs,
    List<Shift>? shifts,
    Settings? settings,
    String? lastJobId,
    int? nextId,
  }) => Book(
    jobs: jobs ?? this.jobs,
    shifts: shifts ?? this.shifts,
    settings: settings ?? this.settings,
    lastJobId: lastJobId ?? this.lastJobId,
    nextId: nextId ?? this.nextId,
  );

  (Book, String) _newId(String prefix) =>
      (copyWith(nextId: nextId + 1), '$prefix$nextId');

  (Book, String) addJob(Job Function(String id) make) {
    final (b, id) = _newId('j');
    return (b.copyWith(jobs: [...jobs, make(id)]), id);
  }

  Book withJob(Job job) =>
      copyWith(jobs: [for (final j in jobs) j.id == job.id ? job : j]);

  /// Removes a job and every shift logged for it.
  Book removeJob(String id) => Book(
    jobs: [
      for (final j in jobs)
        if (j.id != id) j,
    ],
    shifts: [
      for (final s in shifts)
        if (s.jobId != id) s,
    ],
    settings: settings,
    lastJobId: lastJobId == id ? null : lastJobId,
    nextId: nextId,
  );

  int shiftCountFor(String jobId) => shifts.where((s) => s.jobId == jobId).length;

  (Book, String) addShift(Shift Function(String id) make) {
    final (b, id) = _newId('s');
    final shift = make(id);
    return (
      b.copyWith(shifts: [...shifts, shift], lastJobId: shift.jobId),
      id,
    );
  }

  /// Adds many shifts at once (a confirmed plan).
  Book addShifts(List<Shift Function(String id)> makers) {
    var b = this;
    for (final m in makers) {
      b = b.addShift(m).$1;
    }
    return b;
  }

  Book withShift(Shift shift) => copyWith(
    shifts: [for (final s in shifts) s.id == shift.id ? shift : s],
    lastJobId: shift.jobId,
  );

  Book removeShift(String id) => copyWith(
    shifts: [
      for (final s in shifts)
        if (s.id != id) s,
    ],
  );

  Map<String, Object?> toJson() => {
    'version': version,
    'nextId': nextId,
    if (lastJobId != null) 'lastJobId': lastJobId,
    'settings': settings.toJson(),
    'jobs': [for (final j in jobs) j.toJson()],
    'shifts': [for (final s in shifts) s.toJson()],
  };

  factory Book.fromJson(Map<String, Object?> j) {
    List<Map<String, Object?>> list(String key) => [
      for (final e in (j[key] as List?) ?? const <Object?>[])
        (e! as Map).cast<String, Object?>(),
    ];
    return Book(
      jobs: [for (final e in list('jobs')) Job.fromJson(e)],
      shifts: [for (final e in list('shifts')) Shift.fromJson(e)],
      settings: j['settings'] is Map
          ? Settings.fromJson((j['settings']! as Map).cast<String, Object?>())
          : const Settings(),
      lastJobId: j['lastJobId'] as String?,
      nextId: (j['nextId'] as num?)?.toInt() ?? _afterIds(j),
    );
  }

  /// A free id counter for files without one: past every numeric suffix.
  static int _afterIds(Map<String, Object?> j) {
    var max = 0;
    for (final key in ['jobs', 'shifts']) {
      for (final e in (j[key] as List?) ?? const <Object?>[]) {
        final id = (e! as Map)['id'];
        final n = int.tryParse('$id'.replaceAll(RegExp('[^0-9]'), '')) ?? 0;
        if (n > max) max = n;
      }
    }
    return max + 1;
  }
}
