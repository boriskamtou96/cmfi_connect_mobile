import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_log.dart';

part 'remote_flags.g.dart';

/// Switches turned on and off from the Firebase console (Remote Config),
/// without a new version of the app: `bible_semeur` (La Bible du Semeur read
/// in the app, see SemeurInApp). The rules of the updates have their own
/// reader (RemoteConfigUpdateRules) on the same Remote Config.
abstract class RemoteFlags {
  /// The value of [key] as the console last gave it, '' when it has none.
  Future<String> read(String key);

  /// Asks Firebase for the values again (at most as often as it allows).
  Future<void> refresh();

  /// The keys changed in the console while the app is open.
  Stream<Set<String>> get changes;
}

/// Without Firebase (tests, web): no value, the app's defaults.
class NoRemoteFlags implements RemoteFlags {
  const NoRemoteFlags();

  @override
  Future<String> read(String key) async => '';

  @override
  Future<void> refresh() async {}

  @override
  Stream<Set<String>> get changes => const Stream.empty();
}

class FirebaseRemoteFlags implements RemoteFlags {
  FirebaseRemoteFlags();

  FirebaseRemoteConfig get _config => FirebaseRemoteConfig.instance;

  // the values activated last time, read from the phone
  late final Future<void> _ready = _config.ensureInitialized();

  @override
  Future<String> read(String key) async {
    try {
      await _ready;
      return _config.getString(key).trim();
    } on Object catch (error) {
      AppLog.info('remote flag $key not read: $error');
      return '';
    }
  }

  @override
  Future<void> refresh() async {
    try {
      await _ready;
      await _config.fetchAndActivate();
    } on Object catch (error) {
      // offline, throttled: the values of last time stay
      AppLog.info('remote flags not fetched: $error');
    }
  }

  final _changes = StreamController<Set<String>>.broadcast();
  StreamSubscription<void>? _realTime;

  @override
  Stream<Set<String>> get changes {
    _realTime ??= _config.onConfigUpdated.listen(
      (update) async {
        await _config.activate();
        _changes.add(update.updatedKeys);
      },
      onError: (Object error) =>
          AppLog.info('remote flags not listened to: $error'),
    );
    return _changes.stream;
  }
}

@Riverpod(keepAlive: true)
RemoteFlags remoteFlags(Ref ref) {
  try {
    if (kIsWeb || Firebase.apps.isEmpty) {
      return const NoRemoteFlags();
    }
  } on Object {
    return const NoRemoteFlags();
  }
  return FirebaseRemoteFlags();
}

/// A switch of the console: "on" / "true" is on, "off" / "false" is off,
/// anything else (no value) leaves [fallback].
bool remoteSwitch(String value, {required bool fallback}) =>
    switch (value.toLowerCase()) {
      'on' || 'true' || '1' => true,
      'off' || 'false' || '0' => false,
      _ => fallback,
    };
