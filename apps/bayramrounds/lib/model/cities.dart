import 'package:timezone/timezone.dart' as tz;

enum Region { turkey, germany, elsewhere }

/// A place a person lives, with its IANA time zone. Names are localized in
/// the UI (`cityName`); [id] is what is saved.
class City {
  const City(this.id, this.zone, this.region);
  final String id;
  final String zone;
  final Region region;
}

/// A short list on purpose: Turkey and Germany first, then the places
/// Turkish families abroad most often live. The two country entries stand
/// for any other town there (Turkey has one time zone, Germany too).
const cities = <City>[
  City('turkey', 'Europe/Istanbul', Region.turkey),
  City('istanbul', 'Europe/Istanbul', Region.turkey),
  City('ankara', 'Europe/Istanbul', Region.turkey),
  City('izmir', 'Europe/Istanbul', Region.turkey),
  City('bursa', 'Europe/Istanbul', Region.turkey),
  City('antalya', 'Europe/Istanbul', Region.turkey),
  City('adana', 'Europe/Istanbul', Region.turkey),
  City('konya', 'Europe/Istanbul', Region.turkey),
  City('kayseri', 'Europe/Istanbul', Region.turkey),
  City('gaziantep', 'Europe/Istanbul', Region.turkey),
  City('diyarbakir', 'Europe/Istanbul', Region.turkey),
  City('trabzon', 'Europe/Istanbul', Region.turkey),
  City('samsun', 'Europe/Istanbul', Region.turkey),
  City('erzurum', 'Europe/Istanbul', Region.turkey),
  City('eskisehir', 'Europe/Istanbul', Region.turkey),
  City('germany', 'Europe/Berlin', Region.germany),
  City('berlin', 'Europe/Berlin', Region.germany),
  City('hamburg', 'Europe/Berlin', Region.germany),
  City('munich', 'Europe/Berlin', Region.germany),
  City('cologne', 'Europe/Berlin', Region.germany),
  City('frankfurt', 'Europe/Berlin', Region.germany),
  City('stuttgart', 'Europe/Berlin', Region.germany),
  City('dusseldorf', 'Europe/Berlin', Region.germany),
  City('dortmund', 'Europe/Berlin', Region.germany),
  City('hannover', 'Europe/Berlin', Region.germany),
  City('bremen', 'Europe/Berlin', Region.germany),
  City('kiel', 'Europe/Berlin', Region.germany),
  City('amsterdam', 'Europe/Amsterdam', Region.elsewhere),
  City('brussels', 'Europe/Brussels', Region.elsewhere),
  City('vienna', 'Europe/Vienna', Region.elsewhere),
  City('zurich', 'Europe/Zurich', Region.elsewhere),
  City('paris', 'Europe/Paris', Region.elsewhere),
  City('london', 'Europe/London', Region.elsewhere),
  City('stockholm', 'Europe/Stockholm', Region.elsewhere),
  City('baku', 'Asia/Baku', Region.elsewhere),
  City('dubai', 'Asia/Dubai', Region.elsewhere),
  City('newYork', 'America/New_York', Region.elsewhere),
  City('toronto', 'America/Toronto', Region.elsewhere),
  City('losAngeles', 'America/Los_Angeles', Region.elsewhere),
  City('sydney', 'Australia/Sydney', Region.elsewhere),
];

const defaultCityId = 'turkey';

City cityById(String id) =>
    cities.firstWhere((c) => c.id == id, orElse: () => cities.first);

/// Wall-clock time in [city] at the instant [now].
tz.TZDateTime localTimeIn(City city, DateTime now) =>
    tz.TZDateTime.from(now, tz.getLocation(city.zone));

/// Late evening or early morning there: better to message than to call.
bool isNightThere(City city, DateTime now) {
  final h = localTimeIn(city, now).hour;
  return h >= 22 || h < 8;
}
