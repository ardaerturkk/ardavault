import '../l10n/app_localizations.dart';
import '../model/book.dart';
import '../model/cities.dart';
import '../model/occasion.dart';

String kindName(AppLocalizations l, OccasionKind k) => switch (k) {
  OccasionKind.ramazanBayrami => l.kindRamazan,
  OccasionKind.kurbanBayrami => l.kindKurban,
  OccasionKind.newYear => l.kindNewYear,
  OccasionKind.mothersDay => l.kindMothersDay,
  OccasionKind.fathersDayTr => l.kindFathersDayTr,
  OccasionKind.vatertagDe => l.kindVatertag,
  OccasionKind.birthday => l.kindBirthday,
};

/// A short line under a family day in the editor, so the rule is clear.
String? kindNote(AppLocalizations l, OccasionKind k) => switch (k) {
  OccasionKind.mothersDay => l.kindMothersDayNote,
  OccasionKind.fathersDayTr => l.kindFathersDayTrNote,
  OccasionKind.vatertagDe => l.kindVatertagNote,
  _ => null,
};

/// "Kurban Bayramı" or "Hasan Amca's Birthday".
String occasionName(AppLocalizations l, Occasion o, Book book) {
  if (o.kind == OccasionKind.birthday) {
    final p = o.personId == null ? null : book.person(o.personId!);
    return l.birthdayOf(p?.name ?? '');
  }
  return kindName(l, o.kind);
}

String? hijriLabel(AppLocalizations l, Occasion o) {
  final h = o.hijri;
  if (h == null) return null;
  return switch (h.month) {
    HijriMonth.shawwal => l.hijriShawwal(h.day, h.year),
    HijriMonth.dhuAlHijjah => l.hijriDhuAlHijjah(h.day, h.year),
  };
}

String circleName(AppLocalizations l, Circle c) => switch (c) {
  Circle.elders => l.circleElders,
  Circle.family => l.circleFamily,
  Circle.friends => l.circleFriends,
};

String regionName(AppLocalizations l, Region r) => switch (r) {
  Region.turkey => l.regionTurkey,
  Region.germany => l.regionGermany,
  Region.elsewhere => l.regionElsewhere,
};

/// City names as people write them in each language. Missing entries use
/// the English name.
const _cityNames = <String, Map<String, String>>{
  'istanbul': {'en': 'Istanbul', 'de': 'Istanbul', 'tr': 'İstanbul'},
  'ankara': {'en': 'Ankara'},
  'izmir': {'en': 'Izmir', 'de': 'Izmir', 'tr': 'İzmir'},
  'bursa': {'en': 'Bursa'},
  'antalya': {'en': 'Antalya'},
  'adana': {'en': 'Adana'},
  'konya': {'en': 'Konya'},
  'kayseri': {'en': 'Kayseri'},
  'gaziantep': {'en': 'Gaziantep'},
  'diyarbakir': {'en': 'Diyarbakır'},
  'trabzon': {'en': 'Trabzon'},
  'samsun': {'en': 'Samsun'},
  'erzurum': {'en': 'Erzurum'},
  'eskisehir': {'en': 'Eskişehir'},
  'berlin': {'en': 'Berlin'},
  'hamburg': {'en': 'Hamburg'},
  'munich': {'en': 'Munich', 'de': 'München', 'tr': 'Münih'},
  'cologne': {'en': 'Cologne', 'de': 'Köln', 'tr': 'Köln'},
  'frankfurt': {'en': 'Frankfurt'},
  'stuttgart': {'en': 'Stuttgart'},
  'dusseldorf': {'en': 'Düsseldorf'},
  'dortmund': {'en': 'Dortmund'},
  'hannover': {'en': 'Hanover', 'de': 'Hannover', 'tr': 'Hannover'},
  'bremen': {'en': 'Bremen'},
  'kiel': {'en': 'Kiel'},
  'amsterdam': {'en': 'Amsterdam'},
  'brussels': {'en': 'Brussels', 'de': 'Brüssel', 'tr': 'Brüksel'},
  'vienna': {'en': 'Vienna', 'de': 'Wien', 'tr': 'Viyana'},
  'zurich': {'en': 'Zurich', 'de': 'Zürich', 'tr': 'Zürih'},
  'paris': {'en': 'Paris'},
  'london': {'en': 'London', 'de': 'London', 'tr': 'Londra'},
  'stockholm': {'en': 'Stockholm'},
  'baku': {'en': 'Baku', 'de': 'Baku', 'tr': 'Bakü'},
  'dubai': {'en': 'Dubai', 'de': 'Dubai', 'tr': 'Dubai'},
  'newYork': {'en': 'New York'},
  'toronto': {'en': 'Toronto'},
  'losAngeles': {'en': 'Los Angeles'},
  'sydney': {'en': 'Sydney'},
};

String cityName(AppLocalizations l, City c) => switch (c.id) {
  'turkey' => l.regionTurkey,
  'germany' => l.regionGermany,
  _ => _cityNames[c.id]?[l.localeName] ?? _cityNames[c.id]?['en'] ?? c.id,
};

/// Case- and accent-insensitive search text, so "izmir" finds "İzmir" and
/// "munchen" finds "München".
String foldForSearch(String s) {
  const from = 'İIıŞşĞğÜüÖöÇçÄä';
  const to = 'iiissgguuooccaa';
  final b = StringBuffer();
  for (final ch in s.split('')) {
    final i = from.indexOf(ch);
    b.write(i < 0 ? ch : to[i]);
  }
  return b.toString().toLowerCase().replaceAll(' ', '');
}
