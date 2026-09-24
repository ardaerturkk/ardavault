import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../model/book.dart';
import '../model/content.dart';

/// The user-facing name of a detail. The reference number uses the
/// situation's German term (Aktenzeichen, Kundennummer...).
String slotLabel(AppLocalizations l, Slot slot, [Situation? situation]) =>
    switch (slot) {
      Slot.name || Slot.nameSpelled => l.fieldName,
      Slot.birthDate => l.fieldBirthDate,
      Slot.address => l.fieldAddress,
      Slot.phone => l.fieldPhone,
      Slot.email => l.fieldEmail,
      Slot.insurer => l.fieldInsurer,
      Slot.insuranceNumber => l.fieldInsuranceNumber,
      Slot.studentId => l.fieldStudentId,
      Slot.ref => situation?.refLabel ?? '',
      Slot.time => l.fieldTime,
      Slot.date => l.fieldDate,
    };

String slotHint(AppLocalizations l, Slot slot) => switch (slot) {
  Slot.name => l.hintName,
  Slot.address => l.hintAddress,
  Slot.phone => l.hintPhone,
  Slot.email => l.hintEmail,
  Slot.insurer => l.hintInsurer,
  Slot.insuranceNumber => l.hintInsuranceNumber,
  Slot.studentId => l.hintStudentId,
  _ => '',
};

/// The meaning language: the UI language, except German, which gets English.
String meaningLocale(AppLocalizations l) => l.localeName == 'tr' ? 'tr' : 'en';

/// Plain text of a filled line; missing slots appear as "[Label]".
String plainText(
  AppLocalizations l,
  List<Piece> pieces, [
  Situation? situation,
]) => pieces
    .map((p) => p.text ?? '[${slotLabel(l, p.slot!, situation)}]')
    .join();

/// "A", "A and B", "A, B and C" in the current language.
String joinNames(AppLocalizations l, List<String> names) {
  if (names.isEmpty) return '';
  if (names.length == 1) return names.single;
  return l.listAnd(names.sublist(0, names.length - 1).join(', '), names.last);
}

/// "Tue, Oct 14, 10:40" in the UI language.
String appointmentText(AppLocalizations l, DateTime d, {bool use24h = true}) =>
    '${DateFormat.MMMEd(l.localeName).format(d)}, '
    '${(use24h ? DateFormat.Hm(l.localeName) : DateFormat.jm(l.localeName)).format(d)}';

String longDate(AppLocalizations l, DateTime d) =>
    DateFormat.yMMMd(l.localeName).format(d);
