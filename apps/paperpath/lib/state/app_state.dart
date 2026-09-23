import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../model/plan.dart';
import 'storage.dart';

/// Holds the plan, saves every change, and tells the UI to rebuild.
class AppState extends ChangeNotifier {
  AppState(this._storage, {this._plan = const Plan(), DateTime Function()? now})
    : now = now ?? DateTime.now;

  /// The clock, replaceable in tests and screenshots.
  final DateTime Function() now;

  final PlanStorage _storage;
  Plan _plan;
  Plan get plan => _plan;

  /// True when the saved file could not be read. A copy was kept aside.
  bool loadFailed = false;

  /// True when the last save failed; cleared by the next successful save.
  bool saveFailed = false;

  Future<void> _saving = Future.value();

  static Future<AppState> load(PlanStorage storage) async {
    final state = AppState(storage);
    String? raw;
    try {
      raw = await storage.read();
      if (raw != null) {
        final json = (jsonDecode(raw) as Map).cast<String, Object?>();
        state._plan = Plan.fromJson(json);
      }
    } on Object {
      state.loadFailed = true;
      if (raw != null) {
        try {
          await storage.keepBrokenCopy(raw);
        } on Object {
          // Nothing more can be done; the user still gets a working app.
        }
      }
    }
    return state;
  }

  void update(Plan next) {
    _plan = next;
    notifyListeners();
    final json = jsonEncode(next.toJson());
    _saving = _saving.then((_) async {
      try {
        await _storage.write(json);
        if (saveFailed) {
          saveFailed = false;
          notifyListeners();
        }
      } on Object {
        saveFailed = true;
        notifyListeners();
      }
    });
  }

  void dismissLoadError() {
    loadFailed = false;
    notifyListeners();
  }

  /// Completes when every pending save has finished. For tests.
  Future<void> flush() => _saving;
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
    : super(notifier: state);

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;

  static AppState read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
