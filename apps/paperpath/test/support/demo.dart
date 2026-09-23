import 'package:paperpath/model/plan.dart';
import 'package:paperpath/model/starter.dart';

/// "Today" for every golden and screenshot, so dates never drift.
final demoToday = DateTime(2026, 10, 6, 10);

/// A student five days after moving in: lease signed, photos and insurance
/// done, Anmeldung booked.
Plan typicalPlan() {
  var p = addStarter(const Plan(), DateTime(2026, 10));
  for (final id in ['s:signLease', 's:photo', 's:insurance']) {
    p = p.complete(id).$1;
  }
  p = p.withStep(
    p.step('s:anmeldung')!.copyWith(appointment: DateTime(2026, 10, 8, 9, 30)),
  );
  p = p.withStep(
    p.step('s:residencePermit')!.copyWith(dueDate: DateTime(2026, 12, 20)),
  );
  return p;
}

/// Late on the Anmeldung, with custom steps and long names.
Plan heavyPlan() {
  var p = addStarter(const Plan(), DateTime(2026, 9, 10));
  for (final id in ['s:signLease', 's:photo']) {
    p = p.complete(id).$1;
  }
  p = p.addDoc(
    (id) => Doc(
      id: id,
      name: 'Bescheinigung über die Anmeldung beim Studierendenwerk',
      note: 'Two copies, signed',
    ),
  );
  final extra = p.docs.last.id;
  p = p.addStep(
    (id) => PathStep(
      id: id,
      title: 'Apply for a Room in a Student Residence Hall Near the Campus',
      note: 'Studierendenwerk Schleswig-Holstein, Westring 385',
      needs: const ['d:passport', 'd:enrollment'],
      produces: [extra],
      dueDate: DateTime(2026, 10, 7),
    ),
  );
  p = p.addStep(
    (id) => PathStep(
      id: id,
      title: 'Get a Library Card',
      needs: const ['d:enrollment'],
    ),
  );
  p = p.addStep((id) => PathStep(id: id, title: 'Buy a Bike Lock'));
  p = p.withStep(
    p.step('s:residencePermit')!.copyWith(dueDate: DateTime(2026, 10, 9)),
  );
  return p;
}

/// Everything done: the end of the path.
Plan finishedPlan() {
  var p = addStarter(const Plan(), DateTime(2026, 8));
  for (var i = 0; i < 20; i++) {
    final ready = p.sortedSteps(StepStatus.ready);
    if (ready.isEmpty) break;
    p = p.complete(ready.first.id).$1;
  }
  return p;
}
