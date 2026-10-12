import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/prayer.dart';
import 'retreats.dart';

part 'retreat_reminders.g.dart';

/// The usual hour of each retreat, proposed when its reminder is turned on.
const defaultRetreatTimes = {
  RetreatMoment.morning: TimeOfDay(hour: 6, minute: 0),
  RetreatMoment.noon: TimeOfDay(hour: 12, minute: 30),
  RetreatMoment.evening: TimeOfDay(hour: 18, minute: 0),
  RetreatMoment.night: TimeOfDay(hour: 22, minute: 0),
};

/// Payload of a retreat reminder: tapping it opens that retreat.
String retreatPayload(RetreatMoment moment) => 'retreat:${moment.name}';

/// The retreat a notification payload opens, or null.
RetreatMoment? retreatOf(String? payload) =>
    payload != null && payload.startsWith('retreat:')
    ? RetreatMoment.values.asNameMap()[payload.substring('retreat:'.length)]
    : null;

/// The reminders of the retreats: a time per retreat, or none (off). Kept on
/// the phone; the next [plannedDays] days are planned at once, without the
/// retreats already made today.
@Riverpod(keepAlive: true)
class RetreatReminders extends _$RetreatReminders {
  static const plannedDays = 7;
  static const _key = 'retreat_reminder_';

  @override
  Map<RetreatMoment, TimeOfDay?> build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    return {
      for (final moment in RetreatMoment.values)
        moment: switch (preferences.getInt('$_key${moment.name}')) {
          final minutes? => TimeOfDay(
            hour: minutes ~/ 60,
            minute: minutes % 60,
          ),
          null => null,
        },
    };
  }

  bool get _anyOn => state.values.any((time) => time != null);

  /// Turns the reminder of [moment] on at [time]. false when the phone
  /// refuses notifications.
  Future<bool> set(RetreatMoment moment, TimeOfDay time) async {
    final granted = await ref
        .read(localNotificationsProvider)
        .requestPermission();
    if (!granted) {
      return false;
    }
    await ref
        .read(sharedPreferencesProvider)
        .setInt('$_key${moment.name}', time.hour * 60 + time.minute);
    state = {...state, moment: time};
    await reschedule();
    return true;
  }

  Future<void> turnOff(RetreatMoment moment) async {
    await ref.read(sharedPreferencesProvider).remove('$_key${moment.name}');
    state = {...state, moment: null};
    await reschedule();
  }

  /// Plans the next days again (a retreat made today stays silent).
  Future<void> reschedule() async {
    final notifications = ref.read(localNotificationsProvider);
    if (!_anyOn) {
      await notifications.cancel(NotificationGroup.prayer);
      return;
    }
    final done = ref.read(retreatsTodayProvider);
    final t = LocaleSettings.instance.currentTranslations;
    final now = DateTime.now();
    final planned = <PlannedNotification>[];
    for (var day = 0; day < plannedDays; day++) {
      for (final moment in RetreatMoment.values) {
        final time = state[moment];
        if (time == null) {
          continue;
        }
        final at = DateTime(
          now.year,
          now.month,
          now.day + day,
          time.hour,
          time.minute,
        );
        if (!at.isAfter(now) ||
            day == 0 && done.contains(moment) && at.isSameDay(now)) {
          continue;
        }
        planned.add((
          id: planned.length,
          at: at,
          title: t.prayer.retreatOf[moment.name]!,
          body: t.prayer.reminders.body,
          payload: retreatPayload(moment),
        ));
      }
    }
    await notifications.replace(
      NotificationGroup.prayer,
      planned,
      channelName: t.prayer.reminders.channel,
    );
  }
}
