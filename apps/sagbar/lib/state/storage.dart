import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Where the app's JSON lives. Tests use [MemoryStorage].
abstract class BookStorage {
  Future<String?> read();
  Future<void> write(String json);

  /// Moves an unreadable saved data aside so the next save cannot overwrite
  /// it. Throws if that is not possible.
  Future<void> setAsideUnreadable();
}

class FileStorage implements BookStorage {
  FileStorage([this._dir]);

  Directory? _dir;

  Future<File> _file(String name) async {
    _dir ??= await getApplicationDocumentsDirectory();
    return File('${_dir!.path}/$name');
  }

  @override
  Future<String?> read() async {
    final f = await _file('sagbar.json');
    return await f.exists() ? f.readAsString() : null;
  }

  @override
  Future<void> write(String json) async {
    final tmp = await _file('sagbar.json.tmp');
    await tmp.writeAsString(json, flush: true);
    await tmp.rename((await _file('sagbar.json')).path);
  }

  @override
  Future<void> setAsideUnreadable() async {
    final f = await _file('sagbar.json');
    if (!await f.exists()) return;
    final stamp = DateTime.now().millisecondsSinceEpoch;
    await f.rename((await _file('sagbar-unreadable-$stamp.json')).path);
  }
}

class MemoryStorage implements BookStorage {
  MemoryStorage([this.contents]);

  String? contents;
  String? setAside;
  bool failReads = false;
  bool failWrites = false;
  bool failSetAside = false;

  @override
  Future<String?> read() async {
    if (failReads) throw const FileSystemException('read failed');
    return contents;
  }

  @override
  Future<void> write(String json) async {
    if (failWrites) throw const FileSystemException('write failed');
    contents = json;
  }

  @override
  Future<void> setAsideUnreadable() async {
    if (failSetAside) throw const FileSystemException('rename failed');
    setAside = contents;
    contents = null;
  }
}
