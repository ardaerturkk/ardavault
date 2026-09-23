import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/plan.dart';
import '../model/starter.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'names.dart';
import 'step_edit_page.dart';
import 'step_page.dart';
import 'widgets.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final plan = state.plan;
    final l = context.l;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l.tabSteps),
            trailing: plan.steps.isEmpty
                ? null
                : AddButton(
                    label: l.addStep,
                    onPressed: () => openStepEditor(context),
                  ),
          ),
          const SliverToBoxAdapter(child: ProblemBanner()),
          if (plan.steps.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: CupertinoIcons.doc_text,
                title: l.emptyStepsTitle,
                body: l.emptyStepsBody,
                primaryLabel: l.addStarter,
                onPrimary: () => _addStarter(context),
                secondaryLabel: l.addOwnStep,
                onSecondary: () => openStepEditor(context),
              ),
            )
          else
            SliverSafeArea(
              top: false,
              sliver: SliverList.list(
                children: [
                  _MoveInSection(plan: plan),
                  for (final status in StepStatus.values)
                    if (plan.sortedSteps(status) case final steps
                        when steps.isNotEmpty)
                      CupertinoListSection.insetGrouped(
                        header: Text(switch (status) {
                          StepStatus.ready => l.sectionReady,
                          StepStatus.waiting => l.sectionWaiting,
                          StepStatus.done => l.sectionDone,
                        }),
                        footer: switch (status) {
                          StepStatus.ready => FooterText(l.readyFooter),
                          StepStatus.done
                              when steps.length == plan.steps.length =>
                            FooterText(l.allDone),
                          _ => null,
                        },
                        children: [for (final s in steps) StepTile(step: s)],
                      ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _addStarter(BuildContext context) async {
    final state = AppScope.read(context);
    final l = context.l;
    final pick = await pickDate(
      context,
      title: l.moveInQuestion,
      helpText: l.moveInHelp,
      initial: state.plan.moveInDate ?? state.now(),
      confirmLabel: l.continueLabel,
    );
    if (pick?.date == null) return;
    unawaited(HapticFeedback.lightImpact());
    state.update(addStarter(state.plan, pick!.date!));
  }
}

class _MoveInSection extends StatelessWidget {
  const _MoveInSection({required this.plan});
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final hasStarter = plan.steps.any((s) => s.templateKey != null);
    final date = plan.moveInDate;
    return CupertinoListSection.insetGrouped(
      footer: hasStarter ? FooterText(l.starterFooter) : null,
      children: [
        ValueTile(
          leading: Icon(
            CupertinoIcons.house,
            color: accent.resolveFrom(context),
          ),
          label: l.movedIn,
          value: date == null ? l.notSet : longDate(l, date),
          onTap: () async {
            final state = AppScope.read(context);
            final pick = await pickDate(
              context,
              title: l.movedIn,
              helpText: l.moveInHelp,
              initial: state.plan.moveInDate ?? state.now(),
            );
            if (pick?.date == null) return;
            state.update(
              state.plan.copyWith(moveInDate: dateOnly(pick!.date!)),
            );
          },
        ),
      ],
    );
  }
}

class StepTile extends StatelessWidget {
  const StepTile({super.key, required this.step});
  final PathStep step;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final plan = state.plan;
    final l = context.l;
    final status = plan.statusOf(step);
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);

    final parts = <InlineSpan>[];
    void add(String text, [Color? color]) {
      if (parts.isNotEmpty) parts.add(const TextSpan(text: '  ·  '));
      parts.add(
        TextSpan(
          text: text,
          style: TextStyle(color: color),
        ),
      );
    }

    if (status != StepStatus.done) {
      if (step.appointment case final a?) {
        add(
          l.appointmentOn(
            dateTime(l, a, use24h: MediaQuery.alwaysUse24HourFormatOf(context)),
          ),
          accent.resolveFrom(context),
        );
      }
      if (dueLabel(l, step.effectiveDue(plan.moveInDate), state.now()) case (
        final text,
        final tone,
      )) {
        add(text, switch (tone) {
          DueTone.overdue => CupertinoColors.systemRed.resolveFrom(context),
          DueTone.soon => CupertinoColors.systemOrange.resolveFrom(context),
          DueTone.normal => null,
        });
      }
      if (needsLabel(l, [for (final d in plan.missingFor(step)) docName(l, d)])
          case final needs?) {
        add(needs);
      }
    }

    return CupertinoListTile(
      padding: tilePadding,
      leading: stepStatusIcon(context, status),
      title: RowText(
        stepTitle(l, step),
        color: status == StepStatus.done ? secondary : null,
      ),
      subtitle: parts.isEmpty
          ? null
          : Text.rich(
              TextSpan(children: parts),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(builder: (_) => StepPage(stepId: step.id)),
      ),
    );
  }
}
