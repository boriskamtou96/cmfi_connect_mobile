import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/services/app_log.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/services/push_messaging.dart';
import '../infrastructure/notifications_api.dart';

part 'push_registration.g.dart';

/// Gives the server the address of this phone, so the notifications of the
/// admins reach it as a push: at sign-in, and when Firebase changes it.
/// Stopped before signing out.
@Riverpod(keepAlive: true)
class PushRegistration extends _$PushRegistration {
  /// The Android channel the server sends to (internal/push).
  static const channelId = 'announcements';

  StreamSubscription<String>? _refreshes;
  String? _token;

  @override
  void build() {
    ref.onDispose(() => _refreshes?.cancel());
  }

  /// Asks the right to notify (the system prompt shows once), then sends the
  /// address. Without the right, nothing is sent: the notifications stay in
  /// the app.
  Future<void> start() async {
    final push = ref.read(pushMessagingProvider);
    await ref
        .read(localNotificationsProvider)
        .createPushChannel(
          channelId,
          LocaleSettings.instance.currentTranslations.notifications.channel,
        );
    if (!await push.requestPermission()) {
      return;
    }
    _refreshes ??= push.tokenRefreshes.listen(_send);
    if (await push.token() case final token?) {
      await _send(token);
    }
  }

  Future<void> _send(String token) async {
    _token = token;
    try {
      await ref
          .read(notificationsApiProvider)
          .registerDevice(
            token: token,
            platform: ref.read(pushMessagingProvider).platform,
            language: LocaleSettings.currentLocale.languageCode,
          );
    } on Object catch (error, stack) {
      // no network: sent again at the next start
      if (error is! NetworkException) {
        AppLog.error(error, stack, reason: 'push: phone not registered');
      }
    }
  }

  /// Before signing out: this phone stops receiving the account's pushes.
  Future<void> stop() async {
    unawaited(_refreshes?.cancel());
    _refreshes = null;
    final token = _token ?? await ref.read(pushMessagingProvider).token();
    _token = null;
    if (token == null) {
      return;
    }
    try {
      await ref.read(notificationsApiProvider).unregisterDevice(token);
    } on Object catch (error) {
      // the next account signed in on this phone takes the address anyway
      AppLog.info('push: phone not unregistered ($error)');
    }
  }
}
