import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

bool _loaded = false;

/// Loads Roboto from the Flutter SDK under the iOS system font family names,
/// and the CupertinoIcons font, so goldens show real text and icons.
Future<void> loadTestFonts() async {
  if (_loaded) return;
  _loaded = true;
  final root =
      Platform.environment['FLUTTER_ROOT'] ??
      '${Platform.environment['HOME']}/flutter';
  final dir = '$root/bin/cache/artifacts/material_fonts';
  ByteData bytes(String path) =>
      ByteData.sublistView(File(path).readAsBytesSync());
  for (final family in [
    'CupertinoSystemText',
    'CupertinoSystemDisplay',
    '.SF Pro Text',
    '.SF Pro Display',
    '.SF UI Text',
    '.SF UI Display',
    'Roboto',
  ]) {
    final loader = FontLoader(family);
    for (final f in [
      'Roboto-Regular.ttf',
      'Roboto-Medium.ttf',
      'Roboto-Bold.ttf',
    ]) {
      loader.addFont(Future.value(bytes('$dir/$f')));
    }
    await loader.load();
  }
  final config = jsonDecode(
    File('.dart_tool/package_config.json').readAsStringSync(),
  ) as Map<String, Object?>;
  for (final p in (config['packages']! as List).cast<Map<String, Object?>>()) {
    if (p['name'] == 'cupertino_icons') {
      final uri = Uri.parse(p['rootUri']! as String);
      final base = uri.isAbsolute ? uri.toFilePath() : '.dart_tool/${uri.path}';
      final loader = FontLoader('packages/cupertino_icons/CupertinoIcons')
        ..addFont(Future.value(bytes('$base/assets/CupertinoIcons.ttf')));
      await loader.load();
    }
  }
}
