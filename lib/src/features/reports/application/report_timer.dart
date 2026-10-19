import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import 'report_counts.dart';

part 'report_timer.g.dart';

/// The stopwatch of an item counted in time (« Prière seule »…): started
/// from its entry sheet, it goes on when the app is closed (only its start
/// is kept), and its time goes to the report of the day it started.
@immutable
class RunningTimer {
  const RunningTimer({
    required this.activityTypeId,
    required this.code,
    required this.label,
    required this.startedAt,
    this.pausedAt,
    this.pausedFor = Duration.zero,
  });

  factory RunningTimer.fromJson(Map<String, dynamic> json) => RunningTimer(
    activityTypeId: json['activity_type_id'] as int,
    code: json['code'] as String,
    label: json['label'] as String,
    startedAt: DateTime.parse(json['started_at'] as String),
    pausedAt: json['paused_at'] == null
        ? null
        : DateTime.parse(json['paused_at'] as String),
    pausedFor: Duration(seconds: json['paused_seconds'] as int? ?? 0),
  );

  final int activityTypeId;
  final String code;

  /// The item's name as the report showed it.
  final String label;
  final DateTime startedAt;

  /// Paused since then; null while it runs.
  final DateTime? pausedAt;

  /// The pauses before [pausedAt].
  final Duration pausedFor;

  bool get paused => pausedAt != null;

  /// The time counted at [now], pauses aside.
  Duration elapsedAt(DateTime now) {
    final end = pausedAt ?? now;
    final elapsed = end.difference(startedAt) - pausedFor;
    return elapsed.isNegative ? Duration.zero : elapsed;
  }

  /// The minutes it adds: rounded, 1 at least, a day at most.
  static int minutesOf(Duration elapsed) =>
      ((elapsed.inSeconds + 30) ~/ 60).clamp(1, 1440);

  Map<String, dynamic> toJson() => {
    'activity_type_id': activityTypeId,
    'code': code,
    'label': label,
    'started_at': startedAt.toIso8601String(),
    if (pausedAt != null) 'paused_at': pausedAt!.toIso8601String(),
    'paused_seconds': pausedFor.inSeconds,
  };
}

/// The one stopwatch that can run (key `report_timer`), null without one.
@Riverpod(keepAlive: true)
class ReportTimer extends _$ReportTimer {
  static const key = 'report_timer';

  @override
  RunningTimer? build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) {
      return null;
    }
    try {
      return RunningTimer.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  Future<void> _save(RunningTimer? timer) async {
    state = timer;
    final preferences = ref.read(sharedPreferencesProvider);
    if (timer == null) {
      await preferences.remove(key);
    } else {
      await preferences.setString(key, jsonEncode(timer.toJson()));
    }
  }

  /// Starts it for an item (another one running is replaced).
  Future<void> start({
    required int activityTypeId,
    required String code,
    required String label,
  }) => _save(
    RunningTimer(
      activityTypeId: activityTypeId,
      code: code,
      label: label,
      startedAt: DateTime.now(),
    ),
  );

  Future<void> pause() async {
    final timer = state;
    if (timer == null || timer.paused) {
      return;
    }
    await _save(
      RunningTimer(
        activityTypeId: timer.activityTypeId,
        code: timer.code,
        label: timer.label,
        startedAt: timer.startedAt,
        pausedAt: DateTime.now(),
        pausedFor: timer.pausedFor,
      ),
    );
  }

  Future<void> resume() async {
    final timer = state;
    final pausedAt = timer?.pausedAt;
    if (timer == null || pausedAt == null) {
      return;
    }
    await _save(
      RunningTimer(
        activityTypeId: timer.activityTypeId,
        code: timer.code,
        label: timer.label,
        startedAt: timer.startedAt,
        pausedFor: timer.pausedFor + DateTime.now().difference(pausedAt),
      ),
    );
  }

  /// Stops it and adds its minutes to the item, in the report of the day it
  /// started. The minutes added; null when the report has no such item (the
  /// stopwatch stops all the same).
  Future<int?> finish() async {
    final timer = state;
    if (timer == null) {
      return null;
    }
    final minutes = RunningTimer.minutesOf(timer.elapsedAt(DateTime.now()));
    await _save(null);
    final start = timer.startedAt;
    final added = await addMinutesToDayReport(
      ref,
      day: DateTime(start.year, start.month, start.day),
      activityTypeId: timer.activityTypeId,
      minutes: minutes,
    );
    return added ? minutes : null;
  }

  /// Stopped without counting anything.
  Future<void> discard() => _save(null);
}
