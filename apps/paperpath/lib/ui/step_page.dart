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
  const StepPage({super.key, required this.stepId});
  final String stepId;

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.of(context).maybePop();
      });
      return const CupertinoPageScaffold(child: SizedBox.shrink());
    }
    final status = plan.statusOf(step);
    final theme = CupertinoTheme.of(context).textTheme;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final note = stepNote(l, step);
    final due = step.effectiveDue(plan.moveInDate);
    final dueText = dueLabel(l, due, state.now());
    final needs = [for (final id in step.needs) ?plan.doc(id)];
    final produces = [for (final id in step.produces) ?plan.doc(id)];

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: l.tabSteps,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => openStepEditor(context, step: step),
          child: Text(l.edit),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                stepTitle(l, step),
                style: theme.navLargeTitleTextStyle.copyWith(fontSize: 28),
              ),
            ),
            if (note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text(
                  note,
                  style: theme.textStyle.copyWith(color: secondary),
                ),
              ),
            CupertinoListSection.insetGrouped(
              header: Text(l.bring),
              footer: needs.isEmpty || status == StepStatus.done
                  ? null
                  : Text(l.bringFooter),
              children: [
                if (needs.isEmpty)
                  CupertinoListTile(
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
                    : Text(
                        l.received(
                          [for (final d in _received) docName(l, d)].join(', '),
                        ),
                      ),
                children: [
                  for (final d in produces)
                    CupertinoListTile(
                      leading: Icon(
                        d.have
                            ? CupertinoIcons.checkmark_seal_fill
                            : CupertinoIcons.doc,
                        color: d.have ? accent : secondary,
                      ),
                      title: RowText(docName(l, d)),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute<void>(
                          builder: (_) => DocumentPage(docId: d.id),
                        ),
                      ),
                    ),
                ],
              ),
            CupertinoListSection.insetGrouped(
              header: Text(l.dates),
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.flag, color: accent),
                  title: RowText(l.deadline, maxLines: 2),
                  additionalInfo: Text(
                    due == null ? l.none : shortDate(l, due),
                    style:
                        dueText?.$2 == DueTone.overdue &&
                            status != StepStatus.done
                        ? TextStyle(
                            color: CupertinoColors.systemRed.resolveFrom(
                              context,
                            ),
                          )
                        : null,
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickDeadline(step, due),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.calendar, color: accent),
                  title: RowText(l.appointment, maxLines: 2),
                  additionalInfo: Text(
                    step.appointment == null
                        ? l.none
                        : dateTime(l, step.appointment!),
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickAppointment(step),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: step.done
                  ? CupertinoButton(
                      onPressed: () => _reopen(step),
                      child: Text(l.markNotDone, textAlign: TextAlign.center),
                    )
                  : CupertinoButton.filled(
                      onPressed: () => _complete(step),
                      child: Text(l.markDone, textAlign: TextAlign.center),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _complete(PathStep step) async {
    final state = AppScope.read(context);
    final (next, received) = state.plan.complete(step.id);
    await HapticFeedback.lightImpact();
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

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final name = docName(l, doc);
    return Semantics(
      checked: doc.have,
      button: true,
      label: name,
      hint: l.semToggleHint,
      excludeSemantics: true,
      child: CupertinoListTile(
        leading: Icon(
          doc.have
              ? CupertinoIcons.checkmark_circle_fill
              : CupertinoIcons.circle,
          color: doc.have
              ? accent
              : CupertinoColors.tertiaryLabel.resolveFrom(context),
        ),
        title: RowText(name),
        subtitle: doc.have
            ? null
            : Text(
                l.missing,
                style: TextStyle(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
        onTap: () {
          HapticFeedback.selectionClick();
          final state = AppScope.read(context);
          final current = state.plan.doc(doc.id)!;
          state.update(
            state.plan.withDoc(current.copyWith(have: !current.have)),
          );
        },
      ),
    );
  }
}
