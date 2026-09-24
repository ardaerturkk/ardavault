import 'package:flutter/cupertino.dart';

import 'l10n/app_localizations.dart';
import 'state/app_state.dart';
import 'ui/me_page.dart';
import 'ui/situations_page.dart';
import 'ui/widgets.dart';

class SagbarApp extends StatelessWidget {
  const SagbarApp({super.key, required this.state, this.locale});

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

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  final _controller = CupertinoTabController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.text_bubble),
            label: l.tabSituations,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person_crop_circle),
            label: l.tabMe,
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (_) => index == 0
            ? SituationsPage(onOpenMe: () => _controller.index = 1)
            : const MePage(),
      ),
    );
  }
}
