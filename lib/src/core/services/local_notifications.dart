import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../theme/app_colors.dart';

part 'local_notifications.g.dart';

/// A notification planned on the phone itself (no server push).
typedef PlannedNotification = ({
  int id,
  DateTime at,
  String title,
  String body,
  String? payload,
});

/// Notifications planned by the app (the evening reminder). Behind a provider
/// so tests replace it.
class LocalNotifications {
  LocalNotifications();

  final _plugin = FlutterLocalNotificationsPlugin();
  final _taps = StreamController<String?>.broadcast();
  Future<void>? _ready;
  var _launchTaken = false;

  /// Payloads of the notifications tapped while the app runs.
  Stream<String?> get taps => _taps.stream;

  Future<void> _init() => _ready ??= () async {
    tz.initializeTimeZones();
    try {
      final zone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(zone.identifier));
    } on Object {
      // unknown zone name: UTC, the offsets below still come from DateTime
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
        // asked when the user turns the reminder on, not at launch
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) =>
          _taps.add(response.payload),
    );
  }();

  /// Asks the system for the right to notify. false when refused.
  Future<bool> requestPermission() async {
    await _init();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, sound: true) ?? false;
    }
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await android?.requestNotificationsPermission() ?? true;
  }

  /// Payload of the notification that opened the app, if one did. Given
  /// once: signing out and in again doesn't replay it.
  Future<String?> takeLaunchPayload() async {
    await _init();
    if (_launchTaken) {
      return null;
    }
    _launchTaken = true;
    final details = await _plugin.getNotificationAppLaunchDetails();
    return details?.didNotificationLaunchApp ?? false
        ? details?.notificationResponse?.payload
        : null;
  }

  /// Replaces the planned notifications of [group] with [notifications]
  /// (their ids count from 0 within the group); the other groups stay.
  Future<void> replace(
    NotificationGroup group,
    List<PlannedNotification> notifications, {
    required String channelName,
  }) async {
    await cancel(group);
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        group.channelId,
        channelName,
        color: AppColors.primary,
      ),
      iOS: const DarwinNotificationDetails(),
    );
    for (final notification in notifications.take(NotificationGroup.size)) {
      await _plugin.zonedSchedule(
        id: group.firstId + notification.id,
        scheduledDate: tz.TZDateTime.from(notification.at, tz.local),
        notificationDetails: details,
        // a few minutes late is fine for a reminder, and needs no permission
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
      );
    }
  }

  Future<void> cancel(NotificationGroup group) async {
    await _init();
    for (final pending in await _plugin.pendingNotificationRequests()) {
      if (group.owns(pending.id)) {
        await _plugin.cancel(id: pending.id);
      }
    }
  }

  /// The Android channel of the pushes of the server ([channelId] is the
  /// one the server sends), so the user can mute it in the settings.
  /// The id of the stopwatch's notification, outside the groups.
  static const stopwatchId = 90000;

  /// The stopwatch of the report as a fixed notification (Android): [title]
  /// the item, the time running from [since] (drawn by the system, the app
  /// closed), or [body] alone while paused. A touch opens today's report.
  Future<void> showStopwatch({
    required String title,
    required String body,
    required DateTime since,
    required bool running,
    required String channelName,
  }) async {
    await _init();
    await _plugin.show(
      id: stopwatchId,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'stopwatch',
          channelName,
          importance: Importance.low,
          priority: Priority.low,
          category: AndroidNotificationCategory.stopwatch,
          color: AppColors.primary,
          ongoing: true,
          autoCancel: false,
          onlyAlertOnce: true,
          silent: true,
          showWhen: running,
          usesChronometer: running,
          when: running ? since.millisecondsSinceEpoch : null,
        ),
      ),
      payload: 'report_today',
    );
  }

  Future<void> hideStopwatch() async {
    await _init();
    await _plugin.cancel(id: stopwatchId);
  }

  Future<void> createPushChannel(String channelId, String name) async {
    await _init();
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            channelId,
            name,
            importance: Importance.high,
          ),
        );
  }

  Future<void> cancelAll() async {
    await _init();
    await _plugin.cancelAll();
  }
}

/// Notifications replaced together, each with its own ids and Android channel.
enum NotificationGroup {
  /// The evening reminder to fill in the report.
  reportReminder(firstId: 1, channelId: 'report_reminder'),

  /// The day before and an hour before the events the user registered for.
  events(firstId: 1000, channelId: 'events'),

  /// The reminders of the 15-minute prayer retreats.
  prayer(firstId: 2000, channelId: 'prayer'),

  /// The report ready to be sent to the authorities.
  reportSending(firstId: 3000, channelId: 'report_sending'),

  /// "Ta semaine avec Dieu", every Sunday evening.
  weekStory(firstId: 4000, channelId: 'week_story'),

  /// The reading of the day of the Bible reading plan.
  biblePlan(firstId: 5000, channelId: 'bible_plan'),

  /// The verses to review (Mémorisation).
  memory(firstId: 6000, channelId: 'memory'),

  /// The people to contact again (Suivi des âmes): no name in them.
  souls(firstId: 7000, channelId: 'souls'),

  /// The daily prayer for a soul (Suivi des âmes): no name either.
  soulsPrayer(firstId: 8000, channelId: 'souls_prayer'),

  /// The end of each fasting day and of the fast (Mes jeûnes).
  fasts(firstId: 9000, channelId: 'fasts'),

  /// "Ton année avec Dieu", on 31 December in the evening.
  yearStory(firstId: 10000, channelId: 'year_story');

  const NotificationGroup({required this.firstId, required this.channelId});

  /// Ids per group: plenty for two weeks of evenings or a few events.
  static const size = 900;

  final int firstId;
  final String channelId;

  bool owns(int id) => id >= firstId && id < firstId + size;
}

@Riverpod(keepAlive: true)
LocalNotifications localNotifications(Ref ref) => LocalNotifications();
