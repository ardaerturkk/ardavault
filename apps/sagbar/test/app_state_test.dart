import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sagbar/model/book.dart';
import 'package:sagbar/model/content.dart';
import 'package:sagbar/state/app_state.dart';
import 'package:sagbar/state/storage.dart';

void main() {
  test('first launch starts empty', () async {
    final s = await AppState.load(MemoryStorage());
    expect(s.book.hasProfile, isFalse);
    expect(s.loadFailed, isFalse);
  });

  test('changes are saved and read back', () async {
    final storage = MemoryStorage();
    final s = await AppState.load(storage);
    s.update(s.book.addLine('bank', 'Passport', ''));
    await s.flush();
    final again = await AppState.load(storage);
    expect(again.book.custom.single.german, 'Passport');
  });

  test('an unreadable file is kept aside and the app still starts', () async {
    final storage = MemoryStorage('{not json');
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.setAside, '{not json');
    expect(s.book.hasProfile, isFalse);
    s.dismissLoadError();
    expect(s.loadFailed, isFalse);
  });

  test(
    'if the bad file cannot be moved aside, nothing overwrites it',
    () async {
      final storage = MemoryStorage('{bad')..failSetAside = true;
      final s = await AppState.load(storage);
      s.update(s.book.addLine('bank', 'A', ''));
      await s.flush();
      expect(storage.contents, '{bad');
      expect(s.saveFailed, isTrue);
    },
  );

  test('a read error also sets the file aside', () async {
    final storage = MemoryStorage('{"custom":[]}')..failReads = true;
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.setAside, '{"custom":[]}');
  });

  test('a failed save is reported and cleared by the next good save', () async {
    final storage = MemoryStorage()..failWrites = true;
    final s = await AppState.load(storage);
    s.update(s.book.addLine('bank', 'A', ''));
    await s.flush();
    expect(s.saveFailed, isTrue);
    storage.failWrites = false;
    s.update(s.book.addLine('bank', 'B', ''));
    await s.flush();
    expect(s.saveFailed, isFalse);
    expect((jsonDecode(storage.contents!) as Map)['custom'], hasLength(2));
  });

  test('FileStorage writes atomically into its directory', () async {
    final dir = await Directory.systemTemp.createTemp('sb');
    addTearDown(() => dir.delete(recursive: true));
    final f = FileStorage(dir);
    expect(await f.read(), isNull);
    await f.write('{"a":1}');
    await f.write('{"a":2}');
    expect(await f.read(), '{"a":2}');
    await f.setAsideUnreadable();
    expect(await f.read(), isNull);
    expect(dir.listSync().single.path, contains('unreadable'));
  });
}
