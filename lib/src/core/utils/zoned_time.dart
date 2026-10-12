import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

tz.Location? _location(String zone) {
  if (!tz.timeZoneDatabase.isInitialized) {
    tzdata.initializeTimeZones();
  }
  try {
    return tz.getLocation(zone);
  } on tz.LocationNotFoundException {
    return null;
  }
}

/// The instant when the clocks of [zone] show [wall]'s date and time: what an
/// admin types for an event ("20 November, 8:00" in Yaoundé).
DateTime instantAt(String zone, DateTime wall) {
  final location = _location(zone);
  if (location == null) {
    return DateTime(wall.year, wall.month, wall.day, wall.hour, wall.minute);
  }
  final zoned = tz.TZDateTime(
    location,
    wall.year,
    wall.month,
    wall.day,
    wall.hour,
    wall.minute,
  );
  return DateTime.fromMicrosecondsSinceEpoch(
    zoned.microsecondsSinceEpoch,
    isUtc: true,
  );
}

extension ZonedTimeX on DateTime {
  /// This instant on the clocks of [zone] ("Africa/Douala"): an event shows
  /// its times as announced where it happens, wherever the member reads them.
  /// The phone's own time when the zone is unknown.
  DateTime inZone(String zone) {
    final location = _location(zone);
    return location == null ? toLocal() : tz.TZDateTime.from(this, location);
  }
}
