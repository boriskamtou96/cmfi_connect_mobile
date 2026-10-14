import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../domain/report_sending.dart';

part 'report_sending.g.dart';

/// The regular sending of the report to the authorities, kept on the phone:
/// the next moments are planned as notifications (replanned at launch); a
/// tap opens the report ready to send ([sendingDayOf]).
@Riverpod(keepAlive: true)
class ReportSending extends _$ReportSending {
  static const _key = 'report_sending';
  static const plannedCount = 6;

  @override
  SendingSettings build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(_key);
    if (raw == null) {
      return const SendingSettings();
    }
    try {
      return SendingSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return const SendingSettings();
    }
  }

  /// Turns it on (after the notification permission). false when refused.
  Future<bool> enable() async {
    final granted = await ref
        .read(localNotificationsProvider)
        .requestPermission();
    if (!granted) {
      return false;
    }
    await save(state.copyWith(enabled: true));
    return true;
  }

  Future<void> disable() => save(state.copyWith(enabled: false));

  /// Every change replans the notifications. Every two weeks starts again
  /// from the next chosen day.
  Future<void> save(SendingSettings settings) async {
    final restart =
        settings.rhythm == SendingRhythm.biweekly &&
        (settings.anchor == null ||
            settings.weekday != state.weekday ||
            state.rhythm != SendingRhythm.biweekly);
    final next = restart
        ? settings.copyWith(
            anchor: firstWeekday(settings.weekday, now: DateTime.now()),
          )
        : settings;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, jsonEncode(next.toJson()));
    state = next;
    await reschedule();
  }

  /// Signing out: the next account starts without these settings (the
  /// notifications go with all the others).
  Future<void> forget() async {
    await ref.read(sharedPreferencesProvider).remove(_key);
    state = const SendingSettings();
  }

  Future<void> reschedule() async {
    final notifications = ref.read(localNotificationsProvider);
    if (!state.enabled) {
      await notifications.cancel(NotificationGroup.reportSending);
      return;
    }
    final t = LocaleSettings.instance.currentTranslations;
    await notifications.replace(NotificationGroup.reportSending, [
      for (final (i, at) in sendingTimes(
        state,
        now: DateTime.now(),
        count: plannedCount,
      ).indexed)
        (
          id: i,
          at: at,
          title: t.sending.notificationTitle,
          body: t.sending.notificationBody,
          payload: sendingPayload(at),
        ),
    ], channelName: t.sending.channel);
  }
}

/// The reports sent, the last first (the last 12, on the phone).
@Riverpod(keepAlive: true)
class SentReports extends _$SentReports {
  static const _key = 'report_sending_history';
  static const kept = 12;

  @override
  List<SentReport> build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(_key);
    if (raw == null) {
      return const [];
    }
    try {
      return [
        for (final item in jsonDecode(raw) as List)
          SentReport.fromJson(item as Map<String, dynamic>),
      ];
    } on Object {
      return const [];
    }
  }

  Future<void> forget() async {
    await ref.read(sharedPreferencesProvider).remove(_key);
    state = const [];
  }

  /// The same period sent again to someone else joins the same line.
  Future<void> add({
    required DateTime from,
    required DateTime to,
    required String name,
  }) async {
    final same = state
        .where((sent) => sent.from == from && sent.to == to)
        .firstOrNull;
    final entry = SentReport(
      at: DateTime.now(),
      from: from,
      to: to,
      names: [...?same?.names.where((other) => other != name), name],
    );
    final next = [
      entry,
      ...state.where((sent) => sent != same),
    ].take(kept).toList();
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, jsonEncode([for (final sent in next) sent.toJson()]));
    state = next;
  }
}
