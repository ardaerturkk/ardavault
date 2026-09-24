import 'package:flutter/cupertino.dart';

import 'l10n/app_localizations.dart';
import 'state/app_state.dart';
import 'ui/compare_page.dart';
import 'ui/flats_page.dart';
import 'ui/widgets.dart';

class FlatboardApp extends StatelessWidget {
  const FlatboardApp({super.key, required this.state, this.locale});

  final AppState state;

  /// Forced locale for tests and screenshots; null follows the device.
  final Locale? locale;

  @override
  Widget build(BuildContext context) => AppScope(
    state: state,
    child: CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: const CupertinoThemeData(primaryColor: accent),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeTabs(),
    ),
  );
}

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.house),
            activeIcon: const Icon(CupertinoIcons.house_fill),
            label: l.tabFlats,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.chart_bar),
            activeIcon: const Icon(CupertinoIcons.chart_bar_fill),
            label: l.tabCompare,
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (_) => index == 0 ? const FlatsPage() : const ComparePage(),
      ),
    );
  }
}
