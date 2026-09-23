import 'package:flutter/cupertino.dart';

import 'l10n/app_localizations.dart';
import 'state/app_state.dart';
import 'ui/documents_page.dart';
import 'ui/steps_page.dart';
import 'ui/widgets.dart';

class PaperpathApp extends StatelessWidget {
  const PaperpathApp({super.key, required this.state, this.locale});

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
            icon: const Icon(CupertinoIcons.list_bullet),
            label: l.tabSteps,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.doc_on_doc),
            label: l.tabDocuments,
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (_) => index == 0 ? const StepsPage() : const DocumentsPage(),
      ),
    );
  }
}
