/// A calendar date with no time and no time zone. All day math goes through
/// UTC midnight so daylight-saving changes can never shift a count.
class Day implements Comparable<Day> {
  Day(int year, int month, int day) : _utc = DateTime.utc(year, month, day);

  /// The local calendar date of [d] (what the user sees on the clock).
  factory Day.of(DateTime d) => Day(d.year, d.month, d.day);

  factory Day.parse(String s) {
    final parts = s.split('-');
    if (parts.length != 3) throw FormatException('Not a date: $s');
    return Day(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  final DateTime _utc;

  int get year => _utc.year;
  int get month => _utc.month;
  int get day => _utc.day;

  /// Monday = 1 ... Sunday = 7.
  int get weekday => _utc.weekday;

  Day plus(int days) => Day(year, month, day + days);

  /// Whole calendar days from this date to [other] (negative if earlier).
  int daysUntil(Day other) => other._utc.difference(_utc).inDays;

  /// The Monday of this date's week.
  Day get weekStart => plus(1 - weekday);

  bool isBefore(Day other) => compareTo(other) < 0;
  bool isAfter(Day other) => compareTo(other) > 0;

  /// Local midnight, for date pickers and formatting.
  DateTime toLocal() => DateTime(year, month, day);

  @override
  int compareTo(Day other) => _utc.compareTo(other._utc);

  @override
  bool operator ==(Object other) => other is Day && other._utc == _utc;

  @override
  int get hashCode => _utc.hashCode;

  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';
}
