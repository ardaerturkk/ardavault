import 'plan.dart';

/// The Germany starter set for a non-EU student. Names and notes are
/// localized in the ARB files through [templateKey]; the ids here are stable.
class StarterDoc {
  const StarterDoc(this.key, {this.have = false});
  final String key;
  final bool have;
}

class StarterStep {
  const StarterStep(
    this.key, {
    this.needs = const [],
    this.produces = const [],
    this.dueDays,
  });
  final String key;
  final List<String> needs;
  final List<String> produces;
  final int? dueDays;
}

const starterDocs = <StarterDoc>[
  StarterDoc('passport', have: true),
  StarterDoc('visa', have: true),
  StarterDoc('admission', have: true),
  StarterDoc('blockedAccount', have: true),
  StarterDoc('photo'),
  StarterDoc('rentalContract'),
  StarterDoc('landlordConfirmation'),
  StarterDoc('registration'),
  StarterDoc('insurance'),
  StarterDoc('enrollment'),
  StarterDoc('bankAccount'),
  StarterDoc('taxId'),
  StarterDoc('broadcastNumber'),
  StarterDoc('residencePermit'),
];

const starterSteps = <StarterStep>[
  StarterStep(
    'signLease',
    needs: ['passport'],
    produces: ['rentalContract', 'landlordConfirmation'],
  ),
  StarterStep(
    'anmeldung',
    needs: ['passport', 'landlordConfirmation'],
    produces: ['registration'],
    dueDays: 14,
  ),
  StarterStep(
    'insurance',
    needs: ['passport', 'admission'],
    produces: ['insurance'],
  ),
  StarterStep(
    'enroll',
    needs: ['passport', 'visa', 'admission', 'insurance'],
    produces: ['enrollment'],
  ),
  StarterStep(
    'bank',
    needs: ['passport', 'registration'],
    produces: ['bankAccount'],
  ),
  StarterStep('blockedPayout', needs: ['blockedAccount', 'bankAccount']),
  StarterStep('taxId', needs: ['registration'], produces: ['taxId']),
  StarterStep(
    'broadcastFee',
    needs: ['registration'],
    produces: ['broadcastNumber'],
    dueDays: 30,
  ),
  StarterStep('photo', produces: ['photo']),
  StarterStep(
    'residencePermit',
    needs: [
      'passport',
      'visa',
      'photo',
      'registration',
      'enrollment',
      'insurance',
      'blockedAccount',
      'rentalContract',
    ],
    produces: ['residencePermit'],
  ),
];

/// Adds the starter set to [plan]. Ids are `d:<key>` and `s:<key>` so adding
/// the set twice never duplicates anything.
Plan addStarter(Plan plan, DateTime moveIn) {
  final haveDocs = {for (final d in plan.docs) d.id};
  final haveSteps = {for (final s in plan.steps) s.id};
  return plan.copyWith(
    moveInDate: dateOnly(moveIn),
    docs: [
      ...plan.docs,
      for (final d in starterDocs)
        if (!haveDocs.contains('d:${d.key}'))
          Doc(id: 'd:${d.key}', templateKey: d.key, have: d.have),
    ],
    steps: [
      ...plan.steps,
      for (final s in starterSteps)
        if (!haveSteps.contains('s:${s.key}'))
          PathStep(
            id: 's:${s.key}',
            templateKey: s.key,
            needs: [for (final n in s.needs) 'd:$n'],
            produces: [for (final p in s.produces) 'd:$p'],
            dueDaysAfterMoveIn: s.dueDays,
          ),
    ],
  );
}
