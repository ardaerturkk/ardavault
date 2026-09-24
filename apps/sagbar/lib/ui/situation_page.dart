import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/book.dart';
import '../model/content.dart';
import '../state/app_state.dart';
import 'card_page.dart';
import 'field_edit_page.dart';
import 'line_edit_page.dart';
import 'line_text.dart';
import 'me_page.dart';
import 'names.dart';
import 'widgets.dart';

class SituationPage extends StatelessWidget {
  const SituationPage({
    super.key,
    required this.situationId,
    this.previousTitle,
  });
  final String situationId;
  final String? previousTitle;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final book = state.book;
    final l = context.l;
    final s = situationById(situationId)!;
    final lines = book.linesFor(s, meaningLocale(l));
    final missing = [
      for (final slot in book.missingFor(s, meaningLocale(l)))
        if (profileSlots.contains(slot)) slot,
    ];
    final hiddenCount = book.hiddenCount(s.id);
    final visit = book.visit(s.id);
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final theme = CupertinoTheme.of(context).textTheme;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text(s.german),
                  previousPageTitle: previousTitle,
                  trailing: AddButton(
                    label: l.addLine,
                    onPressed: () => openLineEditor(context, situation: s),
                  ),
                ),
                SliverSafeArea(
                  top: false,
                  bottom: false,
                  sliver: SliverList.list(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          s.purpose(l.localeName),
                          style: theme.textStyle.copyWith(color: secondary),
                        ),
                      ),
                      const ProblemBanner(),
                      if (missing.isNotEmpty)
                        CupertinoListSection.insetGrouped(
                          header: Text(l.fillMissing),
                          children: [
                            for (final slot in missing) DetailTile(slot: slot),
                          ],
                        ),
                      if (s.hasAppointment || s.refLabel != null)
                        CupertinoListSection.insetGrouped(
                          header: Text(l.visitHeader),
                          children: [
                            if (s.hasAppointment)
                              ValueTile(
                                leading: Icon(
                                  CupertinoIcons.clock,
                                  color: accent.resolveFrom(context),
                                ),
                                label: l.appointment,
                                value: visit.appointment == null
                                    ? l.notSet
                                    : appointmentText(
                                        l,
                                        visit.appointment!,
                                        use24h:
                                            MediaQuery.alwaysUse24HourFormatOf(
                                              context,
                                            ),
                                      ),
                                valueColor: visit.appointment == null
                                    ? CupertinoColors.tertiaryLabel.resolveFrom(
                                        context,
                                      )
                                    : null,
                                onTap: () => editAppointment(context, s),
                              ),
                            if (s.refLabel != null)
                              ValueTile(
                                leading: Icon(
                                  CupertinoIcons.number,
                                  color: accent.resolveFrom(context),
                                ),
                                label: s.refLabel!,
                                value: visit.ref.isEmpty ? l.notSet : visit.ref,
                                valueColor: visit.ref.isEmpty
                                    ? CupertinoColors.tertiaryLabel.resolveFrom(
                                        context,
                                      )
                                    : null,
                                onTap: () => editRef(context, s),
                              ),
                          ],
                        ),
                      CupertinoListSection.insetGrouped(
                        header: Text(l.linesHeader),
                        footer: lines.isEmpty
                            ? null
                            : FooterText(l.linesFooter),
                        children: [
                          if (lines.isEmpty)
                            CupertinoListTile(
                              padding: tilePadding,
                              title: RowText(l.noLines, color: secondary),
                            ),
                          for (final (i, line) in lines.indexed)
                            LineTile(situation: s, line: line, index: i),
                        ],
                      ),
                      CupertinoListSection.insetGrouped(
                        children: [
                          CupertinoListTile(
                            padding: tilePadding,
                            leading: Icon(
                              CupertinoIcons.plus_circle,
                              color: accent.resolveFrom(context),
                            ),
                            title: RowText(
                              l.addLine,
                              color: accent.resolveFrom(context),
                            ),
                            onTap: () => openLineEditor(context, situation: s),
                          ),
                          if (hiddenCount > 0)
                            CupertinoListTile(
                              padding: tilePadding,
                              leading: Icon(
                                CupertinoIcons.eye,
                                color: accent.resolveFrom(context),
                              ),
                              title: RowText(
                                l.showHidden(hiddenCount),
                                color: accent.resolveFrom(context),
                              ),
                              onTap: () =>
                                  state.update(state.book.unhideAll(s.id)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _ActionBar(
            child: PrimaryButton(
              onPressed: lines.isEmpty
                  ? null
                  : () => openCards(context, situation: s, index: 0),
              label: l.showCards,
            ),
          ),
        ],
      ),
    );
  }
}

/// One German line with its meaning. Tap shows the card; touch and hold
/// offers copy, hide, edit and delete.
class LineTile extends StatelessWidget {
  const LineTile({
    super.key,
    required this.situation,
    required this.line,
    required this.index,
  });
  final Situation situation;
  final LineView line;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final book = AppScope.of(context).book;
    final pieces = book.fill(line.german, situation.id);
    final meaning = line.meaning.isEmpty
        ? (line.isCustom ? l.yourLine : '')
        : plainText(
            l,
            book.fill(line.meaning, situation.id, numeric: true),
            situation,
          );
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final theme = CupertinoTheme.of(context).textTheme;
    return Semantics(
      button: true,
      label: '${plainText(l, pieces, situation)}\n$meaning',
      hint: l.semLineHint,
      excludeSemantics: true,
      onTap: () => openCards(context, situation: situation, index: index),
      onLongPress: () => _actions(context),
      child: GestureDetector(
        onLongPress: () => _actions(context),
        child: CupertinoListTile(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 16, 12),
          title: Text.rich(
            TextSpan(
              children: lineSpans(
                context,
                pieces,
                situation,
                filledColor: accent.resolveFrom(context),
              ),
            ),
            maxLines: 12,
            overflow: TextOverflow.ellipsis,
            style: theme.textStyle.copyWith(fontSize: 17, height: 1.3),
          ),
          subtitle: meaning.isEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    meaning,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textStyle.copyWith(
                      fontSize: 15,
                      color: secondary,
                      fontStyle: line.isCustom && line.meaning.isEmpty
                          ? FontStyle.italic
                          : null,
                    ),
                  ),
                ),
          onTap: () => openCards(context, situation: situation, index: index),
        ),
      ),
    );
  }

  Future<void> _actions(BuildContext context) async {
    unawaited(HapticFeedback.selectionClick());
    final l = context.l;
    final state = AppScope.read(context);
    final text = plainText(
      l,
      state.book.fill(line.german, situation.id),
      situation,
    );
    final choice = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text(text),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, 'copy'),
            child: Text(l.copy),
          ),
          if (line.isCustom) ...[
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context, 'edit'),
              child: Text(l.editLine),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, 'delete'),
              child: Text(l.deleteLine),
            ),
          ] else
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context, 'hide'),
              child: Text(l.hideLine),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
      ),
    );
    if (!context.mounted) return;
    switch (choice) {
      case 'copy':
        await Clipboard.setData(ClipboardData(text: text));
      case 'edit':
        await openLineEditor(context, situation: situation, line: line.custom);
      case 'delete':
        final ok = await confirmDelete(
          context,
          message: l.deleteLineConfirm,
          action: l.deleteLine,
        );
        if (ok) state.update(state.book.removeLine(line.id));
      case 'hide':
        state.update(state.book.hide(line.id));
    }
  }
}

/// Keeps the primary action in reach at the bottom of the screen.
class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      border: Border(
        top: BorderSide(
          color: CupertinoColors.separator.resolveFrom(context),
          width: 0,
        ),
      ),
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SizedBox(width: double.infinity, child: child),
      ),
    ),
  );
}
