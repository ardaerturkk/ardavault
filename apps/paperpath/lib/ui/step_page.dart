import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/plan.dart';
import '../state/app_state.dart';
import 'document_page.dart';
import 'format.dart';
import 'names.dart';
import 'step_edit_page.dart';
import 'widgets.dart';

class StepPage extends StatefulWidget {
  const StepPage({super.key, required this.stepId, this.previousTitle});
  final String stepId;

  /// Label for the back button, like "Steps".
  final String? previousTitle;

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  /// Documents handed over by the last "Mark as Done" on this screen.
  List<Doc> _received = const [];

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final plan = state.plan;
    final l = context.l;
    final step = plan.step(widget.stepId);
    if (step == null) {
      // Deleted in the editor: leave this screen too.
      leaveDeletedPage(context);
      return const CupertinoPageScaffold(child: SizedBox.shrink());
    }
    final status = plan.statusOf(step);
    final theme = CupertinoTheme.of(context).textTheme;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final note = stepNote(l, step);
    final due = step.effectiveDue(plan.moveInDate);
    final dueText = dueLabel(l, due, state.now());
    // Missing documents first: they are what needs attention.
    final needs = [for (final id in step.needs) ?plan.doc(id)]
      ..sort((a, b) => (a.have ? 1 : 0).compareTo(b.have ? 1 : 0));
    final produces = [for (final id in step.produces) ?plan.doc(id)];

    final String? statusText = switch (status) {
      StepStatus.done => l.stepDone,
      _ => dueText?.$1,
    };
    final Color statusColor = switch ((status, dueText?.$2)) {
      (StepStatus.done, _) => accent.resolveFrom(context),
      (_, DueTone.overdue) => CupertinoColors.systemRed.resolveFrom(context),
      (_, DueTone.soon) => CupertinoColors.systemOrange.resolveFrom(context),
      _ => secondary,
    };

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: widget.previousTitle,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => openStepEditor(context, step: step),
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
                      stepTitle(l, step),
                      style: theme.navLargeTitleTextStyle.copyWith(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  if (statusText != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                      child: Row(
                        children: [
                          if (status == StepStatus.done)
                            Padding(
                              padding: const EdgeInsetsDirectional.only(end: 6),
                              child: Icon(
                                CupertinoIcons.checkmark_circle_fill,
                                size: 18,
                                color: statusColor,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              statusText,
                              style: theme.textStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (note.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Text(
                        note,
                        style: theme.textStyle.copyWith(
                          fontSize: 15,
                          color: secondary,
                        ),
                      ),
                    ),
                  CupertinoListSection.insetGrouped(
                    header: Text(l.bring),
                    footer: needs.isEmpty || status == StepStatus.done
                        ? null
                        : FooterText(l.bringFooter),
                    children: [
                      if (needs.isEmpty)
                        CupertinoListTile(
                          padding: tilePadding,
                          title: RowText(l.nothingToBring, color: secondary),
                        ),
                      for (final d in needs) _DocCheckTile(doc: d),
                    ],
                  ),
                  if (produces.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.youGet),
                      footer: _received.isEmpty
                          ? null
                          : FooterText(
                              l.received(
                                [for (final d in _received) docName(l, d)]
                                    .join(', '),
                              ),
                            ),
                      children: [
                        for (final d in produces)
                          CupertinoListTile(
                            padding: tilePadding,
                            leading: docIcon(context, d.have),
                            title: RowText(docName(l, d)),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute<void>(
                                builder: (_) => DocumentPage(
                                  docId: d.id,
                                  previousTitle: l.tabSteps,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  CupertinoListSection.insetGrouped(
                    header: Text(l.dates),
                    children: [
                      ValueTile(
                        leading: Icon(
                          CupertinoIcons.flag,
                          color: accent.resolveFrom(context),
                        ),
                        label: l.deadline,
                        value: due == null ? l.none : shortDate(l, due),
                        valueColor:
                            dueText?.$2 == DueTone.overdue &&
                                status != StepStatus.done
                            ? CupertinoColors.systemRed.resolveFrom(context)
                            : null,
                        onTap: () => _pickDeadline(step, due),
                      ),
                      ValueTile(
                        leading: Icon(
                          CupertinoIcons.calendar,
                          color: accent.resolveFrom(context),
                        ),
                        label: l.appointment,
                        value: step.appointment == null
                            ? l.none
                            : dateTime(
                                l,
                                step.appointment!,
                                use24h: MediaQuery.alwaysUse24HourFormatOf(
                                  context,
                                ),
                              ),
                        onTap: () => _pickAppointment(step),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            _ActionBar(
              child: switch (status) {
                StepStatus.done => CupertinoButton(
                  onPressed: () => _reopen(step),
                  child: Text(l.markNotDone, textAlign: TextAlign.center),
                ),
                StepStatus.ready => CupertinoButton.filled(
                  onPressed: () => _complete(step),
                  child: Text(l.markDone, textAlign: TextAlign.center),
                ),
                StepStatus.waiting => CupertinoButton.tinted(
                  onPressed: () => _completeWaiting(step),
                  child: Text(l.markDone, textAlign: TextAlign.center),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _completeWaiting(PathStep step) async {
    final l = context.l;
    final missing = AppScope.read(context).plan.missingFor(step).length;
    final ok = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text(l.confirmDoneMissing(missing)),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.markDone),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, false),
          child: Text(l.cancel),
        ),
      ),
    );
    if (ok ?? false) await _complete(step);
  }

  Future<void> _complete(PathStep step) async {
    final state = AppScope.read(context);
    final (next, received) = state.plan.complete(step.id);
    unawaited(HapticFeedback.lightImpact());
    state.update(next);
    setState(() => _received = received);
  }

  void _reopen(PathStep step) {
    final state = AppScope.read(context);
    state.update(state.plan.reopen(step.id));
    setState(() => _received = const []);
  }

  Future<void> _pickDeadline(PathStep step, DateTime? due) async {
    final state = AppScope.read(context);
    final l = context.l;
    final pick = await pickDate(
      context,
      title: l.deadline,
      initial: due ?? state.now(),
      removeLabel: due == null ? null : l.removeDeadline,
    );
    if (pick == null) return;
    // Confirming the same date keeps a deadline tied to the move-in date.
    if (!pick.removed && due != null && dateOnly(pick.date!) == due) return;
    final current = state.plan.step(step.id)!;
    state.update(
      state.plan.withStep(
        pick.removed
            ? current.copyWith(clearDue: true)
            : current.copyWith(dueDate: pick.date),
      ),
    );
  }

  Future<void> _pickAppointment(PathStep step) async {
    final state = AppScope.read(context);
    final l = context.l;
    final now = state.now();
    final pick = await pickDate(
      context,
      title: l.appointment,
      withTime: true,
      initial:
          step.appointment ?? DateTime(now.year, now.month, now.day + 1, 9),
      removeLabel: step.appointment == null ? null : l.removeAppointment,
    );
    if (pick == null) return;
    final current = state.plan.step(step.id)!;
    state.update(
      state.plan.withStep(
        pick.removed
            ? current.copyWith(clearAppointment: true)
            : current.copyWith(appointment: pick.date),
      ),
    );
  }
}

/// A needed document with a check you can tap once you have it.
class _DocCheckTile extends StatelessWidget {
  const _DocCheckTile({required this.doc});
  final Doc doc;

  void _toggle(BuildContext context) {
    unawaited(HapticFeedback.selectionClick());
    final state = AppScope.read(context);
    final current = state.plan.doc(doc.id)!;
    state.update(state.plan.withDoc(current.copyWith(have: !current.have)));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final name = docName(l, doc);
    final from = AppScope.of(context).plan.stepsProducing(doc.id);
    return Semantics(
      checked: doc.have,
      button: true,
      label: name,
      hint: l.semToggleHint,
      excludeSemantics: true,
      onTap: () => _toggle(context),
      child: CupertinoListTile(
        padding: tilePadding,
        leading: doc.have
            ? docIcon(context, true)
            : Icon(
                CupertinoIcons.circle,
                color: CupertinoColors.tertiaryLabel.resolveFrom(context),
              ),
        title: RowText(name),
        subtitle: doc.have
            ? null
            : Text(
                from.isEmpty
                    ? l.missing
                    : l.comesFrom(stepTitle(l, from.first)),
                style: TextStyle(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
        onTap: () => _toggle(context),
      ),
    );
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
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(width: double.infinity, child: child),
    ),
  );
}
