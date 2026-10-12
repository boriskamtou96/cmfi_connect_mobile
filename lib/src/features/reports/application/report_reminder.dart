import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../infrastructure/reports_api.dart';
import '../infrastructure/reports_local_store.dart';

part 'report_reminder.freezed.dart';
part 'report_reminder.g.dart';

/// 8 p.m.: late enough to have lived the day, early enough to fill it in.
const defaultReminderTime = TimeOfDay(hour: 20, minute: 0);

/// The evening reminder to fill in the day.
@freezed
abstract class ReminderSettings with _$ReminderSettings {
  const factory ReminderSettings({
    @Default(false) bool enabled,
    @Default(defaultReminderTime) TimeOfDay time,

    /// The app already offered it once (after the first saved day).
    @Default(false) bool offered,
  }) = _ReminderSettings;
}

/// Times of the reminders to plan from [now]: one a day at [time] for [days]
/// days, without today when it's [todayDone] or already past.
List<DateTime> reminderTimes({
  required DateTime now,
  required TimeOfDay time,
  required bool todayDone,
  int days = ReportReminder.plannedDays,
}) => [
  for (var i = 0; i < days; i++)
    if (DateTime(now.year, now.month, now.day + i, time.hour, time.minute)
        case final at when !(i == 0 && (todayDone || !at.isAfter(now))))
      at,
];

/// The reminder's settings (kept on the phone) and its planning: the next
/// [plannedDays] evenings are planned at once and planned again each time
/// the app starts or a day is saved, so a filled day stays silent.
@Riverpod(keepAlive: true)
class ReportReminder extends _$ReportReminder {
  static const plannedDays = 14;
  static const _enabledKey = 'reminder_enabled';
  static const _timeKey = 'reminder_time';
  static const _offeredKey = 'reminder_offered';

  /// Payload of the reminder: opens the day's report when tapped.
  static const payload = 'report_today';

  @override
  ReminderSettings build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final minutes = preferences.getInt(_timeKey);
    return ReminderSettings(
      enabled: preferences.getBool(_enabledKey) ?? false,
      time: minutes == null
          ? defaultReminderTime
          : TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
      offered: preferences.getBool(_offeredKey) ?? false,
    );
  }

  /// Turns the reminder on. false when the phone refuses notifications.
  Future<bool> enable({TimeOfDay? time}) async {
    final granted = await ref
        .read(localNotificationsProvider)
        .requestPermission();
    await markOffered();
    if (!granted) {
      return false;
    }
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.setBool(_enabledKey, true);
    if (time != null) {
      await preferences.setInt(_timeKey, time.hour * 60 + time.minute);
    }
    state = state.copyWith(enabled: true, time: time ?? state.time);
    await reschedule();
    return true;
  }

  Future<void> disable() async {
    await ref.read(sharedPreferencesProvider).setBool(_enabledKey, false);
    state = state.copyWith(enabled: false);
    await ref
        .read(localNotificationsProvider)
        .cancel(NotificationGroup.reportReminder);
  }

  Future<void> setTime(TimeOfDay time) async {
    await ref
        .read(sharedPreferencesProvider)
        .setInt(_timeKey, time.hour * 60 + time.minute);
    state = state.copyWith(time: time);
    await reschedule();
  }

  Future<void> markOffered() async {
    if (state.offered) {
      return;
    }
    await ref.read(sharedPreferencesProvider).setBool(_offeredKey, true);
    state = state.copyWith(offered: true);
  }

  /// Plans the next evenings again. [todayDone] null: asks the server (or
  /// the days kept offline) whether today is already filled in.
  Future<void> reschedule({bool? todayDone}) async {
    final notifications = ref.read(localNotificationsProvider);
    if (!state.enabled) {
      return;
    }
    final done = todayDone ?? await _todayDone();
    final t = LocaleSettings.instance.currentTranslations;
    final times = reminderTimes(
      now: DateTime.now(),
      time: state.time,
      todayDone: done,
    );
    await notifications.replace(NotificationGroup.reportReminder, [
      for (final (i, at) in times.indexed)
        (
          id: i,
          at: at,
          title: t.reminder.title,
          body: t.reminder.body,
          payload: payload,
        ),
    ], channelName: t.reminder.channel);
  }

  /// Signing out: no reminder for an account that is gone (the events'
  /// ones neither).
  Future<void> cancelAll() => ref.read(localNotificationsProvider).cancelAll();

  Future<bool> _todayDone() async {
    final now = today();
    if (ref.read(reportsLocalStoreProvider).pending().containsKey(now)) {
      return true;
    }
    try {
      return (await ref.read(reportsApiProvider).getDay(now)).submitted;
    } on Object {
      // unknown: better a reminder too many than a forgotten day
      return false;
    }
  }
}
