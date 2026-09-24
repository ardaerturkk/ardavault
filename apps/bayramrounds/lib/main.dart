import 'package:flutter/cupertino.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import 'app.dart';
import 'state/app_state.dart';
import 'state/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();
  final state = await AppState.load(FileStorage());
  WidgetsBinding.instance.addObserver(state);
  runApp(BayramApp(state: state));
}
