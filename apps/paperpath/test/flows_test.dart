import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paperpath/app.dart';
import 'package:paperpath/model/plan.dart';
import 'package:paperpath/state/app_state.dart';
import 'package:paperpath/state/storage.dart';

import 'support/demo.dart';

Future<(AppState, MemoryStorage)> start(
  WidgetTester t, [
  Plan plan = const Plan(),
]) async {
  t.view.physicalSize = const Size(440, 956) * 3;
  t.view.devicePixelRatio = 3;
  addTearDown(t.view.reset);
  final storage = MemoryStorage();
  final state = AppState(storage, plan: plan, now: () => demoToday);
  await t.pumpWidget(PaperpathApp(state: state, locale: const Locale('en')));
  await t.pumpAndSettle();
  return (state, storage);
}

Future<void> tapText(WidgetTester t, String text) async {
  final f = find.text(text).last;
  await t.ensureVisible(f);
  await t.pumpAndSettle();
  await t.tap(f);
  await t.pumpAndSettle();
}

void main() {
  testWidgets('starter steps: pick a move-in date and get a plan', (t) async {
    final (state, storage) = await start(t);
    expect(find.text('No Steps Yet'), findsOneWidget);
    await tapText(t, 'Add Germany Starter Steps');
    expect(find.text('When Do You Move In?'), findsOneWidget);
    await tapText(t, 'Continue');
    expect(state.plan.steps, hasLength(10));
    expect(state.plan.moveInDate, DateTime(2026, 10, 6));
    expect(find.text('Ready'), findsOneWidget);
    expect(find.text('Sign the Lease'), findsOneWidget);
    await state.flush();
    expect(jsonDecode(storage.contents!), isA<Map<String, Object?>>());
  });

  testWidgets('cancelling the move-in sheet adds nothing', (t) async {
    final (state, _) = await start(t);
    await tapText(t, 'Add Germany Starter Steps');
    await tapText(t, 'Cancel');
    expect(state.plan.isEmpty, isTrue);
  });

  testWidgets('finishing a step hands over documents and unlocks others', (
    t,
  ) async {
    final (state, _) = await start(t, typicalPlan());
    expect(state.plan.statusOf(state.plan.step('s:bank')!), StepStatus.waiting);
    await tapText(t, 'Register Your Address (Anmeldung)');
    expect(find.text('Bring'), findsOneWidget);
    await tapText(t, 'Mark as Done');
    expect(
      find.textContaining('You now have Registration Certificate'),
      findsOneWidget,
    );
    expect(find.text('Mark as Not Done'), findsOneWidget);
    expect(state.plan.doc('d:registration')!.have, isTrue);
    expect(state.plan.statusOf(state.plan.step('s:bank')!), StepStatus.ready);
    await t.pageBack();
    await t.pumpAndSettle();
    expect(find.text('Open a Bank Account'), findsOneWidget);
  });

  testWidgets('a waiting step asks before it is marked done', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Open a Bank Account');
    await tapText(t, 'Mark as Done');
    expect(find.textContaining('1 document is still missing'), findsOneWidget);
    await tapText(t, 'Cancel');
    expect(state.plan.step('s:bank')!.done, isFalse);
    await tapText(t, 'Mark as Done');
    await tapText(t, 'Mark as Done');
    expect(state.plan.step('s:bank')!.done, isTrue);
  });

  testWidgets('tapping a needed document marks it in hand', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Visa (National D Visa)');
    expect(state.plan.doc('d:visa')!.have, isFalse);
    expect(
      state.plan.statusOf(state.plan.step('s:enroll')!),
      StepStatus.waiting,
    );
    await tapText(t, 'Visa (National D Visa)');
    expect(state.plan.doc('d:visa')!.have, isTrue);
  });

  testWidgets('add your own step', (t) async {
    final (state, _) = await start(t);
    await tapText(t, 'Add Your Own Step');
    expect(find.text('New Step'), findsOneWidget);
    await t.enterText(find.byType(CupertinoTextField).first, 'Buy a Bike');
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    expect(state.plan.steps.single.title, 'Buy a Bike');
    expect(find.text('Buy a Bike'), findsOneWidget);
  });

  testWidgets('cancel asks before throwing away edits', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Edit');
    await t.enterText(find.byType(CupertinoTextField).first, 'Enroll');
    await t.pumpAndSettle();
    await tapText(t, 'Cancel');
    await tapText(t, 'Keep Editing');
    expect(find.text('Edit Step'), findsOneWidget);
    await tapText(t, 'Cancel');
    await tapText(t, 'Discard Changes');
    expect(find.text('Edit Step'), findsNothing);
    expect(state.plan.step('s:enroll')!.title, isNull);
  });

  testWidgets('save is disabled without a title', (t) async {
    final (state, _) = await start(t);
    await tapText(t, 'Add Your Own Step');
    await tapText(t, 'Save');
    expect(find.text('New Step'), findsOneWidget);
    expect(state.plan.steps, isEmpty);
  });

  testWidgets('editing a starter step without changes keeps it localized', (
    t,
  ) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Edit');
    await tapText(t, 'Save');
    expect(state.plan.step('s:enroll')!.title, isNull);
  });

  testWidgets('choose needed documents and create one on the way', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Edit');
    await tapText(t, 'Bring');
    await tapText(t, 'New Document');
    await t.enterText(
      find.byType(CupertinoTextField).first,
      'Semester Fee Receipt',
    );
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    expect(find.byIcon(CupertinoIcons.checkmark), findsNWidgets(5));
    await t.pageBack();
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    final step = state.plan.step('s:enroll')!;
    final doc = state.plan.docs.last;
    expect(doc.name, 'Semester Fee Receipt');
    expect(step.needs, contains(doc.id));
    expect(state.plan.statusOf(step), StepStatus.waiting);
  });

  testWidgets('deleting a step closes its screen', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Edit');
    await tapText(t, 'Delete Step');
    await tapText(t, 'Delete Step');
    expect(state.plan.step('s:enroll'), isNull);
    expect(find.text('Steps'), findsWidgets);
    expect(find.text('Enroll at the University'), findsNothing);
  });

  testWidgets('deleting a step open twice in the stack leaves cleanly', (
    t,
  ) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Register Your Address (Anmeldung)');
    await tapText(t, 'Registration Certificate (Meldebescheinigung)');
    await tapText(t, 'Open a Bank Account');
    await tapText(t, 'Edit');
    await tapText(t, 'Delete Step');
    await tapText(t, 'Delete Step');
    expect(state.plan.step('s:bank'), isNull);
    // Back on the document page, with the Anmeldung page still below it.
    expect(find.text('Comes From'), findsOneWidget);
    await t.pageBack();
    await t.pumpAndSettle();
    expect(find.text('Mark as Done'), findsOneWidget);
  });

  testWidgets('confirming the same deadline keeps it tied to move-in', (
    t,
  ) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Register Your Address (Anmeldung)');
    await tapText(t, 'Deadline');
    await tapText(t, 'Done');
    expect(state.plan.step('s:anmeldung')!.dueDaysAfterMoveIn, 14);
  });

  testWidgets('a step cannot need what it gives', (t) async {
    await start(t, typicalPlan());
    await tapText(t, 'Open a Bank Account');
    await tapText(t, 'Edit');
    await tapText(t, 'Bring');
    expect(find.text('German Bank Account (IBAN)'), findsNothing);
  });

  testWidgets('set and remove a deadline', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Deadline');
    await tapText(t, 'Done');
    expect(
      state.plan.step('s:enroll')!.effectiveDue(null),
      DateTime(2026, 10, 6),
    );
    expect(find.text('Oct 6'), findsOneWidget);
    await tapText(t, 'Deadline');
    await tapText(t, 'Remove Deadline');
    expect(state.plan.step('s:enroll')!.effectiveDue(null), isNull);
  });

  testWidgets('set an appointment', (t) async {
    final (state, _) = await start(t, typicalPlan());
    await tapText(t, 'Enroll at the University');
    await tapText(t, 'Appointment');
    await tapText(t, 'Done');
    expect(state.plan.step('s:enroll')!.appointment, DateTime(2026, 10, 7, 9));
    expect(find.textContaining(RegExp(r'Oct 7, 9:00.AM')), findsOneWidget);
  });

  testWidgets('documents: add, mark in hand, delete', (t) async {
    final (state, _) = await start(t);
    await t.tap(find.byIcon(CupertinoIcons.doc_on_doc).first);
    await t.pumpAndSettle();
    expect(find.text('No Documents Yet'), findsOneWidget);
    await tapText(t, 'Add Document');
    await t.enterText(find.byType(CupertinoTextField).first, 'Passport');
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    expect(find.text('Missing'), findsOneWidget);
    await tapText(t, 'Passport');
    await t.tap(find.byType(CupertinoSwitch));
    await t.pumpAndSettle();
    expect(state.plan.docs.single.have, isTrue);
    await tapText(t, 'Edit');
    await tapText(t, 'Delete Document');
    await tapText(t, 'Delete Document');
    expect(state.plan.docs, isEmpty);
    expect(find.text('No Documents Yet'), findsOneWidget);
  });

  testWidgets('load error banner can be dismissed', (t) async {
    t.view.physicalSize = const Size(440, 956) * 3;
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    final state = await AppState.load(MemoryStorage('broken'));
    await t.pumpWidget(PaperpathApp(state: state, locale: const Locale('en')));
    await t.pumpAndSettle();
    expect(find.textContaining('could not be read'), findsOneWidget);
    await tapText(t, 'OK');
    expect(find.textContaining('could not be read'), findsNothing);
  });

  testWidgets('German and Turkish load', (t) async {
    for (final (locale, title) in [('de', 'Schritte'), ('tr', 'Adımlar')]) {
      final state = AppState(MemoryStorage(), plan: typicalPlan());
      await t.pumpWidget(PaperpathApp(state: state, locale: Locale(locale)));
      await t.pumpAndSettle();
      expect(find.text(title), findsWidgets);
    }
  });
}
