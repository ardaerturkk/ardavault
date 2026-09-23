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
      find.text('You now have Registration Certificate (Meldebescheinigung).'),
      findsOneWidget,
    );
    expect(find.text('Mark as Not Done'), findsOneWidget);
    expect(state.plan.doc('d:registration')!.have, isTrue);
    expect(state.plan.statusOf(state.plan.step('s:bank')!), StepStatus.ready);
    await t.pageBack();
    await t.pumpAndSettle();
    expect(find.text('Open a Bank Account'), findsOneWidget);
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
    await tapText(t, 'Needs');
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
