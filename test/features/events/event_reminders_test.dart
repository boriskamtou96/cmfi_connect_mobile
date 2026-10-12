import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/utils/zoned_time.dart';
import 'package:cmfi_connect/src/features/events/application/event_reminders.dart';
import 'package:cmfi_connect/src/features/events/domain/event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  final now = DateTime(2026, 10, 9, 22);
  final event = sampleEvents(now: now).next;

  test('the evening before at 19:00, and an hour before', () {
    final times = eventReminderTimes(event, now: now);

    expect(times.map((time) => time.at), [
      DateTime(2026, 11, 19, 19),
      DateTime(2026, 11, 20, 7),
    ]);
  });

  test('only what is still ahead', () {
    final times = eventReminderTimes(event, now: DateTime(2026, 11, 19, 20));

    expect(times.map((time) => time.at), [DateTime(2026, 11, 20, 7)]);
  });

  test('only the events the user registered for', () async {
    final notifications = FakeLocalNotifications();
    final registered = event.copyWith(
      id: 7,
      registration: event.registration.copyWith(registered: true),
    );

    await EventReminders(notifications).plan([event, registered], now: now);

    expect(notifications.plannedEvents, hasLength(2));
    expect(
      notifications.plannedEvents.first.title,
      'Demain : Conférence annuelle 2026',
    );
    expect(notifications.plannedEvents.last.title, contains('Dans 1 h'));
    expect(notifications.plannedEvents.first.payload, 'event:7');
    expect(eventIdOf('event:7'), 7);
    expect(eventIdOf('report_today'), isNull);
  });

  test('a cancelled event is not reminded', () async {
    final notifications = FakeLocalNotifications();
    final cancelled = event.copyWith(
      status: EventStatus.cancelled,
      registration: event.registration.copyWith(registered: true),
    );

    await EventReminders(notifications).plan([cancelled], now: now);

    expect(notifications.plannedEvents, isEmpty);
  });

  test("the evening reminder and the events' ones are kept apart", () async {
    final notifications = FakeLocalNotifications();
    await notifications.replace(NotificationGroup.reportReminder, [
      (id: 0, at: now, title: 'soir', body: '', payload: null),
    ], channelName: '');

    await EventReminders(notifications).plan([
      event.copyWith(
        registration: event.registration.copyWith(registered: true),
      ),
    ], now: now);

    expect(notifications.planned, hasLength(1));
    expect(notifications.plannedEvents, hasLength(2));
  });

  test('times are read on the clocks of the venue', () {
    final instant = DateTime.utc(2026, 11, 20, 7);

    expect(instant.inZone('Africa/Douala').hour, 8);
    expect(instant.inZone('Europe/Paris').hour, 8);
    expect(instant.inZone('America/Montreal').hour, 2);
    expect(
      instantAt('Africa/Douala', DateTime(2026, 11, 20, 8)),
      DateTime.utc(2026, 11, 20, 7),
    );
  });
}
