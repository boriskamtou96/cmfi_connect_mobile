import 'package:flutter/foundation.dart';

/// A full fast (nothing, day and night) or a partial one (until an hour of
/// the afternoon, each day): « Jeûne complet » (JC) and « Jeûne partiel »
/// (JP) of the report.
enum FastKind { full, partial }

/// A fast the member started: each day kept adds 1 to JC or JP in the
/// report of the day it ends.
@immutable
class Fast {
  const Fast({
    required this.kind,
    required this.start,
    required this.days,
    this.endMinutes = 18 * 60,
    this.topics = const [],
    this.counted = const {},
    this.stoppedAt,
  });

  factory Fast.fromJson(Map<String, dynamic> json) => Fast(
    kind: FastKind.values.asNameMap()[json['kind']] ?? FastKind.full,
    start: DateTime.parse(json['start'] as String),
    days: json['days'] as int,
    endMinutes: json['end_minutes'] as int? ?? 18 * 60,
    topics: [for (final topic in json['topics'] as List? ?? const []) '$topic'],
    counted: {for (final day in json['counted'] as List? ?? const []) '$day'},
    stoppedAt: json['stopped_at'] == null
        ? null
        : DateTime.parse(json['stopped_at'] as String),
  );

  final FastKind kind;

  /// When it began (a full fast counts its days from this moment).
  final DateTime start;
  final int days;

  /// A partial fast ends each day at this time (minutes after midnight).
  final int endMinutes;

  /// What the member fasts for.
  final List<String> topics;

  /// The days already added to the report ("2026-10-18").
  final Set<String> counted;

  /// Broken before its end: the day under way doesn't count.
  final DateTime? stoppedAt;

  /// The end of day [index] (0 the first): 24 hours after the previous one
  /// for a full fast; the set hour for a partial one (from tomorrow when it
  /// starts after that hour).
  DateTime endOfDay(int index) {
    if (kind == FastKind.full) {
      return start.add(Duration(days: index + 1));
    }
    final first = DateTime(start.year, start.month, start.day);
    final late = start.hour * 60 + start.minute >= endMinutes;
    final day = DateTime(
      first.year,
      first.month,
      first.day + index + (late ? 1 : 0),
    );
    return day.add(Duration(minutes: endMinutes));
  }

  DateTime get end => endOfDay(days - 1);

  /// Over at [now]: its last day ended, or it was broken.
  bool isOverAt(DateTime now) => stoppedAt != null || !now.isBefore(end);

  /// The days kept by [now] (ended before it, and before it was broken).
  int keptAt(DateTime now) {
    final until = stoppedAt != null && stoppedAt!.isBefore(now)
        ? stoppedAt!
        : now;
    var kept = 0;
    for (var i = 0; i < days; i++) {
      if (!endOfDay(i).isAfter(until)) {
        kept++;
      }
    }
    return kept;
  }

  /// The day under way at [now] (0 the first), [days] once it is over.
  int dayAt(DateTime now) => keptAt(now).clamp(0, days);

  /// The ends of the days kept by [now] that aren't counted yet.
  List<DateTime> toCountAt(DateTime now) => [
    for (var i = 0; i < keptAt(now); i++)
      if (!counted.contains(dayKey(endOfDay(i)))) endOfDay(i),
  ];

  Fast copyWith({
    List<String>? topics,
    Set<String>? counted,
    DateTime? stoppedAt,
  }) => Fast(
    kind: kind,
    start: start,
    days: days,
    endMinutes: endMinutes,
    topics: topics ?? this.topics,
    counted: counted ?? this.counted,
    stoppedAt: stoppedAt ?? this.stoppedAt,
  );

  Map<String, dynamic> toJson() => {
    'kind': kind.name,
    'start': start.toIso8601String(),
    'days': days,
    'end_minutes': endMinutes,
    if (topics.isNotEmpty) 'topics': topics,
    if (counted.isNotEmpty) 'counted': counted.toList(),
    if (stoppedAt != null) 'stopped_at': stoppedAt!.toIso8601String(),
  };

  /// "2026-10-18".
  static String dayKey(DateTime at) =>
      '${at.year.toString().padLeft(4, '0')}-'
      '${at.month.toString().padLeft(2, '0')}-'
      '${at.day.toString().padLeft(2, '0')}';
}

/// A fast over, as the history keeps it.
@immutable
class PastFast {
  const PastFast({
    required this.kind,
    required this.start,
    required this.days,
    required this.kept,
  });

  factory PastFast.fromJson(Map<String, dynamic> json) => PastFast(
    kind: FastKind.values.asNameMap()[json['kind']] ?? FastKind.full,
    start: DateTime.parse(json['start'] as String),
    days: json['days'] as int,
    kept: json['kept'] as int,
  );

  final FastKind kind;
  final DateTime start;
  final int days;

  /// The days kept: [days] when it went to its end.
  final int kept;

  Map<String, dynamic> toJson() => {
    'kind': kind.name,
    'start': start.toIso8601String(),
    'days': days,
    'kept': kept,
  };
}
