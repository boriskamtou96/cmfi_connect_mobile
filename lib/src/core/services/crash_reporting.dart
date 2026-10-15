import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crash_reporting.g.dart';

/// The crashes of the app, sent to Firebase Crashlytics (not in debug: there
/// the console shows them). Behind a provider so tests replace it; without
/// Firebase (web, desktop, a failed start) nothing is sent.
abstract interface class CrashReporting {
  /// The account a crash happened in: its number only, never a name. null
  /// once signed out.
  Future<void> identify(String? userId);

  /// An error the app caught and lived with (not a crash): sent with
  /// [reason] and the trail of [log] lines.
  void record(Object error, StackTrace? stack, {required String reason});

  /// A step of the trail sent with the next error or crash.
  void log(String message);
}

class NoCrashReporting implements CrashReporting {
  const NoCrashReporting();

  @override
  Future<void> identify(String? userId) async {}

  @override
  void record(Object error, StackTrace? stack, {required String reason}) {}

  @override
  void log(String message) {}
}

class FirebaseCrashReporting implements CrashReporting {
  const FirebaseCrashReporting();

  @override
  Future<void> identify(String? userId) async {
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(userId ?? '');
    } on Object {
      // reporting crashes must never make one
    }
  }

  @override
  void record(Object error, StackTrace? stack, {required String reason}) {
    try {
      unawaited(
        FirebaseCrashlytics.instance.recordError(error, stack, reason: reason),
      );
    } on Object {
      // reporting errors must never make one
    }
  }

  @override
  void log(String message) {
    try {
      unawaited(FirebaseCrashlytics.instance.log(message));
    } on Object {
      // same
    }
  }
}

/// Catches what the app doesn't: errors of the framework and of the
/// asynchronous code. Called once Firebase started (bootstrap.dart).
Future<void> startCrashReporting() async {
  final crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  final previous = FlutterError.onError;
  FlutterError.onError = (details) {
    previous?.call(details);
    crashlytics.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    crashlytics.recordError(error, stack, fatal: true);
    return true;
  };
}

@Riverpod(keepAlive: true)
CrashReporting crashReporting(Ref ref) => Firebase.apps.isEmpty
    ? const NoCrashReporting()
    : const FirebaseCrashReporting();
