import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:paperpath/model/plan.dart';
import 'package:paperpath/model/starter.dart';

void main() {
  final moveIn = DateTime(2026, 10);

  group('starter set', () {
    test('references only documents that exist', () {
      final plan = addStarter(const Plan(), moveIn);
      final ids = {for (final d in plan.docs) d.id};
      for (final s in plan.steps) {
        expect(ids, containsAll(s.needs), reason: s.id);
        expect(ids, containsAll(s.produces), reason: s.id);
      }
    });

    test('every missing document can be obtained by some step', () {
      final plan = addStarter(const Plan(), moveIn);
      for (final d in plan.docs.where((d) => !d.have)) {
        expect(plan.stepsProducing(d.id), isNotEmpty, reason: d.id);
      }
    });

    test('adding twice does not duplicate', () {
      final once = addStarter(const Plan(), moveIn);
      final twice = addStarter(once, moveIn);
      expect(twice.docs.length, once.docs.length);
      expect(twice.steps.length, once.steps.length);
    });

    test('Anmeldung is due 14 days after moving in', () {
      final plan = addStarter(const Plan(), moveIn);
      expect(
        plan.step('s:anmeldung')!.effectiveDue(plan.moveInDate),
        DateTime(2026, 10, 15),
      );
    });

    test('the whole path can be walked to the end', () {
      var plan = addStarter(const Plan(), moveIn);
      for (var round = 0; round < plan.steps.length; round++) {
        final ready = plan.sortedSteps(StepStatus.ready);
        if (ready.isEmpty) break;
        plan = plan.complete(ready.first.id).$1;
      }
      expect(plan.sortedSteps(StepStatus.done).length, plan.steps.length);
    });
  });

  group('status', () {
    Plan base() => const Plan(
      docs: [
        Doc(id: 'a', name: 'A', have: true),
        Doc(id: 'b', name: 'B'),
      ],
      steps: [
        PathStep(id: 's1', title: 'Get B', needs: ['a'], produces: ['b']),
        PathStep(id: 's2', title: 'Use B', needs: ['a', 'b']),
      ],
    );

    test('ready when every needed document is in hand', () {
      final p = base();
      expect(p.statusOf(p.step('s1')!), StepStatus.ready);
      expect(p.statusOf(p.step('s2')!), StepStatus.waiting);
      expect(p.missingFor(p.step('s2')!).map((d) => d.id), ['b']);
    });

    test('completing a step hands over its documents and unlocks others', () {
      final (p, received) = base().complete('s1');
      expect(received.map((d) => d.id), ['b']);
      expect(p.doc('b')!.have, isTrue);
      expect(p.statusOf(p.step('s1')!), StepStatus.done);
      expect(p.statusOf(p.step('s2')!), StepStatus.ready);
    });

    test('completing twice receives nothing the second time', () {
      final (p, _) = base().complete('s1');
      expect(p.complete('s1').$2, isEmpty);
    });

    test('reopening keeps documents in hand', () {
      final (p, _) = base().complete('s1');
      final r = p.reopen('s1');
      expect(r.step('s1')!.done, isFalse);
      expect(r.doc('b')!.have, isTrue);
    });

    test('removing a document removes it from every step', () {
      final p = base().removeDoc('b');
      expect(p.step('s1')!.produces, isEmpty);
      expect(p.step('s2')!.needs, ['a']);
      expect(p.statusOf(p.step('s2')!), StepStatus.ready);
    });

    test('new ids never repeat', () {
      var p = const Plan();
      p = p.addDoc((id) => Doc(id: id, name: 'X'));
      p = p.removeDoc(p.docs.single.id);
      p = p.addDoc((id) => Doc(id: id, name: 'Y'));
      p = p.addStep((id) => PathStep(id: id, title: 'Z'));
      expect({p.docs.single.id, p.steps.single.id}.length, 2);
      expect(p.docs.single.id, isNot('d1'));
    });
  });

  group('deadlines and order', () {
    test('explicit due date wins over relative days', () {
      final s = const PathStep(
        id: 's',
        dueDaysAfterMoveIn: 3,
      ).copyWith(dueDate: DateTime(2026, 12, 24, 15));
      expect(s.dueDaysAfterMoveIn, isNull);
      expect(s.effectiveDue(DateTime(2026, 10)), DateTime(2026, 12, 24));
    });

    test('no move-in date means no relative deadline', () {
      const s = PathStep(id: 's', dueDaysAfterMoveIn: 3);
      expect(s.effectiveDue(null), isNull);
    });

    test('clearDue removes both kinds of deadline', () {
      final s = const PathStep(
        id: 's',
        dueDaysAfterMoveIn: 3,
      ).copyWith(clearDue: true);
      expect(s.effectiveDue(DateTime(2026)), isNull);
    });

    test('sorted by deadline, undated last in plan order', () {
      final p = Plan(
        moveInDate: DateTime(2026, 10),
        steps: [
          const PathStep(id: 'x'),
          const PathStep(id: 'late', dueDaysAfterMoveIn: 30),
          PathStep(id: 'soon', dueDate: DateTime(2026, 10, 3)),
          const PathStep(id: 'y'),
        ],
      );
      expect(p.sortedSteps(StepStatus.ready).map((s) => s.id), [
        'soon',
        'late',
        'x',
        'y',
      ]);
    });
  });

  group('calendar days across clock changes', () {
    test('relative deadline counts calendar days', () {
      // Europe: clocks go back on 25 Oct 2026.
      const s = PathStep(id: 's', dueDaysAfterMoveIn: 14);
      expect(s.effectiveDue(DateTime(2026, 10, 20)), DateTime(2026, 11, 3));
      const t = PathStep(id: 't', dueDaysAfterMoveIn: 30);
      expect(t.effectiveDue(DateTime(2027, 3)), DateTime(2027, 3, 31));
    });
  });

  test('ids from a file without nextId never collide', () {
    final p = Plan.fromJson(const {
      'docs': [
        {'id': 'd4', 'name': 'A'},
      ],
      'steps': [
        {'id': 's7', 'title': 'B'},
      ],
    });
    final q = p.addDoc((id) => Doc(id: id, name: 'C'));
    expect(q.docs.last.id, 'd8');
  });

  test('JSON round trip keeps everything', () {
    var p = addStarter(const Plan(), moveIn);
    p = p.withStep(
      p.step('s:bank')!.copyWith(appointment: DateTime(2026, 10, 7, 9, 30)),
    );
    p = p.addDoc((id) => Doc(id: id, name: 'Custom', note: 'Two copies'));
    p = p.complete('s:signLease').$1;
    final back = Plan.fromJson(
      (jsonDecode(jsonEncode(p.toJson())) as Map).cast<String, Object?>(),
    );
    expect(jsonEncode(back.toJson()), jsonEncode(p.toJson()));
  });

  test('tolerates missing fields', () {
    final p = Plan.fromJson(const {});
    expect(p.isEmpty, isTrue);
    expect(p.moveInDate, isNull);
  });
}
