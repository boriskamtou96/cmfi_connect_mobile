import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/stopwatch_clock.dart';
import 'local_notifications.dart';

part 'lock_screen_timer.g.dart';

/// The texts around the stopwatch, in the language of the app.
typedef LockScreenTexts = ({String paused, String hint, String channel});

/// The stopwatch of the report outside the app, without opening it: an
/// Activité en direct on the lock screen and in the Dynamic Island of the
/// iPhone (iOS 16.1, ios/Runner/StopwatchActivities.swift), a fixed
/// notification with the time running on Android. A touch opens today's
/// report.
abstract class LockScreenTimer {
  /// Shows the stopwatch of [label], or brings it up to date: the time runs
  /// from [since] (its start, pauses aside), or stays at [paused] while
  /// paused.
  Future<void> show({
    required String label,
    required DateTime since,
    required LockScreenTexts texts,
    Duration? paused,
  });

  Future<void> hide();
}

class DeviceLockScreenTimer implements LockScreenTimer {
  DeviceLockScreenTimer(this._notifications);

  final LocalNotifications _notifications;
  static const _channel = MethodChannel('cmficonnect/stopwatch');

  // Android 13 asks for the notifications once
  var _asked = false;

  @override
  Future<void> show({
    required String label,
    required DateTime since,
    required LockScreenTexts texts,
    Duration? paused,
  }) async {
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          await _channel.invokeMethod<void>('show', {
            'label': label,
            'since': since.millisecondsSinceEpoch.toDouble(),
            'pausedSeconds': paused?.inSeconds,
            'pausedText': texts.paused,
          });
        case TargetPlatform.android:
          if (!_asked) {
            _asked = true;
            await _notifications.requestPermission();
          }
          await _notifications.showStopwatch(
            title: label,
            body: paused == null
                ? texts.hint
                : '${stopwatchClock(paused)} · ${texts.paused}',
            since: since,
            running: paused == null,
            channelName: texts.channel,
          );
        default:
          return;
      }
    } on Object {
      // before iOS 16.1, Activités en direct turned off, notifications
      // refused: the stopwatch stays in the app
    }
  }

  @override
  Future<void> hide() async {
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          await _channel.invokeMethod<void>('hide');
        case TargetPlatform.android:
          await _notifications.hideStopwatch();
        default:
          return;
      }
    } on Object {
      // nothing was shown
    }
  }
}

@Riverpod(keepAlive: true)
LockScreenTimer lockScreenTimer(Ref ref) =>
    DeviceLockScreenTimer(ref.watch(localNotificationsProvider));
