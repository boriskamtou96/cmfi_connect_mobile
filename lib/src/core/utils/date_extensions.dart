extension DateApiX on DateTime {
  /// The API expects dates as YYYY-MM-DD (e.g. /reports/2026-10-08).
  String toApiDate() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  /// Same day at midnight, without time: the key used for report days.
  DateTime get dateOnly => DateTime(year, month, day);

  /// Monday of this date's week.
  DateTime get startOfWeek =>
      dateOnly.subtract(Duration(days: weekday - DateTime.monday));

  DateTime get startOfMonth => DateTime(year, month);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Days from [this] to [other] included, both at midnight.
  List<DateTime> daysUntil(DateTime other) => [
    for (
      var d = dateOnly;
      !d.isAfter(other.dateOnly);
      d = DateTime(d.year, d.month, d.day + 1)
    )
      d,
  ];
}

/// "YYYY-MM-DD" from the API, as a local date.
DateTime parseApiDate(String value) {
  final parts = value.split('-').map(int.parse).toList();
  return DateTime(parts[0], parts[1], parts[2]);
}

/// Today at midnight.
DateTime today() => DateTime.now().dateOnly;

extension DurationLabelX on int {
  /// Minutes as shown in the app: 45 -> "45 min", 120 -> "2 h", 135 -> "2 h 15".
  String toDurationLabel() {
    if (this < 60) {
      return '$this min';
    }
    final hours = this ~/ 60;
    final minutes = this % 60;
    return minutes == 0
        ? '$hours h'
        : '$hours h ${minutes.toString().padLeft(2, '0')}';
  }
}
