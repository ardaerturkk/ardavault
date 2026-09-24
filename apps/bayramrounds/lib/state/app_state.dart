import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../model/book.dart';
import 'storage.dart';

/// Holds the book, saves every change, and tells the UI to rebuild.
class AppState extends ChangeNotifier with WidgetsBindingObserver {
  AppState(this._storage, {this._book = const Book(), DateTime Function()? now})
    : now = now ?? DateTime.now;

  /// The clock, replaceable in tests and screenshots.
  final DateTime Function() now;

  final BookStorage _storage;
  Book _book;
  Book get book => _book;

  /// True when the saved file could not be read. A copy was kept aside.
  bool loadFailed = false;

  /// True when the last save failed; cleared by the next successful save.
  bool saveFailed = false;

  Future<void> _saving = Future.value();

  /// True when the saved file could not be read or moved aside. Saving is
  /// then off for this launch so the original file is never overwritten.
  bool _writesBlocked = false;

  static Future<AppState> load(BookStorage storage) async {
    final state = AppState(storage);
    try {
      final raw = await storage.read();
      if (raw != null) {
        final json = (jsonDecode(raw) as Map).cast<String, Object?>();
        state._book = Book.fromJson(json);
      }
    } on Object {
      state.loadFailed = true;
      try {
        await storage.setAsideUnreadable();
      } on Object {
        state._writesBlocked = true;
      }
    }
    return state;
  }

  void update(Book next) {
    _book = next;
    notifyListeners();
    if (_writesBlocked) {
      saveFailed = true;
      return;
    }
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

  /// Coming back after a while in the background: which round is open and
  /// the local times depend on the clock, so rebuild.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) notifyListeners();
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
