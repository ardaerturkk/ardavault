/// The built-in situations and their German lines.
///
/// Lines are short, polite Standard German (Sie form). Slots in braces are
/// filled from the user's details: see [Slot]. Meanings are given in English
/// and Turkish; the German text itself never changes with the UI language.
library;

/// A value that can be filled into a line.
enum Slot {
  name,
  nameSpelled,
  birthDate,
  address,
  phone,
  email,
  insurer,
  insuranceNumber,
  studentId,

  /// The reference number for this visit (its German label depends on the
  /// situation, like Aktenzeichen or Kundennummer).
  ref,

  /// Appointment time for this visit, "10:40".
  time,

  /// Appointment date for this visit, "14. Oktober".
  date,
}

/// Personal details the user keeps once, in the order the Me tab shows them.
/// [Slot.nameSpelled] is derived from the name; ref, time and date belong
/// to a single visit.
const profileSlots = [
  Slot.name,
  Slot.birthDate,
  Slot.address,
  Slot.phone,
  Slot.email,
  Slot.insurer,
  Slot.insuranceNumber,
  Slot.studentId,
];

class BuiltInLine {
  const BuiltInLine(this.id, this.german, this.en, this.tr);
  final String id;
  final String german;
  final String en;
  final String tr;
}

class Situation {
  const Situation({
    required this.id,
    required this.german,
    required this.purposeEn,
    required this.purposeDe,
    required this.purposeTr,
    required this.lines,
    this.refLabel,
    this.hasAppointment = false,
  });

  final String id;

  /// The office or place as Germans call it; the same in every UI language.
  final String german;
  final String purposeEn;
  final String purposeDe;
  final String purposeTr;
  final List<BuiltInLine> lines;

  /// German name of this situation's reference number, or null if it has
  /// none.
  final String? refLabel;
  final bool hasAppointment;

  String purpose(String locale) => switch (locale) {
    'de' => purposeDe,
    'tr' => purposeTr,
    _ => purposeEn,
  };
}

const situations = <Situation>[
  Situation(
    id: 'basics',
    german: 'Allgemein',
    purposeEn: 'For any counter or call',
    purposeDe: 'Für jeden Schalter und jedes Telefonat',
    purposeTr: 'Her gişe ve telefon için',
    lines: [
      BuiltInLine(
        'basics:1',
        'Guten Tag. Ich spreche leider noch nicht so gut Deutsch.',
        'Hello. I am afraid my German is not very good yet.',
        'Merhaba. Maalesef Almancam henüz pek iyi değil.',
      ),
      BuiltInLine(
        'basics:2',
        'Könnten Sie bitte etwas langsamer sprechen?',
        'Could you speak a little more slowly, please?',
        'Biraz daha yavaş konuşabilir misiniz lütfen?',
      ),
      BuiltInLine(
        'basics:3',
        'Können Sie das bitte noch einmal sagen?',
        'Could you say that again, please?',
        'Bunu bir kez daha söyleyebilir misiniz lütfen?',
      ),
      BuiltInLine(
        'basics:4',
        'Könnten Sie mir das bitte aufschreiben?',
        'Could you write that down for me, please?',
        'Bunu bana yazabilir misiniz lütfen?',
      ),
      BuiltInLine(
        'basics:5',
        'Könnten wir vielleicht Englisch sprechen?',
        'Could we perhaps speak English?',
        'Acaba İngilizce konuşabilir miyiz?',
      ),
      BuiltInLine(
        'basics:6',
        'Mein Name ist {name}. Ich buchstabiere: {nameSpelled}.',
        'My name is {name}. Let me spell it: {nameSpelled}.',
        'Adım {name}. Harf harf söylüyorum: {nameSpelled}.',
      ),
      BuiltInLine(
        'basics:7',
        'Vielen Dank für Ihre Hilfe. Auf Wiedersehen.',
        'Thank you very much for your help. Goodbye.',
        'Yardımınız için çok teşekkürler. Hoşça kalın.',
      ),
    ],
  ),
  Situation(
    id: 'buergeramt',
    german: 'Bürgeramt',
    purposeEn: 'Registering your address',
    purposeDe: 'Wohnsitz anmelden',
    purposeTr: 'Adres kaydı (Anmeldung)',
    refLabel: 'Vorgangsnummer',
    hasAppointment: true,
    lines: [
      BuiltInLine(
        'buergeramt:1',
        'Guten Tag, ich habe um {time} Uhr einen Termin.',
        'Hello, I have an appointment at {time}.',
        'Merhaba, saat {time} için randevum var.',
      ),
      BuiltInLine(
        'buergeramt:2',
        'Meine Vorgangsnummer ist {ref}.',
        'My booking number is {ref}.',
        'Randevu numaram {ref}.',
      ),
      BuiltInLine(
        'buergeramt:3',
        'Ich möchte meinen Wohnsitz anmelden.',
        'I would like to register my address.',
        'İkamet adresimi kaydettirmek istiyorum.',
      ),
      BuiltInLine(
        'buergeramt:4',
        'Meine neue Adresse lautet: {address}.',
        'My new address is: {address}.',
        'Yeni adresim: {address}.',
      ),
      BuiltInLine(
        'buergeramt:5',
        'Ich bin am {birthDate} geboren.',
        'I was born on {birthDate}.',
        '{birthDate} tarihinde doğdum.',
      ),
      BuiltInLine(
        'buergeramt:6',
        'Hier sind mein Reisepass und die Wohnungsgeberbestätigung.',
        'Here are my passport and the confirmation from my landlord.',
        'İşte pasaportum ve ev sahibi onay belgesi.',
      ),
      BuiltInLine(
        'buergeramt:7',
        'Muss ich noch etwas unterschreiben?',
        'Do I need to sign anything else?',
        'İmzalamam gereken başka bir şey var mı?',
      ),
      BuiltInLine(
        'buergeramt:8',
        'Bekomme ich die Meldebescheinigung gleich heute?',
        'Will I get the registration certificate today?',
        'Kayıt belgesini (Meldebescheinigung) bugün alabilir miyim?',
      ),
    ],
  ),
  Situation(
    id: 'auslaenderbehoerde',
    german: 'Ausländerbehörde',
    purposeEn: 'Residence permit',
    purposeDe: 'Aufenthaltserlaubnis',
    purposeTr: 'Oturum izni',
    refLabel: 'Aktenzeichen',
    hasAppointment: true,
    lines: [
      BuiltInLine(
        'auslaenderbehoerde:1',
        'Guten Tag, ich habe um {time} Uhr einen Termin.',
        'Hello, I have an appointment at {time}.',
        'Merhaba, saat {time} için randevum var.',
      ),
      BuiltInLine(
        'auslaenderbehoerde:2',
        'Mein Name ist {name}, geboren am {birthDate}.',
        'My name is {name}, born on {birthDate}.',
        'Adım {name}, doğum tarihim {birthDate}.',
      ),
      BuiltInLine(
        'auslaenderbehoerde:3',
        'Mein Aktenzeichen lautet {ref}.',
        'My file number is {ref}.',
        'Dosya numaram {ref}.',
      ),
      BuiltInLine(
        'auslaenderbehoerde:4',
        'Ich möchte eine Aufenthaltserlaubnis zum Studium beantragen.',
        'I would like to apply for a residence permit for my studies.',
        'Öğrenim için oturum izni başvurusu yapmak istiyorum.',
      ),
      BuiltInLine(
        'auslaenderbehoerde:5',
        'Ich möchte meine Aufenthaltserlaubnis verlängern.',
        'I would like to extend my residence permit.',
        'Oturum iznimi uzatmak istiyorum.',
      ),
      BuiltInLine(
        'auslaenderbehoerde:6',
        'Welche Unterlagen fehlen noch?',
        'Which documents are still missing?',
        'Hangi belgeler hâlâ eksik?',
      ),
      BuiltInLine(
        'auslaenderbehoerde:7',
        'Bekomme ich eine Fiktionsbescheinigung, bis der Aufenthaltstitel '
            'fertig ist?',
        'Will I get a provisional certificate (Fiktionsbescheinigung) until '
            'the residence permit is ready?',
        'Oturum izni hazır olana kadar geçici bir belge '
            '(Fiktionsbescheinigung) alabilir miyim?',
      ),
      BuiltInLine(
        'auslaenderbehoerde:8',
        'Wann kann ich meinen Aufenthaltstitel abholen?',
        'When can I pick up the residence permit card?',
        'Oturum kartını ne zaman alabilirim?',
      ),
    ],
  ),
  Situation(
    id: 'bank',
    german: 'Bank',
    purposeEn: 'Opening an account',
    purposeDe: 'Konto eröffnen',
    purposeTr: 'Hesap açma',
    refLabel: 'Kundennummer',
    hasAppointment: true,
    lines: [
      BuiltInLine(
        'bank:1',
        'Guten Tag, ich habe um {time} Uhr einen Termin.',
        'Hello, I have an appointment at {time}.',
        'Merhaba, saat {time} için randevum var.',
      ),
      BuiltInLine(
        'bank:2',
        'Ich möchte ein Girokonto eröffnen.',
        'I would like to open a checking account.',
        'Vadesiz hesap (Girokonto) açmak istiyorum.',
      ),
      BuiltInLine(
        'bank:3',
        'Gibt es ein kostenloses Konto für Studierende?',
        'Is there a free account for students?',
        'Öğrenciler için ücretsiz bir hesap var mı?',
      ),
      BuiltInLine(
        'bank:4',
        'Meine Adresse ist {address}. Die Meldebescheinigung habe ich dabei.',
        'My address is {address}. I have the registration certificate with me.',
        'Adresim {address}. Kayıt belgem (Meldebescheinigung) yanımda.',
      ),
      BuiltInLine(
        'bank:5',
        'Meine Kundennummer ist {ref}.',
        'My customer number is {ref}.',
        'Müşteri numaram {ref}.',
      ),
      BuiltInLine(
        'bank:6',
        'Welche Gebühren fallen für das Konto an?',
        'What fees are there for the account?',
        'Hesap için hangi ücretler alınıyor?',
      ),
      BuiltInLine(
        'bank:7',
        'Ich hätte außerdem gern eine Debitkarte und Onlinebanking.',
        'I would also like a debit card and online banking.',
        'Bir de banka kartı ve internet bankacılığı istiyorum.',
      ),
      BuiltInLine(
        'bank:8',
        'Ich bin umgezogen. Meine neue Adresse ist {address}.',
        'I have moved. My new address is {address}.',
        'Taşındım. Yeni adresim {address}.',
      ),
    ],
  ),
  Situation(
    id: 'krankenkasse',
    german: 'Krankenkasse',
    purposeEn: 'Health insurance',
    purposeDe: 'Krankenversicherung',
    purposeTr: 'Sağlık sigortası',
    lines: [
      BuiltInLine(
        'krankenkasse:1',
        'Guten Tag, mein Name ist {name}. Ich bin bei Ihnen versichert.',
        'Hello, my name is {name}. I am insured with you.',
        'Merhaba, adım {name}. Sizde sigortalıyım.',
      ),
      BuiltInLine(
        'krankenkasse:2',
        'Meine Versichertennummer ist {insuranceNumber}.',
        'My insurance number is {insuranceNumber}.',
        'Sigorta numaram {insuranceNumber}.',
      ),
      BuiltInLine(
        'krankenkasse:3',
        'Mein Geburtsdatum ist der {birthDate}.',
        'My date of birth is {birthDate}.',
        'Doğum tarihim {birthDate}.',
      ),
      BuiltInLine(
        'krankenkasse:4',
        'Könnten Sie meinen Versicherungsstatus bitte an die Hochschule melden?',
        'Could you please report my insurance status to the university?',
        'Sigorta durumumu üniversiteye bildirebilir misiniz lütfen?',
      ),
      BuiltInLine(
        'krankenkasse:5',
        'Ich habe meine Gesundheitskarte noch nicht bekommen.',
        'I have not received my health insurance card yet.',
        'Sağlık kartımı henüz almadım.',
      ),
      BuiltInLine(
        'krankenkasse:6',
        'Ich bin umgezogen. Meine neue Adresse ist {address}.',
        'I have moved. My new address is {address}.',
        'Taşındım. Yeni adresim {address}.',
      ),
      BuiltInLine(
        'krankenkasse:7',
        'Könnten Sie mir das bitte per E-Mail an {email} schicken?',
        'Could you please send that to me by email at {email}?',
        'Bunu bana {email} adresine e-postayla gönderebilir misiniz lütfen?',
      ),
    ],
  ),
  Situation(
    id: 'arztpraxis',
    german: 'Arztpraxis',
    purposeEn: 'At the doctor’s reception',
    purposeDe: 'An der Anmeldung beim Arzt',
    purposeTr: 'Doktor muayenehanesinde',
    hasAppointment: true,
    lines: [
      BuiltInLine(
        'arztpraxis:1',
        'Guten Tag, ich habe um {time} Uhr einen Termin.',
        'Hello, I have an appointment at {time}.',
        'Merhaba, saat {time} için randevum var.',
      ),
      BuiltInLine(
        'arztpraxis:2',
        'Ich bin zum ersten Mal in dieser Praxis.',
        'This is my first time at this practice.',
        'Bu muayenehaneye ilk kez geliyorum.',
      ),
      BuiltInLine(
        'arztpraxis:3',
        'Ich bin bei der {insurer} versichert. Hier ist meine Karte.',
        'I am insured with {insurer}. Here is my card.',
        '{insurer} sigortalısıyım. Kartım burada.',
      ),
      BuiltInLine(
        'arztpraxis:4',
        'Ich möchte gern einen Termin vereinbaren.',
        'I would like to make an appointment.',
        'Randevu almak istiyorum.',
      ),
      BuiltInLine(
        'arztpraxis:5',
        'Es ist dringend. Könnte ich heute noch vorbeikommen?',
        'It is urgent. Could I still come in today?',
        'Acil bir durum. Bugün gelebilir miyim?',
      ),
      BuiltInLine(
        'arztpraxis:6',
        'Sie erreichen mich unter {phone}.',
        'You can reach me at {phone}.',
        'Bana {phone} numarasından ulaşabilirsiniz.',
      ),
      BuiltInLine(
        'arztpraxis:7',
        'Ich muss meinen Termin am {date} leider absagen.',
        'I am afraid I have to cancel my appointment on {date}.',
        'Maalesef {date} tarihindeki randevumu iptal etmem gerekiyor.',
      ),
    ],
  ),
  Situation(
    id: 'vermieter',
    german: 'Vermieter',
    purposeEn: 'Calling your landlord',
    purposeDe: 'Anruf beim Vermieter',
    purposeTr: 'Ev sahibini arama',
    lines: [
      BuiltInLine(
        'vermieter:1',
        'Guten Tag, hier spricht {name}.',
        'Hello, this is {name} speaking.',
        'Merhaba, ben {name}.',
      ),
      BuiltInLine(
        'vermieter:2',
        'Ich rufe wegen meiner Wohnung an: {address}.',
        'I am calling about my apartment: {address}.',
        'Dairem hakkında arıyorum: {address}.',
      ),
      BuiltInLine(
        'vermieter:3',
        'Ich brauche bitte die Wohnungsgeberbestätigung für die Anmeldung.',
        'I need the landlord confirmation for registering my address, please.',
        'Adres kaydı için ev sahibi onay belgesine ihtiyacım var lütfen.',
      ),
      BuiltInLine(
        'vermieter:4',
        'Die Heizung funktioniert nicht.',
        'The heating is not working.',
        'Kalorifer çalışmıyor.',
      ),
      BuiltInLine(
        'vermieter:5',
        'Wann könnte jemand vorbeikommen, um sich das anzusehen?',
        'When could someone come by to take a look?',
        'Birisi ne zaman gelip bakabilir?',
      ),
      BuiltInLine(
        'vermieter:6',
        'Könnten Sie mir das bitte schriftlich bestätigen? Meine '
            'E-Mail-Adresse ist {email}.',
        'Could you please confirm that in writing? My email address is '
            '{email}.',
        'Bunu yazılı olarak onaylayabilir misiniz lütfen? E-posta adresim '
            '{email}.',
      ),
      BuiltInLine(
        'vermieter:7',
        'Sie erreichen mich unter {phone}.',
        'You can reach me at {phone}.',
        'Bana {phone} numarasından ulaşabilirsiniz.',
      ),
    ],
  ),
  Situation(
    id: 'hochschule',
    german: 'Hochschule',
    purposeEn: 'Student office',
    purposeDe: 'Studierendensekretariat',
    purposeTr: 'Öğrenci işleri',
    lines: [
      BuiltInLine(
        'hochschule:1',
        'Guten Tag, ich habe eine Frage zu meiner Einschreibung.',
        'Hello, I have a question about my enrollment.',
        'Merhaba, kaydımla ilgili bir sorum var.',
      ),
      BuiltInLine(
        'hochschule:2',
        'Meine Matrikelnummer ist {studentId}.',
        'My student number is {studentId}.',
        'Öğrenci numaram {studentId}.',
      ),
      BuiltInLine(
        'hochschule:3',
        'Ich brauche eine Immatrikulationsbescheinigung.',
        'I need a certificate of enrollment.',
        'Öğrenci belgesine ihtiyacım var.',
      ),
      BuiltInLine(
        'hochschule:4',
        'Ich habe den Semesterbeitrag schon überwiesen.',
        'I have already transferred the semester fee.',
        'Dönem katkı payını zaten havale ettim.',
      ),
      BuiltInLine(
        'hochschule:5',
        'Ich habe meinen Studierendenausweis noch nicht bekommen.',
        'I have not received my student ID card yet.',
        'Öğrenci kimlik kartımı henüz almadım.',
      ),
      BuiltInLine(
        'hochschule:6',
        'Bis wann muss ich die Unterlagen einreichen?',
        'By when do I have to hand in the documents?',
        'Belgeleri en geç ne zaman teslim etmem gerekiyor?',
      ),
      BuiltInLine(
        'hochschule:7',
        'Meine E-Mail-Adresse ist {email}.',
        'My email address is {email}.',
        'E-posta adresim {email}.',
      ),
    ],
  ),
];

Situation? situationById(String id) {
  for (final s in situations) {
    if (s.id == id) return s;
  }
  return null;
}
