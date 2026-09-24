import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/board.dart';
import '../state/app_state.dart';
import 'flat_edit_page.dart';
import 'format.dart';
import 'widgets.dart';

class FlatPage extends StatefulWidget {
  const FlatPage({super.key, required this.flatId, this.previousTitle});
  final String flatId;

  /// Label for the back button, like "Flats".
  final String? previousTitle;

  @override
  State<FlatPage> createState() => _FlatPageState();
}

class _FlatPageState extends State<FlatPage> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final l = context.l;
    final f = state.board.flat(widget.flatId);
    if (f == null) {
      // Deleted in the editor: leave this screen too.
      leaveDeletedPage(context);
      return const CupertinoPageScaffold(child: SizedBox.shrink());
    }
    final theme = CupertinoTheme.of(context).textTheme;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final use24h = MediaQuery.alwaysUse24HourFormatOf(context);
    final now = state.now();
    final upcoming =
        f.stage == Stage.viewing &&
        f.viewing != null &&
        !f.viewing!.isBefore(now);
    final lineColor = switch (f.stage) {
      Stage.accepted => accent.resolveFrom(context),
      Stage.viewing when upcoming => accent.resolveFrom(context),
      _ => secondary,
    };
    final action = nextActionLabel(l, f.stage);
    final origin = [
      sourceName(l, f.source),
      if (f.district.isNotEmpty) f.district,
    ].join('  ·  ');

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: widget.previousTitle,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => openFlatEditor(context, flat: f),
          child: Text(l.edit),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Text(
                      f.title,
                      style: theme.navLargeTitleTextStyle.copyWith(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: Text(
                      stageLine(l, f, now, use24h: use24h),
                      style: theme.textStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: lineColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                    child: Text(
                      origin,
                      style: theme.textStyle.copyWith(
                        fontSize: 15,
                        color: secondary,
                      ),
                    ),
                  ),
                  CupertinoListSection.insetGrouped(
                    children: [
                      ValueTile(
                        leading: Icon(
                          CupertinoIcons.flag,
                          color: accent.resolveFrom(context),
                        ),
                        label: l.stage,
                        value: stageName(l, f.stage),
                        onTap: () => _chooseStage(f),
                      ),
                      ValueTile(
                        leading: Icon(
                          CupertinoIcons.calendar,
                          color: accent.resolveFrom(context),
                        ),
                        label: l.viewing,
                        value: f.viewing == null
                            ? l.notSet
                            : dateTime(l, f.viewing!, use24h: use24h),
                        onTap: () => _pickViewing(f),
                      ),
                    ],
                  ),
                  _RentSection(flat: f),
                  if (f.link.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.link),
                      footer: _copied ? FooterText(l.linkCopied) : null,
                      children: [
                        CupertinoListTile(
                          padding: tilePadding,
                          title: RowText(f.link, maxLines: 3, color: secondary),
                        ),
                        CupertinoListTile(
                          padding: tilePadding,
                          leading: Icon(
                            CupertinoIcons.doc_on_clipboard,
                            color: accent.resolveFrom(context),
                          ),
                          title: RowText(
                            l.copyLink,
                            color: accent.resolveFrom(context),
                          ),
                          onTap: () => _copy(f.link),
                        ),
                      ],
                    ),
                  if (f.notes.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.notes),
                      children: [
                        CupertinoListTile(
                          padding: tilePadding,
                          title: Text(f.notes),
                        ),
                      ],
                    ),
                  CupertinoListSection.insetGrouped(
                    header: Text(l.checksHeader),
                    footer: FooterText(l.checksFooter),
                    children: [
                      for (final c in Check.values)
                        _CheckTile(flat: f, check: c),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (action != null)
              ActionBar(
                child: CupertinoButton.filled(
                  onPressed: () => _advance(f),
                  child: Text(action, textAlign: TextAlign.center),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _copy(String link) async {
    await Clipboard.setData(ClipboardData(text: link));
    unawaited(HapticFeedback.selectionClick());
    if (mounted) setState(() => _copied = true);
  }

  Future<void> _advance(Flat f) async {
    if (f.stage == Stage.applied) {
      await _recordAnswer(f);
      return;
    }
    if (f.stage.next case final next?) await _moveTo(f, next);
  }

  Future<void> _recordAnswer(Flat f) async {
    final l = context.l;
    final answer = await showCupertinoModalPopup<Stage>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text(l.answerQuestion),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, Stage.accepted),
            child: Text(l.answerAccepted),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, Stage.declined),
            child: Text(l.answerDeclined),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
      ),
    );
    if (answer != null) await _moveTo(f, answer);
  }

  Future<void> _chooseStage(Flat f) async {
    final l = context.l;
    final stage = await showCupertinoModalPopup<Stage>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text(l.chooseStage),
        actions: [
          for (final s in Stage.values)
            if (s != f.stage)
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context, s),
                child: Text(stageName(l, s)),
              ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
      ),
    );
    if (stage != null) await _moveTo(f, stage);
  }

  /// Moves the flat on. Moving to Viewing asks for the time first.
  Future<void> _moveTo(Flat f, Stage stage) async {
    if (!mounted) return;
    final state = AppScope.read(context);
    DateTime? viewing;
    var later = false;
    if (stage == Stage.viewing) {
      final pick = await _askViewingTime(
        f,
        removeLabel: context.l.setTimeLater,
        removeIsDestructive: false,
      );
      if (pick == null || !mounted) return;
      viewing = pick.date;
      later = pick.removed;
    }
    unawaited(HapticFeedback.lightImpact());
    state.update(
      state.board.moveTo(
        f.id,
        stage,
        state.now(),
        viewing: viewing,
        clearViewing: later,
      ),
    );
  }

  Future<DatePick?> _askViewingTime(
    Flat f, {
    String? removeLabel,
    bool removeIsDestructive = true,
  }) {
    final state = AppScope.read(context);
    final now = state.now();
    return pickDate(
      context,
      title: context.l.viewingTime,
      withTime: true,
      initial: f.viewing ?? DateTime(now.year, now.month, now.day + 1, 17),
      removeLabel: removeLabel,
      removeIsDestructive: removeIsDestructive,
    );
  }

  /// Setting a time on a flat that is not at the viewing yet moves it to
  /// Viewing: that is what a viewing time means.
  Future<void> _pickViewing(Flat f) async {
    final l = context.l;
    final pick = await _askViewingTime(
      f,
      removeLabel: f.viewing == null ? null : l.removeViewing,
    );
    if (pick == null || !mounted) return;
    final state = AppScope.read(context);
    final current = state.board.flat(f.id);
    if (current == null) return;
    if (pick.removed) {
      state.update(state.board.withFlat(current.copyWith(clearViewing: true)));
      return;
    }
    final early =
        current.stage == Stage.interested || current.stage == Stage.messaged;
    state.update(
      early
          ? state.board.moveTo(
              f.id,
              Stage.viewing,
              state.now(),
              viewing: pick.date,
            )
          : state.board.withFlat(current.copyWith(viewing: pick.date)),
    );
  }
}

class _RentSection extends StatelessWidget {
  const _RentSection({required this.flat});
  final Flat flat;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final f = flat;
    final rows = <Widget>[
      if (f.warmCents case final w?)
        ValueTile(
          label: l.warmRent,
          value: money(l, w),
          valueColor: CupertinoColors.label.resolveFrom(context),
        ),
      if (f.coldCents case final c?)
        ValueTile(label: l.coldRent, value: money(l, c)),
      if (f.sizeSqm case final s?)
        ValueTile(label: l.size, value: l.sizeShort(sizeNumber(l, s))),
      if (f.warmPerSqmCents case final p?)
        ValueTile(label: l.perSqm, value: moneyExact(l, p)),
    ];
    return CupertinoListSection.insetGrouped(
      header: Text(l.rent),
      footer: FooterText(l.rentFooter),
      children: rows.isNotEmpty
          ? rows
          : [
              CupertinoListTile(
                padding: tilePadding,
                leading: Icon(
                  CupertinoIcons.add,
                  color: accent.resolveFrom(context),
                ),
                title: RowText(l.addRent, color: accent.resolveFrom(context)),
                onTap: () => openFlatEditor(context, flat: f),
              ),
            ],
    );
  }
}

/// One point of the scam checklist, ticked once the user confirmed it.
class _CheckTile extends StatelessWidget {
  const _CheckTile({required this.flat, required this.check});
  final Flat flat;
  final Check check;

  void _toggle(BuildContext context) {
    unawaited(HapticFeedback.selectionClick());
    final state = AppScope.read(context);
    state.update(state.board.toggleCheck(flat.id, check));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final on = flat.checks.contains(check);
    final text = checkText(l, check);
    return Semantics(
      checked: on,
      button: true,
      label: text,
      hint: l.semCheckHint,
      excludeSemantics: true,
      onTap: () => _toggle(context),
      child: CupertinoListTile(
        padding: tilePadding,
        leading: on
            ? Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: accent.resolveFrom(context),
              )
            : Icon(
                CupertinoIcons.circle,
                color: CupertinoColors.tertiaryLabel.resolveFrom(context),
              ),
        title: RowText(text, maxLines: 8),
        onTap: () => _toggle(context),
      ),
    );
  }
}
