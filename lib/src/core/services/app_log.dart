import 'package:flutter/foundation.dart';

import 'crash_reporting.dart';

/// The log of the app: the steps it went through and the errors it lived
/// with. In debug, the console (`[cmfi] …`); in the published app,
/// Crashlytics (bootstrap.dart sets [reporter] once Firebase started): each
/// error with its reason, and the trail of steps before it.
///
/// Never a name, a phone number, a password, a token nor the text of a
/// report: routes, codes, numbers of things, request ids.
abstract final class AppLog {
  static CrashReporting reporter = const NoCrashReporting();

  /// A step worth knowing when something goes wrong later.
  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[cmfi] $message');
    }
    reporter.log(message);
  }

  /// An error caught and lived with: [reason] says where and what it cost
  /// ("report of 2026-10-15 refused: dropped").
  static void error(Object error, StackTrace? stack, {required String reason}) {
    if (kDebugMode) {
      debugPrint('[cmfi] $reason: $error');
    }
    reporter.record(error, stack, reason: reason);
  }
}
