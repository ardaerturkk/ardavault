import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../model/board.dart';

/// Euros from cents: "€480" for whole amounts, "€480.50" otherwise.
String money(AppLocalizations l, int cents) => NumberFormat.simpleCurrency(
  locale: l.localeName,
  name: 'EUR',
  decimalDigits: cents % 100 == 0 ? 0 : 2,
).format(cents / 100);

/// Always two decimals, for rent per square metre: "€26.67".
String moneyExact(AppLocalizations l, double cents) =>
    NumberFormat.simpleCurrency(
      locale: l.localeName,
      name: 'EUR',
      decimalDigits: 2,
    ).format(cents.round() / 100);

/// A size in square metres without the unit: "18", "18.5".
String sizeNumber(AppLocalizations l, double sqm) =>
    NumberFormat('#,##0.#', l.localeName).format(sqm);

/// Amounts and sizes as the user would type them back into a field:
/// no currency sign, no grouping, the locale's decimal separator.
String editableCents(AppLocalizations l, int? cents) {
  if (cents == null) return '';
  return NumberFormat(
    cents % 100 == 0 ? '0' : '0.00',
    l.localeName,
  ).format(cents / 100);
}

String editableSize(AppLocalizations l, double? sqm) =>
    sqm == null ? '' : NumberFormat('0.#', l.localeName).format(sqm);

String shortDate(AppLocalizations l, DateTime d) =>
    DateFormat.MMMd(l.localeName).format(d);

/// Date and time; the time follows the device's 12/24-hour setting.
String dateTime(AppLocalizations l, DateTime d, {bool use24h = true}) =>
    '${DateFormat.MMMEd(l.localeName).format(d)}, '
    '${(use24h ? DateFormat.Hm(l.localeName) : DateFormat.jm(l.localeName)).format(d)}';

String stageName(AppLocalizations l, Stage s) => switch (s) {
  Stage.interested => l.stageInterested,
  Stage.messaged => l.stageMessaged,
  Stage.viewing => l.stageViewing,
  Stage.applied => l.stageApplied,
  Stage.accepted => l.stageAccepted,
  Stage.declined => l.stageDeclined,
};

String sourceName(AppLocalizations l, Source s) => switch (s) {
  Source.wgGesucht => l.sourceWgGesucht,
  Source.kleinanzeigen => l.sourceKleinanzeigen,
  Source.immoscout => l.sourceImmoscout,
  Source.facebook => l.sourceFacebook,
  Source.studentenwerk => l.sourceStudentenwerk,
  Source.friends => l.sourceFriends,
  Source.other => l.sourceOther,
};

String checkText(AppLocalizations l, Check c) => switch (c) {
  Check.viewed => l.checkViewed,
  Check.noPrepay => l.checkNoPrepay,
  Check.accountInName => l.checkAccountInName,
  Check.idLater => l.checkIdLater,
  Check.plausibleRent => l.checkPlausible,
};

/// The label of the button that moves a flat on from [s], or null when the
/// flat has its answer.
String? nextActionLabel(AppLocalizations l, Stage s) => switch (s) {
  Stage.interested => l.actionMessaged,
  Stage.messaged => l.actionViewing,
  Stage.viewing => l.actionApplied,
  Stage.applied => l.actionAnswer,
  Stage.accepted || Stage.declined => null,
};

/// "Messaged Oct 2", "Viewing Thu, Oct 8, 17:30": where a flat stands.
String stageLine(
  AppLocalizations l,
  Flat f,
  DateTime now, {
  bool use24h = true,
}) {
  final since = shortDate(l, f.stageSince);
  return switch (f.stage) {
    Stage.interested => l.addedOn(since),
    Stage.messaged => l.messagedOn(since),
    Stage.viewing => switch (f.viewing) {
      null => l.noViewingTime,
      final v when v.isBefore(now) => l.viewedOn(
        dateTime(l, v, use24h: use24h),
      ),
      final v => l.viewingOn(dateTime(l, v, use24h: use24h)),
    },
    Stage.applied => l.appliedOn(since),
    Stage.accepted => l.acceptedOn(since),
    Stage.declined => l.declinedOn(since),
  };
}
