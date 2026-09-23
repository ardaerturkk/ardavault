import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Where the plan's JSON lives. Tests use [MemoryStorage].
abstract class PlanStorage {
  Future<String?> read();
  Future<void> write(String json);

  /// Keeps an unreadable file aside so nothing is lost for good.
  Future<void> keepBrokenCopy(String contents);
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
  Future<void> keepBrokenCopy(String contents) async {
    final f = await _file(
      'paperpath-unreadable-${DateTime.now().millisecondsSinceEpoch}.json',
    );
    await f.writeAsString(contents, flush: true);
  }
}

class MemoryStorage implements PlanStorage {
  MemoryStorage([this.contents]);

  String? contents;
  String? broken;
  bool failWrites = false;

  @override
  Future<String?> read() async => contents;

  @override
  Future<void> write(String json) async {
    if (failWrites) throw const FileSystemException('write failed');
    contents = json;
  }

  @override
  Future<void> keepBrokenCopy(String contents) async => broken = contents;
}
