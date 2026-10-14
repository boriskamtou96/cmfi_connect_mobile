import 'package:flutter/material.dart';

/// How often the report goes to the spiritual authorities.
enum SendingRhythm {
  weekly(7),
  biweekly(14),
  monthly(0);

  const SendingRhythm(this.days);

  /// The days a report covers (the month for [monthly]).
  final int days;
}

/// The regular sending of the report to the authorities: at the chosen
/// moment, a notification; the app prepares the message, the user sends it.
@immutable
class SendingSettings {
  const SendingSettings({
    this.enabled = false,
    this.rhythm = SendingRhythm.weekly,
    this.weekday = DateTime.sunday,
    this.time = const TimeOfDay(hour: 20, minute: 0),
    this.authorityIds = const [],
    this.anchor,
  });

  factory SendingSettings.fromJson(Map<String, dynamic> json) =>
      SendingSettings(
        enabled: json['enabled'] as bool? ?? false,
        rhythm:
            SendingRhythm.values.asNameMap()[json['rhythm']] ??
            SendingRhythm.weekly,
        weekday: json['weekday'] as int? ?? DateTime.sunday,
        time: TimeOfDay(
          hour: (json['minutes'] as int? ?? 20 * 60) ~/ 60,
          minute: (json['minutes'] as int? ?? 20 * 60) % 60,
        ),
        authorityIds: [
          for (final id in json['authorities'] as List? ?? const []) id as int,
        ],
        anchor: DateTime.tryParse(json['anchor'] as String? ?? ''),
      );

  final bool enabled;
  final SendingRhythm rhythm;

  /// [DateTime.monday] to [DateTime.sunday]: the day of a weekly sending.
  final int weekday;
  final TimeOfDay time;

  /// The authorities it goes to (their ids).
  final List<int> authorityIds;

  /// Every two weeks: a day of sending, the others follow 14 days apart.
  final DateTime? anchor;

  SendingSettings copyWith({
    bool? enabled,
    SendingRhythm? rhythm,
    int? weekday,
    TimeOfDay? time,
    List<int>? authorityIds,
    DateTime? anchor,
  }) => SendingSettings(
    enabled: enabled ?? this.enabled,
    rhythm: rhythm ?? this.rhythm,
    weekday: weekday ?? this.weekday,
    time: time ?? this.time,
    authorityIds: authorityIds ?? this.authorityIds,
    anchor: anchor ?? this.anchor,
  );

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'rhythm': rhythm.name,
    'weekday': weekday,
    'minutes': time.hour * 60 + time.minute,
    'authorities': authorityIds,
    if (anchor case final anchor?) 'anchor': _day(anchor),
  };

  @override
  bool operator ==(Object other) =>
      other is SendingSettings &&
      other.enabled == enabled &&
      other.rhythm == rhythm &&
      other.weekday == weekday &&
      other.time == time &&
      _sameIds(other.authorityIds, authorityIds) &&
      other.anchor == anchor;

  @override
  int get hashCode => Object.hash(
    enabled,
    rhythm,
    weekday,
    time,
    Object.hashAll(authorityIds),
    anchor,
  );
}

bool _sameIds(List<int> a, List<int> b) =>
    a.length == b.length && a.indexed.every((e) => b[e.$1] == e.$2);

String _day(DateTime day) =>
    '${day.year.toString().padLeft(4, '0')}-'
    '${day.month.toString().padLeft(2, '0')}-'
    '${day.day.toString().padLeft(2, '0')}';

/// The next [count] moments of sending after [now].
List<DateTime> sendingTimes(
  SendingSettings settings, {
  required DateTime now,
  int count = 6,
}) {
  final time = settings.time;
  DateTime at(DateTime day) =>
      DateTime(day.year, day.month, day.day, time.hour, time.minute);
  final times = <DateTime>[];

  switch (settings.rhythm) {
    case SendingRhythm.monthly:
      for (var month = now.month; times.length < count; month++) {
        final moment = at(DateTime(now.year, month, 1));
        if (moment.isAfter(now)) {
          times.add(moment);
        }
      }
    case SendingRhythm.weekly || SendingRhythm.biweekly:
      final step = settings.rhythm.days;
      var day = settings.anchor ?? firstWeekday(settings.weekday, now: now);
      day = DateTime(day.year, day.month, day.day);
      // back to the first one of the series not past yet
      while (at(day).isAfter(now)) {
        day = DateTime(day.year, day.month, day.day - step);
      }
      while (times.length < count) {
        if (at(day).isAfter(now)) {
          times.add(at(day));
        }
        day = DateTime(day.year, day.month, day.day + step);
      }
  }
  return times;
}

/// The first [weekday] from [now] on (today included).
DateTime firstWeekday(int weekday, {required DateTime now}) {
  final ahead = (weekday - now.weekday) % 7;
  return DateTime(now.year, now.month, now.day + ahead);
}

/// The days a report sent on [day] covers: the week (or two) ending that
/// day, or the month before.
({DateTime from, DateTime to}) sendingPeriod(
  SendingRhythm rhythm,
  DateTime day,
) => switch (rhythm) {
  SendingRhythm.monthly => (
    from: DateTime(day.year, day.month - 1, 1),
    to: DateTime(day.year, day.month, 0),
  ),
  _ => (
    from: DateTime(day.year, day.month, day.day - rhythm.days + 1),
    to: DateTime(day.year, day.month, day.day),
  ),
};

/// A report sent: when, which days, to whom.
@immutable
class SentReport {
  const SentReport({
    required this.at,
    required this.from,
    required this.to,
    required this.names,
  });

  factory SentReport.fromJson(Map<String, dynamic> json) => SentReport(
    at: DateTime.parse(json['at'] as String),
    from: DateTime.parse(json['from'] as String),
    to: DateTime.parse(json['to'] as String),
    names: [for (final name in json['names'] as List) name as String],
  );

  final DateTime at;
  final DateTime from;
  final DateTime to;
  final List<String> names;

  Map<String, dynamic> toJson() => {
    'at': at.toIso8601String(),
    'from': _day(from),
    'to': _day(to),
    'names': names,
  };
}

/// The payload of the notification of a sending ("report_send:2026-10-18"),
/// and back.
const sendingPayloadPrefix = 'report_send:';

String sendingPayload(DateTime day) => '$sendingPayloadPrefix${_day(day)}';

DateTime? sendingDayOf(String? payload) =>
    payload != null && payload.startsWith(sendingPayloadPrefix)
    ? DateTime.tryParse(payload.substring(sendingPayloadPrefix.length))
    : null;
