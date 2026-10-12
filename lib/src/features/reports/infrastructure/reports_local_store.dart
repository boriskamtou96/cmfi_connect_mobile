import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/activity_type.dart';
import '../domain/daily_report.dart';

part 'reports_local_store.g.dart';

/// What the reports keep on the phone, to fill in a day without network:
/// the items, the last days opened, and the days saved while offline that
/// still have to be sent.
class ReportsLocalStore {
  const ReportsLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _activitiesKey = 'reports_activities';
  static const _daysKey = 'reports_days';
  static const _pendingKey = 'reports_pending';

  /// Days opened recently, kept to show them offline.
  static const keptDays = 31;

  List<ActivityType>? activities() {
    final raw = _preferences.getString(_activitiesKey);
    if (raw == null) {
      return null;
    }
    return [
      for (final json in jsonDecode(raw) as List<dynamic>)
        ActivityType.fromJson(json as Map<String, dynamic>),
    ];
  }

  Future<void> saveActivities(List<ActivityType> activities) =>
      _preferences.setString(_activitiesKey, jsonEncode(activities));

  DailyReport? day(DateTime date) => _read(_daysKey)[date.dateOnly];

  /// Days of the cache between [from] and [to] that have a report.
  List<DailyReport> daysBetween(DateTime from, DateTime to) => [
    for (final day in _read(_daysKey).values)
      if (day.submitted && !day.date.isBefore(from) && !day.date.isAfter(to))
        day,
  ];

  /// Keeps [day] for later, and forgets the oldest days past [keptDays].
  Future<void> saveDay(DailyReport day) async {
    final days = _read(_daysKey)..[day.date.dateOnly] = day;
    final newest = days.keys.toList()..sort((a, b) => b.compareTo(a));
    for (final old in newest.skip(keptDays)) {
      days.remove(old);
    }
    await _write(_daysKey, days);
  }

  /// Days saved without network, by date.
  Map<DateTime, DailyReport> pending() => _read(_pendingKey);

  Future<void> addPending(DailyReport day) =>
      _write(_pendingKey, pending()..[day.date.dateOnly] = day);

  Future<void> removePending(DateTime date) =>
      _write(_pendingKey, pending()..remove(date.dateOnly));

  /// Signing out: nothing of this account stays on the phone.
  Future<void> clear() async {
    await _preferences.remove(_activitiesKey);
    await _preferences.remove(_daysKey);
    await _preferences.remove(_pendingKey);
  }

  Map<DateTime, DailyReport> _read(String key) {
    final raw = _preferences.getString(key);
    if (raw == null) {
      return {};
    }
    return {
      for (final json in jsonDecode(raw) as List<dynamic>)
        if (DailyReport.fromJson(json as Map<String, dynamic>) case final day)
          day.date: day,
    };
  }

  Future<void> _write(String key, Map<DateTime, DailyReport> days) =>
      _preferences.setString(key, jsonEncode(days.values.toList()));
}

@Riverpod(keepAlive: true)
ReportsLocalStore reportsLocalStore(Ref ref) =>
    ReportsLocalStore(ref.watch(sharedPreferencesProvider));
