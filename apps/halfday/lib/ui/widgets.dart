import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import '../l10n/app_localizations.dart';
import '../model/quota.dart';
import '../state/app_state.dart';

const accent = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF3949AB),
  darkColor: Color(0xFF8C9EFF),
);

/// Text and icons on a filled accent background.
const onAccent = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFFFFFF),
  darkColor: Color(0xFF10163A),
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
    initial = DateTime(initial.year, initial.month, initial.day);
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

/// Asks before deleting (or another action that changes a lot of data).
/// Returns true when the user confirmed.
Future<bool> confirmDelete(
  BuildContext context, {
  required String message,
  required String action,
  bool destructive = true,
}) async {
  final ok = await showCupertinoModalPopup<bool>(
    context: context,
    builder: (context) => CupertinoActionSheet(
      message: Text(message),
      actions: [
        CupertinoActionSheetAction(
          isDestructiveAction: destructive,
          isDefaultAction: !destructive,
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
    this.leading,
    required this.label,
    required this.value,
    this.valueColor,
    this.onTap,
  });

  final Widget? leading;
  final String label;
  final String value;
  final Color? valueColor;

  /// Null for a read-only row (no chevron).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final large = isLargeText(context);
    final style = TextStyle(
      color: valueColor ?? CupertinoColors.secondaryLabel.resolveFrom(context),
      fontFeatures: tabular,
    );
    return CupertinoListTile(
      padding: tilePadding,
      leading: leading,
      title: LayoutBuilder(
        builder: (context, box) {
          final base = DefaultTextStyle.of(context).style;
          final scaler = MediaQuery.textScalerOf(context);
          double width(String text, TextStyle s) {
            final p = TextPainter(
              text: TextSpan(text: text, style: s),
              textDirection: Directionality.of(context),
              textScaler: scaler,
              maxLines: 1,
            )..layout();
            final w = p.width;
            p.dispose();
            return w;
          }

          final fits =
              !large &&
              width(label, base) + 12 + width(value, base.merge(style)) <=
                  box.maxWidth;
          if (fits) {
            return Row(
              children: [
                Text(label, maxLines: 1),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: style,
                  ),
                ),
              ],
            );
          }
          // Too long for one line: the value moves under the label.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowText(label),
              const SizedBox(height: 2),
              Text(value, maxLines: 4, style: style.copyWith(fontSize: 15)),
            ],
          );
        },
      ),
      trailing: onTap == null ? null : const CupertinoListTileChevron(),
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

/// One icon language for day status everywhere: filled, half filled, empty.
Icon dayStatusIcon(BuildContext context, DayStatus status) => switch (status) {
  DayStatus.full => Icon(
    CupertinoIcons.circle_fill,
    color: accent.resolveFrom(context),
  ),
  DayStatus.half => Icon(
    CupertinoIcons.circle_lefthalf_fill,
    color: accent.resolveFrom(context),
  ),
  DayStatus.notCounted => Icon(
    CupertinoIcons.circle,
    color: CupertinoColors.tertiaryLabel.resolveFrom(context),
  ),
};

/// Numbers line up in columns.
const tabular = [FontFeature.tabularFigures()];

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

/// Cancel in an editor: asks first when there are unsaved changes.
Future<void> cancelEditor(BuildContext context, {required bool dirty}) async {
  if (!dirty) {
    Navigator.pop(context);
    return;
  }
  final l = context.l;
  final discard = await showCupertinoModalPopup<bool>(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context, true),
          child: Text(l.discardChanges),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context, false),
        child: Text(l.keepEditing),
      ),
    ),
  );
  if ((discard ?? false) && context.mounted) Navigator.pop(context);
}

/// The frame of a bottom picker sheet: Cancel, title, Done, then [picker].
Widget _pickerSheet(
  BuildContext context, {
  required String title,
  required Widget picker,
  required VoidCallback onDone,
}) {
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
                Expanded(child: large ? const SizedBox.shrink() : titleText),
                CupertinoButton(
                  onPressed: onDone,
                  child: Text(
                    l.done,
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
            SizedBox(height: 216, child: picker),
          ],
        ),
      ),
    ),
  );
}

/// A wheel of [count] choices; returns the picked index or null on cancel.
Future<int?> pickFromWheel(
  BuildContext context, {
  required String title,
  required int count,
  required int initial,
  required String Function(int index) label,
}) {
  var value = initial;
  return showCupertinoModalPopup<int>(
    context: context,
    builder: (context) => _pickerSheet(
      context,
      title: title,
      onDone: () => Navigator.pop(context, value),
      picker: CupertinoPicker(
        itemExtent: 36,
        scrollController: FixedExtentScrollController(initialItem: initial),
        onSelectedItemChanged: (i) => value = i,
        children: [
          for (var i = 0; i < count; i++)
            Center(
              child: Text(
                label(i),
                style: const TextStyle(fontFeatures: tabular),
              ),
            ),
        ],
      ),
    ),
  );
}

/// Hours and minutes in 5-minute steps; returns minutes or null on cancel.
Future<int?> pickDuration(
  BuildContext context, {
  required String title,
  required int initialMinutes,
}) {
  var value = initialMinutes - initialMinutes % 5;
  return showCupertinoModalPopup<int>(
    context: context,
    builder: (context) => _pickerSheet(
      context,
      title: title,
      onDone: () => Navigator.pop(context, value),
      picker: CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hm,
        minuteInterval: 5,
        initialTimerDuration: Duration(minutes: value),
        onTimerDurationChanged: (d) => value = d.inMinutes,
      ),
    ),
  );
}
