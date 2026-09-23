import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import '../l10n/app_localizations.dart';
import '../model/plan.dart';
import '../state/app_state.dart';

const accent = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF2255CC),
  darkColor: Color(0xFF4F86FF),
);

extension L10nX on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
}

/// Title text for list rows: wraps up to three lines so large text sizes
/// never clip.
class RowText extends StatelessWidget {
  const RowText(this.text, {super.key, this.color, this.maxLines = 6});
  final String text;
  final Color? color;
  final int maxLines;

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: color == null ? null : TextStyle(color: color),
  );
}

/// A nav bar "+" button with a VoiceOver label.
class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Icon(CupertinoIcons.add, semanticLabel: label),
  );
}

/// Centered teaching state for an empty list.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context).textTheme;
    // Keep lines short on wide screens without breaking intrinsic sizing.
    final side = math.max(32.0, (MediaQuery.sizeOf(context).width - 380) / 2);
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(side, 24, side, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 56,
              color: CupertinoColors.tertiaryLabel.resolveFrom(context),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.navTitleTextStyle.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: TextAlign.center,
              style: theme.textStyle.copyWith(
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                onPressed: onPrimary,
                child: Text(primaryLabel, textAlign: TextAlign.center),
              ),
            ),
            if (secondaryLabel != null) ...[
              const SizedBox(height: 8),
              CupertinoButton(
                onPressed: onSecondary,
                child: Text(secondaryLabel!, textAlign: TextAlign.center),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Shows load or save problems at the top of a list. Empty when all is well.
class ProblemBanner extends StatelessWidget {
  const ProblemBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final l = context.l;
    final String? message = state.loadFailed
        ? l.loadFailed
        : state.saveFailed
        ? l.saveFailed
        : null;
    if (message == null) return const SizedBox.shrink();
    return CupertinoListSection.insetGrouped(
      children: [
        CupertinoListTile(
          padding: tilePadding,
          leading: const Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            color: CupertinoColors.systemRed,
          ),
          title: RowText(message, maxLines: 12),
          trailing: state.loadFailed
              ? CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: state.dismissLoadError,
                  child: Text(l.ok),
                )
              : null,
        ),
      ],
    );
  }
}

/// A bottom sheet with a date picker. Returns the picked date, or
/// [removed] when the user chose the remove action, or null on cancel.
class DatePick {
  const DatePick(this.date) : removed = false;
  const DatePick.removed() : date = null, removed = true;
  final DateTime? date;
  final bool removed;
}

Future<DatePick?> pickDate(
  BuildContext context, {
  required String title,
  required DateTime initial,
  bool withTime = false,
  String? helpText,
  String? removeLabel,
  String? confirmLabel,
}) {
  if (withTime) {
    initial = DateTime(
      initial.year,
      initial.month,
      initial.day,
      initial.hour,
      initial.minute - initial.minute % 5,
    );
  } else {
    initial = dateOnly(initial);
  }
  var value = initial;
  return showCupertinoModalPopup<DatePick>(
    context: context,
    builder: (context) {
      final l = context.l;
      final theme = CupertinoTheme.of(context).textTheme;
      final large = isLargeText(context);
      final titleText = Text(
        title,
        textAlign: TextAlign.center,
        maxLines: large ? 3 : 1,
        overflow: TextOverflow.ellipsis,
        style: theme.navTitleTextStyle,
      );
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: ColoredBox(
          color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CupertinoButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l.cancel),
                    ),
                    Expanded(
                      child: large ? const SizedBox.shrink() : titleText,
                    ),
                    CupertinoButton(
                      onPressed: () => Navigator.pop(context, DatePick(value)),
                      child: Text(
                        confirmLabel ?? l.done,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                if (large)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    child: titleText,
                  ),
                if (helpText != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      helpText,
                      textAlign: TextAlign.center,
                      style: theme.textStyle.copyWith(
                        fontSize: 15,
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 216,
                  child: CupertinoDatePicker(
                    mode: withTime
                        ? CupertinoDatePickerMode.dateAndTime
                        : CupertinoDatePickerMode.date,
                    use24hFormat: MediaQuery.alwaysUse24HourFormatOf(context),
                    initialDateTime: initial,
                    minuteInterval: withTime ? 5 : 1,
                    onDateTimeChanged: (d) => value = d,
                  ),
                ),
                if (removeLabel != null)
                  CupertinoButton(
                    onPressed: () =>
                        Navigator.pop(context, const DatePick.removed()),
                    child: Text(
                      removeLabel,
                      style: const TextStyle(
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Asks before deleting. Returns true when the user confirmed.
Future<bool> confirmDelete(
  BuildContext context, {
  required String message,
  required String action,
}) async {
  final ok = await showCupertinoModalPopup<bool>(
    context: context,
    builder: (context) => CupertinoActionSheet(
      message: Text(message),
      actions: [
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context, true),
          child: Text(action),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context, false),
        child: Text(context.l.cancel),
      ),
    ),
  );
  return ok ?? false;
}

/// Row padding with a little more air than the default so wrapped titles
/// at large text sizes do not touch the separators.
const tilePadding = EdgeInsetsDirectional.fromSTEB(20, 10, 14, 10);

bool isLargeText(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(10) > 13;

/// A "label ... value >" row. At large text sizes the value moves under the
/// label so neither is squeezed.
class ValueTile extends StatelessWidget {
  const ValueTile({
    super.key,
    required this.leading,
    required this.label,
    required this.value,
    this.valueColor,
    required this.onTap,
  });

  final Widget leading;
  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final large = isLargeText(context);
    final style = TextStyle(
      color: valueColor ?? CupertinoColors.secondaryLabel.resolveFrom(context),
    );
    return CupertinoListTile(
      padding: tilePadding,
      leading: leading,
      title: large
          ? RowText(label)
          : Row(
              children: [
                // Labels are short ("Deadline"); the value takes the rest.
                RowText(label, maxLines: 1),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    style: style,
                  ),
                ),
              ],
            ),
      subtitle: large ? Text(value, maxLines: 3, style: style) : null,
      trailing: const CupertinoListTileChevron(),
      onTap: onTap,
    );
  }
}

/// Footnote-style text for list section footers, as on iOS.
class FooterText extends StatelessWidget {
  const FooterText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
      fontSize: 13,
      color: CupertinoColors.secondaryLabel.resolveFrom(context),
    ),
  );
}

/// One icon language for step status everywhere.
Icon stepStatusIcon(BuildContext context, StepStatus status) =>
    switch (status) {
      StepStatus.done => const Icon(
        CupertinoIcons.checkmark_circle_fill,
        color: accent,
      ),
      StepStatus.ready => const Icon(
        CupertinoIcons.arrow_right_circle,
        color: accent,
      ),
      StepStatus.waiting => Icon(
        CupertinoIcons.hourglass,
        color: CupertinoColors.secondaryLabel.resolveFrom(context),
      ),
    };

/// One icon language for documents: a seal when in hand.
Icon docIcon(BuildContext context, bool have) => have
    ? const Icon(CupertinoIcons.checkmark_seal_fill, color: accent)
    : Icon(
        CupertinoIcons.doc,
        color: CupertinoColors.secondaryLabel.resolveFrom(context),
      );

final _leaving = Expando<bool>();

/// Removes the page whose step or document was just deleted: only that page,
/// only once, wherever it sits in the stack.
void leaveDeletedPage(BuildContext context) {
  final route = ModalRoute.of(context);
  if (route == null || (_leaving[route] ?? false)) return;
  _leaving[route] = true;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (route.isActive) route.navigator?.removeRoute(route);
  });
}

/// Titles and names are one line: Return may still slip in a newline.
String oneLine(String s) => s.replaceAll(RegExp(r'\s*\n\s*'), ' ').trim();
