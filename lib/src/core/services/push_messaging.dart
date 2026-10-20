import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_messaging.g.dart';

/// A push received while the app is open (iOS shows it then too, Android
/// doesn't: the app does).
typedef PushMessage = ({String title, String body, Map<String, String> data});

/// The notifications sent by the server (Firebase Cloud Messaging). Behind a
/// provider so tests replace it; without Firebase (web, desktop, a failed
/// start) nothing arrives and nothing breaks.
abstract class PushMessaging {
  /// Asks the system for the right to notify (a prompt the first time only).
  /// false when refused.
  Future<bool> requestPermission();

  /// The address of this phone for the server, null when unknown yet (no
  /// network, no Apple push token on a simulator…).
  Future<String?> token();

  /// A new address replaces the old one.
  Stream<String> get tokenRefreshes;

  /// The data of the push that opened the app, if one did. Given once.
  Future<Map<String, String>?> takeLaunchData();

  /// The data of the pushes touched while the app was in the background.
  Stream<Map<String, String>> get taps;

  /// The pushes that arrive while the app is open.
  Stream<PushMessage> get received;

  /// "android" or "ios", as the server stores it.
  String get platform;
}

class NoPushMessaging implements PushMessaging {
  const NoPushMessaging();

  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<String?> token() async => null;

  @override
  Stream<String> get tokenRefreshes => const Stream.empty();

  @override
  Future<Map<String, String>?> takeLaunchData() async => null;

  @override
  Stream<Map<String, String>> get taps => const Stream.empty();

  @override
  Stream<PushMessage> get received => const Stream.empty();

  @override
  String get platform => _platform();
}

class FirebasePushMessaging implements PushMessaging {
  FirebasePushMessaging() {
    // iOS: the pushes show also while the app is open (Android: shown by
    // the app, SignedInTasks)
    unawaited(
      _messaging
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          )
          .catchError((Object _) {}),
    );
  }

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;
  var _launchTaken = false;

  @override
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  @override
  Future<String?> token() async {
    try {
      // iOS gives the Firebase token once Apple gave its own
      if (defaultTargetPlatform == TargetPlatform.iOS &&
          await _messaging.getAPNSToken() == null) {
        return null;
      }
      return await _messaging.getToken();
    } on Object {
      return null;
    }
  }

  @override
  Stream<String> get tokenRefreshes => _messaging.onTokenRefresh;

  @override
  Future<Map<String, String>?> takeLaunchData() async {
    if (_launchTaken) {
      return null;
    }
    _launchTaken = true;
    final message = await _messaging.getInitialMessage();
    return message == null ? null : _strings(message.data);
  }

  @override
  Stream<Map<String, String>> get taps => FirebaseMessaging.onMessageOpenedApp
      .map((message) => _strings(message.data));

  @override
  Stream<PushMessage> get received => FirebaseMessaging.onMessage.map(
    (message) => (
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      data: _strings(message.data),
    ),
  );

  @override
  String get platform => _platform();

  static Map<String, String> _strings(Map<String, dynamic> data) => {
    for (final MapEntry(:key, :value) in data.entries) key: '$value',
  };
}

String _platform() =>
    defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';

/// Firebase started in bootstrap.dart (firebase_options.dart), or not.
@Riverpod(keepAlive: true)
PushMessaging pushMessaging(Ref ref) =>
    Firebase.apps.isEmpty ? const NoPushMessaging() : FirebasePushMessaging();
