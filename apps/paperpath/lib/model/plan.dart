/// Data model: documents, the steps that need or produce them, and the plan
/// that holds both. Everything is immutable; edits return a new [Plan].
library;

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

String? _dateToJson(DateTime? d) => d?.toIso8601String();
DateTime? _dateFromJson(Object? v) => v is String ? DateTime.tryParse(v) : null;

class Doc {
  const Doc({
    required this.id,
    this.templateKey,
    this.name,
    this.note = '',
    this.have = false,
  });

  final String id;

  /// Set for documents from the starter set; the display name is then
  /// localized unless the user renamed it ([name] not null).
  final String? templateKey;
  final String? name;
  final String note;
  final bool have;

  Doc copyWith({String? name, String? note, bool? have}) => Doc(
    id: id,
    templateKey: templateKey,
    name: name ?? this.name,
    note: note ?? this.note,
    have: have ?? this.have,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    if (templateKey != null) 'templateKey': templateKey,
    if (name != null) 'name': name,
    if (note.isNotEmpty) 'note': note,
    'have': have,
  };

  factory Doc.fromJson(Map<String, Object?> j) => Doc(
    id: j['id']! as String,
    templateKey: j['templateKey'] as String?,
    name: j['name'] as String?,
    note: (j['note'] as String?) ?? '',
    have: (j['have'] as bool?) ?? false,
  );
}

enum StepStatus { ready, waiting, done }

class PathStep {
  const PathStep({
    required this.id,
    this.templateKey,
    this.title,
    this.note,
    this.needs = const [],
    this.produces = const [],
    this.dueDaysAfterMoveIn,
    this.dueDate,
    this.appointment,
    this.done = false,
  });

  final String id;
  final String? templateKey;
  final String? title;

  /// Null means "use the localized template note" for template steps.
  final String? note;
  final List<String> needs;
  final List<String> produces;

  /// Relative deadline from the move-in date. Ignored when [dueDate] is set.
  final int? dueDaysAfterMoveIn;
  final DateTime? dueDate;
  final DateTime? appointment;
  final bool done;

  PathStep copyWith({
    String? title,
    String? note,
    List<String>? needs,
    List<String>? produces,
    bool? done,
    DateTime? dueDate,
    bool clearDue = false,
    DateTime? appointment,
    bool clearAppointment = false,
  }) => PathStep(
    id: id,
    templateKey: templateKey,
    title: title ?? this.title,
    note: note ?? this.note,
    needs: needs ?? this.needs,
    produces: produces ?? this.produces,
    dueDaysAfterMoveIn: clearDue || dueDate != null ? null : dueDaysAfterMoveIn,
    dueDate: clearDue ? null : (dueDate ?? this.dueDate),
    appointment: clearAppointment ? null : (appointment ?? this.appointment),
    done: done ?? this.done,
  );

  /// The deadline as a calendar date, or null if there is none.
  DateTime? effectiveDue(DateTime? moveIn) {
    if (dueDate != null) return dateOnly(dueDate!);
    if (dueDaysAfterMoveIn != null && moveIn != null) {
      // Calendar days, not 24-hour blocks: safe across clock changes.
      return DateTime(
        moveIn.year,
        moveIn.month,
        moveIn.day + dueDaysAfterMoveIn!,
      );
    }
    return null;
  }

  Map<String, Object?> toJson() => {
    'id': id,
    if (templateKey != null) 'templateKey': templateKey,
    if (title != null) 'title': title,
    if (note != null) 'note': note,
    'needs': needs,
    'produces': produces,
    if (dueDaysAfterMoveIn != null) 'dueDaysAfterMoveIn': dueDaysAfterMoveIn,
    if (dueDate != null) 'dueDate': _dateToJson(dueDate),
    if (appointment != null) 'appointment': _dateToJson(appointment),
    'done': done,
  };

  factory PathStep.fromJson(Map<String, Object?> j) => PathStep(
    id: j['id']! as String,
    templateKey: j['templateKey'] as String?,
    title: j['title'] as String?,
    note: j['note'] as String?,
    needs: _stringList(j['needs']),
    produces: _stringList(j['produces']),
    dueDaysAfterMoveIn: (j['dueDaysAfterMoveIn'] as num?)?.toInt(),
    dueDate: _dateFromJson(j['dueDate']),
    appointment: _dateFromJson(j['appointment']),
    done: (j['done'] as bool?) ?? false,
  );
}

List<String> _stringList(Object? v) =>
    v is List ? [for (final e in v) e as String] : const [];

class Plan {
  const Plan({
    this.moveInDate,
    this.docs = const [],
    this.steps = const [],
    this.nextId = 1,
  });

  static const int schemaVersion = 1;

  final DateTime? moveInDate;
  final List<Doc> docs;
  final List<PathStep> steps;

  /// Counter for new ids, so ids stay short and never repeat.
  final int nextId;

  bool get isEmpty => docs.isEmpty && steps.isEmpty;

  Doc? doc(String id) {
    for (final d in docs) {
      if (d.id == id) return d;
    }
    return null;
  }

  PathStep? step(String id) {
    for (final s in steps) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// Documents a step needs that are not in hand yet, in the step's order.
  List<Doc> missingFor(PathStep s) => [
    for (final id in s.needs)
      if (doc(id) case final d? when !d.have) d,
  ];

  StepStatus statusOf(PathStep s) {
    if (s.done) return StepStatus.done;
    return missingFor(s).isEmpty ? StepStatus.ready : StepStatus.waiting;
  }

  /// Steps that need the document.
  List<PathStep> stepsNeeding(String docId) => [
    for (final s in steps)
      if (s.needs.contains(docId)) s,
  ];

  /// Steps that give you the document.
  List<PathStep> stepsProducing(String docId) => [
    for (final s in steps)
      if (s.produces.contains(docId)) s,
  ];

  Plan copyWith({
    DateTime? moveInDate,
    List<Doc>? docs,
    List<PathStep>? steps,
    int? nextId,
  }) => Plan(
    moveInDate: moveInDate ?? this.moveInDate,
    docs: docs ?? this.docs,
    steps: steps ?? this.steps,
    nextId: nextId ?? this.nextId,
  );

  Plan withDoc(Doc d) =>
      copyWith(docs: [for (final x in docs) x.id == d.id ? d : x]);

  Plan withStep(PathStep s) =>
      copyWith(steps: [for (final x in steps) x.id == s.id ? s : x]);

  Plan addDoc(Doc Function(String id) build) {
    final d = build('d$nextId');
    return copyWith(docs: [...docs, d], nextId: nextId + 1);
  }

  Plan addStep(PathStep Function(String id) build) {
    final s = build('s$nextId');
    return copyWith(steps: [...steps, s], nextId: nextId + 1);
  }

  Plan removeDoc(String id) => copyWith(
    docs: [
      for (final d in docs)
        if (d.id != id) d,
    ],
    steps: [
      for (final s in steps)
        s.copyWith(
          needs: [
            for (final n in s.needs)
              if (n != id) n,
          ],
          produces: [
            for (final p in s.produces)
              if (p != id) p,
          ],
        ),
    ],
  );

  Plan removeStep(String id) => copyWith(
    steps: [
      for (final s in steps)
        if (s.id != id) s,
    ],
  );

  /// Marks a step done and puts every document it produces in hand.
  /// Returns the new plan and the documents that were newly received.
  (Plan, List<Doc>) complete(String stepId) {
    final s = step(stepId);
    if (s == null || s.done) return (this, const []);
    final received = <Doc>[];
    final newDocs = [
      for (final d in docs)
        if (s.produces.contains(d.id) && !d.have)
          (() {
            final got = d.copyWith(have: true);
            received.add(got);
            return got;
          })()
        else
          d,
    ];
    return (copyWith(docs: newDocs).withStep(s.copyWith(done: true)), received);
  }

  /// Marks a step not done. Documents stay in hand: the user may already hold
  /// them, and silently taking a document away would be surprising.
  Plan reopen(String stepId) {
    final s = step(stepId);
    if (s == null) return this;
    return withStep(s.copyWith(done: false));
  }

  /// Steps sorted for the list: overdue and soonest deadlines first, then
  /// steps without a deadline in plan order.
  List<PathStep> sortedSteps(StepStatus status) {
    final list = [
      for (final s in steps)
        if (statusOf(s) == status) s,
    ];
    final order = {for (var i = 0; i < steps.length; i++) steps[i].id: i};
    int key(PathStep s) {
      final due = s.effectiveDue(moveInDate) ?? s.appointment;
      return due == null ? 1 << 50 : due.millisecondsSinceEpoch ~/ 1000;
    }

    list.sort((a, b) {
      final c = key(a).compareTo(key(b));
      return c != 0 ? c : order[a.id]!.compareTo(order[b.id]!);
    });
    return list;
  }

  Map<String, Object?> toJson() => {
    'version': schemaVersion,
    if (moveInDate != null) 'moveInDate': _dateToJson(moveInDate),
    'nextId': nextId,
    'docs': [for (final d in docs) d.toJson()],
    'steps': [for (final s in steps) s.toJson()],
  };

  factory Plan.fromJson(Map<String, Object?> j) {
    final docs = [
      for (final d in (j['docs'] as List?) ?? const <Object?>[])
        Doc.fromJson((d as Map).cast<String, Object?>()),
    ];
    final steps = [
      for (final s in (j['steps'] as List?) ?? const <Object?>[])
        PathStep.fromJson((s as Map).cast<String, Object?>()),
    ];
    // Never hand out an id that is already taken, even if nextId is missing
    // or wrong in the file.
    var next = (j['nextId'] as num?)?.toInt() ?? 1;
    for (final id in [
      for (final d in docs) d.id,
      for (final s in steps) s.id,
    ]) {
      final n = int.tryParse(id.substring(1));
      if (n != null && n >= next) next = n + 1;
    }
    return Plan(
      moveInDate: _dateFromJson(j['moveInDate']),
      nextId: next,
      docs: docs,
      steps: steps,
    );
  }
}
