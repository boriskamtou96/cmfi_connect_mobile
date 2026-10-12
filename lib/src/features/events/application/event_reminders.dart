import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../domain/event.dart';

part 'event_reminders.g.dart';

/// Payload of an event reminder: tapping it opens the event.
String eventPayload(int id) => 'event:$id';

/// The event a notification payload opens, or null.
int? eventIdOf(String? payload) =>
    payload != null && payload.startsWith('event:')
    ? int.tryParse(payload.substring('event:'.length))
    : null;

/// When to remind the user of an event they registered for: the evening
/// before at 19:00 (on the phone) and an hour before it starts. Only what is
/// still ahead of [now].
List<({DateTime at, bool dayBefore})> eventReminderTimes(
  CommunityEvent event, {
  required DateTime now,
}) {
  final start = event.startsAt.toLocal();
  final eve = DateTime(start.year, start.month, start.day - 1, 19);
  final hourBefore = start.subtract(const Duration(hours: 1));
  return [
    if (eve.isAfter(now) && eve.isBefore(hourBefore))
      (at: eve, dayBefore: true),
    if (hourBefore.isAfter(now)) (at: hourBefore, dayBefore: false),
  ];
}

/// Plans the reminders of the events the user registered for, on the phone
/// (no server push): replanned each time the upcoming events come back.
class EventReminders {
  const EventReminders(this._notifications);

  final LocalNotifications _notifications;

  Future<void> plan(List<CommunityEvent> upcoming, {DateTime? now}) async {
    final t = LocaleSettings.instance.currentTranslations;
    final at = now ?? DateTime.now();
    final planned = <PlannedNotification>[];
    for (final event in upcoming) {
      if (!event.registration.registered ||
          event.status != EventStatus.published) {
        continue;
      }
      for (final reminder in eventReminderTimes(event, now: at)) {
        planned.add((
          id: planned.length,
          at: reminder.at,
          title: reminder.dayBefore
              ? t.events.reminder.tomorrow(title: event.title)
              : t.events.reminder.soon(title: event.title),
          body: [
            event.venue,
            event.city,
          ].where((part) => part.isNotEmpty).join(' · '),
          payload: eventPayload(event.id),
        ));
      }
    }
    await _notifications.replace(
      NotificationGroup.events,
      planned,
      channelName: t.events.reminder.channel,
    );
  }
}

@Riverpod(keepAlive: true)
EventReminders eventReminders(Ref ref) =>
    EventReminders(ref.watch(localNotificationsProvider));
