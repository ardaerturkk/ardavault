import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flathunt/model/board.dart';
import 'package:flathunt/state/app_state.dart';
import 'package:flathunt/state/storage.dart';

Flat probe(String id, String title) => Flat(
  id: id,
  title: title,
  stageSince: DateTime(2026, 10),
  createdAt: DateTime(2026, 10),
);

void main() {
  test('first launch starts empty', () async {
    final s = await AppState.load(MemoryStorage());
    expect(s.board.isEmpty, isTrue);
    expect(s.loadFailed, isFalse);
  });

  test('changes are saved and read back', () async {
    final storage = MemoryStorage();
    final s = await AppState.load(storage);
    s.update(s.board.add((id) => probe(id, 'Passport')));
    await s.flush();
    final again = await AppState.load(storage);
    expect(again.board.flats.single.title, 'Passport');
  });

  test('an unreadable file is kept aside and the app still starts', () async {
    final storage = MemoryStorage('{not json');
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.setAside, '{not json');
    expect(s.board.isEmpty, isTrue);
    s.dismissLoadError();
    expect(s.loadFailed, isFalse);
  });

  test(
    'if the bad file cannot be moved aside, nothing overwrites it',
    () async {
      final storage = MemoryStorage('{bad')..failSetAside = true;
      final s = await AppState.load(storage);
      s.update(s.board.add((id) => probe(id, 'A')));
      await s.flush();
      expect(storage.contents, '{bad');
      expect(s.saveFailed, isTrue);
    },
  );

  test('a read error also sets the file aside', () async {
    final storage = MemoryStorage('{"flats":[]}')..failReads = true;
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.setAside, '{"flats":[]}');
  });

  test('a failed save is reported and cleared by the next good save', () async {
    final storage = MemoryStorage()..failWrites = true;
    final s = await AppState.load(storage);
    s.update(s.board.add((id) => probe(id, 'A')));
    await s.flush();
    expect(s.saveFailed, isTrue);
    storage.failWrites = false;
    s.update(s.board.add((id) => probe(id, 'B')));
    await s.flush();
    expect(s.saveFailed, isFalse);
    expect((jsonDecode(storage.contents!) as Map)['flats'], hasLength(2));
  });

  test('FileStorage writes atomically into its directory', () async {
    final dir = await Directory.systemTemp.createTemp('fh');
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
