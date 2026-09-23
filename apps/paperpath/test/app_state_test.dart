import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:paperpath/model/plan.dart';
import 'package:paperpath/state/app_state.dart';
import 'package:paperpath/state/storage.dart';

void main() {
  test('first launch starts empty', () async {
    final s = await AppState.load(MemoryStorage());
    expect(s.plan.isEmpty, isTrue);
    expect(s.loadFailed, isFalse);
  });

  test('changes are saved and read back', () async {
    final storage = MemoryStorage();
    final s = await AppState.load(storage);
    s.update(s.plan.addDoc((id) => Doc(id: id, name: 'Passport')));
    await s.flush();
    final again = await AppState.load(storage);
    expect(again.plan.docs.single.name, 'Passport');
  });

  test('an unreadable file is kept aside and the app still starts', () async {
    final storage = MemoryStorage('{not json');
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.broken, '{not json');
    expect(s.plan.isEmpty, isTrue);
    s.dismissLoadError();
    expect(s.loadFailed, isFalse);
  });

  test('a failed save is reported and cleared by the next good save', () async {
    final storage = MemoryStorage()..failWrites = true;
    final s = await AppState.load(storage);
    s.update(s.plan.addDoc((id) => Doc(id: id, name: 'A')));
    await s.flush();
    expect(s.saveFailed, isTrue);
    storage.failWrites = false;
    s.update(s.plan.addDoc((id) => Doc(id: id, name: 'B')));
    await s.flush();
    expect(s.saveFailed, isFalse);
    expect((jsonDecode(storage.contents!) as Map)['docs'], hasLength(2));
  });

  test('FileStorage writes atomically into its directory', () async {
    final dir = await Directory.systemTemp.createTemp('pp');
    addTearDown(() => dir.delete(recursive: true));
    final f = FileStorage(dir);
    expect(await f.read(), isNull);
    await f.write('{"a":1}');
    await f.write('{"a":2}');
    expect(await f.read(), '{"a":2}');
    await f.keepBrokenCopy('x');
    expect(dir.listSync().length, 2);
  });
}
