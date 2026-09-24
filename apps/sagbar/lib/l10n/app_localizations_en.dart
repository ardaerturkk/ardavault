// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sagbar';

  @override
  String get tabSituations => 'Situations';

  @override
  String get tabMe => 'My Details';

  @override
  String get startTitle => 'Add Your Details Once';

  @override
  String get startBody =>
      'Your name, address and numbers go straight into every German line.';

  @override
  String get startButton => 'Add My Details';

  @override
  String get situationsFooter =>
      'Everyday phrases for the counter and the phone. They are not legal advice.';

  @override
  String appointmentOn(String date) {
    return 'Appointment $date';
  }

  @override
  String get fillMissing => 'Fill In Missing Details';

  @override
  String missingList(String names) {
    return 'Missing: $names';
  }

  @override
  String get visitHeader => 'This Visit';

  @override
  String get appointment => 'Appointment';

  @override
  String get removeAppointment => 'Remove Appointment';

  @override
  String get refFooter =>
      'The number from your letter or booking confirmation.';

  @override
  String get notSet => 'Not Set';

  @override
  String get linesHeader => 'Lines';

  @override
  String get linesFooter =>
      'Tap a line to show it in large type. Touch and hold to copy or hide it.';

  @override
  String get noLines => 'No lines here. Add your own or show the hidden ones.';

  @override
  String get addLine => 'Add Your Own Line';

  @override
  String showHidden(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Show $count Hidden Lines',
      one: 'Show 1 Hidden Line',
    );
    return '$_temp0';
  }

  @override
  String get showCards => 'Show Cards';

  @override
  String get yourLine => 'Your line';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get hideLine => 'Hide Line';

  @override
  String get editLine => 'Edit Line';

  @override
  String get deleteLine => 'Delete Line';

  @override
  String get deleteLineConfirm => 'This line will be deleted.';

  @override
  String get newLine => 'New Line';

  @override
  String get germanLabel => 'German';

  @override
  String get germanHint => 'What you want to say, in German';

  @override
  String get meaningLabel => 'Meaning';

  @override
  String get meaningHint => 'What it means (optional)';

  @override
  String get lineEditorFooter =>
      'Write it the way you want to say it. Your details are not filled into your own lines.';

  @override
  String cardOf(int index, int total) {
    return '$index of $total';
  }

  @override
  String get previousLine => 'Previous Line';

  @override
  String get nextLine => 'Next Line';

  @override
  String get aboutYou => 'About You';

  @override
  String get contact => 'Contact';

  @override
  String get numbers => 'Numbers';

  @override
  String get meFooter =>
      'Stored only on this iPhone. Sagbar fills these into your German lines.';

  @override
  String get fieldName => 'Full Name';

  @override
  String get fieldBirthDate => 'Date of Birth';

  @override
  String get fieldAddress => 'Address';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldInsurer => 'Health Insurer';

  @override
  String get fieldInsuranceNumber => 'Insurance Number';

  @override
  String get fieldStudentId => 'Student Number';

  @override
  String get fieldTime => 'Appointment Time';

  @override
  String get fieldDate => 'Appointment Date';

  @override
  String get hintName => 'As in your passport';

  @override
  String get hintAddress => 'Street and number, postcode and city';

  @override
  String get hintPhone => 'Your mobile number';

  @override
  String get hintEmail => 'name@example.com';

  @override
  String get hintInsurer => 'For example TK or AOK';

  @override
  String get hintInsuranceNumber => 'On your health insurance card';

  @override
  String get hintStudentId => 'On your student ID card';

  @override
  String get footerName =>
      'Used in lines like “Mein Name ist …” and spelled out letter by letter.';

  @override
  String get footerAddress =>
      'Write it the German way: Holtenauer Straße 12, 24105 Kiel.';

  @override
  String get removeBirthDate => 'Remove Date of Birth';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get done => 'Done';

  @override
  String get ok => 'OK';

  @override
  String get discardChanges => 'Discard Changes';

  @override
  String get keepEditing => 'Keep Editing';

  @override
  String listAnd(String first, String last) {
    return '$first and $last';
  }

  @override
  String get loadFailed =>
      'Your saved details could not be read. A copy was kept, and Sagbar started empty.';

  @override
  String get saveFailed =>
      'The last change could not be saved. Sagbar will try again with the next change.';

  @override
  String get semLineHint => 'Shows the line in large type';

  @override
  String semMissing(String name) {
    return 'missing: $name';
  }
}
