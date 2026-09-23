import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Where the plan's JSON lives. Tests use [MemoryStorage].
abstract class PlanStorage {
  Future<String?> read();
  Future<void> write(String json);

  /// Moves an unreadable saved plan aside so the next save cannot overwrite
  /// it. Throws if that is not possible.
  Future<void> setAsideUnreadable();
}

class FileStorage implements PlanStorage {
  FileStorage([this._dir]);

  Directory? _dir;

  Future<File> _file(String name) async {
    _dir ??= await getApplicationDocumentsDirectory();
    return File('${_dir!.path}/$name');
  }

  @override
  Future<String?> read() async {
    final f = await _file('paperpath.json');
    return await f.exists() ? f.readAsString() : null;
  }

  @override
  Future<void> write(String json) async {
    final tmp = await _file('paperpath.json.tmp');
    await tmp.writeAsString(json, flush: true);
    await tmp.rename((await _file('paperpath.json')).path);
  }

  @override
  Future<void> setAsideUnreadable() async {
    final f = await _file('paperpath.json');
    if (!await f.exists()) return;
    final stamp = DateTime.now().millisecondsSinceEpoch;
    await f.rename((await _file('paperpath-unreadable-$stamp.json')).path);
  }
}

class MemoryStorage implements PlanStorage {
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
