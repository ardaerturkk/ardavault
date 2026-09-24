import 'package:sagbar/model/book.dart';
import 'package:sagbar/model/content.dart';

/// "Today" for every golden and screenshot, so dates never drift.
final demoToday = DateTime(2026, 10, 6, 10);

/// Arda, two days before his Anmeldung.
Book typicalBook() => const Book()
    .withDetail(Slot.name, 'Arda Ertürk')
    .withDetail(Slot.address, 'Holtenauer Straße 12, 24105 Kiel')
    .withDetail(Slot.phone, '0176 4821 3390')
    .withDetail(Slot.email, 'arda.ertuerk@posteo.de')
    .withDetail(Slot.insurer, 'TK')
    .withDetail(Slot.insuranceNumber, 'T482193765')
    .withDetail(Slot.studentId, '1187425')
    .copyWith(birthDate: DateTime(2001, 3, 12))
    .withVisit(
      'buergeramt',
      Visit(ref: 'KI-2026-4815', appointment: DateTime(2026, 10, 8, 10, 40)),
    )
    .withVisit(
      'auslaenderbehoerde',
      Visit(ref: 'AB 31-0925/26', appointment: DateTime(2026, 11, 3, 8, 30)),
    );

/// Long names, own lines, hidden lines and a few gaps.
Book heavyBook() => const Book()
    .withDetail(Slot.name, 'Zeynep Nur Karaosmanoğlu-Yıldırımoğlu')
    .withDetail(
      Slot.address,
      'Olshausenstraße 40, Wohnheim Haus B, Zimmer 214, 24118 Kiel',
    )
    .withDetail(Slot.email, 'zeynep.karaosmanoglu-yildirimoglu@stu.uni-kiel.de')
    .withVisit(
      'buergeramt',
      Visit(
        ref: 'KI-2026-00048151623',
        appointment: DateTime(2026, 10, 7, 14, 5),
      ),
    )
    .hide('buergeramt:6')
    .hide('buergeramt:7')
    .addLine(
      'buergeramt',
      'Ich wohne zur Untermiete. Der Hauptmieter hat die Bestätigung '
          'unterschrieben.',
      'I am subletting. The main tenant signed the confirmation.',
    )
    .addLine('buergeramt', 'Brauchen Sie auch eine Kopie davon?', '');

/// Only the basics filled in.
Book partialBook() => const Book().withDetail(Slot.name, 'Arda Ertürk');
