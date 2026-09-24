import 'package:flutter/cupertino.dart';

import 'l10n/app_localizations.dart';
import 'state/app_state.dart';
import 'ui/overview_page.dart';
import 'ui/plan_page.dart';
import 'ui/settings_page.dart';
import 'ui/shifts_page.dart';
import 'ui/widgets.dart';

class HalfdayApp extends StatelessWidget {
  const HalfdayApp({super.key, required this.state, this.locale});

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
        // Dark text on the light indigo of dark mode; white would be too faint.
        primaryContrastingColor: onAccent,
      ),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeTabs(),
    ),
  );
}

/// Tab icons, shared with tests.
const overviewIcon = CupertinoIcons.chart_pie;
const shiftsIcon = CupertinoIcons.list_bullet;
const planIcon = CupertinoIcons.calendar;
const settingsIcon = CupertinoIcons.gear;

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(overviewIcon),
            label: l.tabOverview,
          ),
          BottomNavigationBarItem(
            icon: const Icon(shiftsIcon),
            label: l.tabShifts,
          ),
          BottomNavigationBarItem(icon: const Icon(planIcon), label: l.tabPlan),
          BottomNavigationBarItem(
            icon: const Icon(settingsIcon),
            label: l.tabSettings,
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (_) => switch (index) {
          0 => const OverviewPage(),
          1 => const ShiftsPage(),
          2 => const PlanPage(),
          _ => const SettingsPage(),
        },
      ),
    );
  }
}
