import 'package:flutter/cupertino.dart';

import 'l10n/app_localizations.dart';
import 'state/app_state.dart';
import 'ui/calls_page.dart';
import 'ui/people_page.dart';
import 'ui/widgets.dart';

class BayramApp extends StatelessWidget {
  const BayramApp({super.key, required this.state, this.locale});

  final AppState state;

  /// Forced locale for tests and screenshots; null follows the device.
  final Locale? locale;

  @override
  Widget build(BuildContext context) => AppScope(
    state: state,
    child: CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: const CupertinoThemeData(
        primaryColor: accent,
        primaryContrastingColor: onAccent,
      ),
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
            icon: const Icon(CupertinoIcons.phone),
            activeIcon: const Icon(CupertinoIcons.phone_fill),
            label: l.tabCalls,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person_2),
            activeIcon: const Icon(CupertinoIcons.person_2_fill),
            label: l.tabPeople,
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (_) => index == 0 ? const CallsPage() : const PeoplePage(),
      ),
    );
  }
}
