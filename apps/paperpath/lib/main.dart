import 'package:flutter/cupertino.dart';

import 'app.dart';
import 'state/app_state.dart';
import 'state/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = await AppState.load(FileStorage());
  runApp(PaperpathApp(state: state));
}
