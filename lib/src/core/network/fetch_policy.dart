import 'dart:async';

import 'app_exception.dart';

/// Where a screen takes its data from: the copy kept on the phone, the
/// server, or both.
enum FetchPolicy {
  /// The copy on the phone at once, then the server's answer when it comes
  /// (kept on the phone for next time). Without a copy: the server. The
  /// screens open instantly, even offline.
  cacheAndNetwork,

  /// The server; its last answer kept on the phone when there is no network.
  networkPreferably,

  /// The copy on the phone; the server only when there is none.
  cachePreferably,

  /// The server only (pulled down to refresh), its answer kept on the phone.
  networkOnly,
}

/// Loads a value by [policy]: [cached] reads the copy on the phone (null
/// when there is none), [network] asks the server, [save] keeps its answer.
///
/// Returns the value to show first. With [FetchPolicy.cacheAndNetwork] and a
/// copy, the server is asked after, and [onFresh] gets its answer; when it
/// fails (no network…), the copy stays, and [onFailed] is told (a screen
/// that can't use the copy offline shows its own way instead).
Future<T> fetchWithPolicy<T>({
  required FetchPolicy policy,
  required T? Function() cached,
  required Future<T> Function() network,
  required Future<void> Function(T value) save,
  void Function(T fresh)? onFresh,
  void Function(Object error, StackTrace stack)? onFailed,
}) async {
  Future<T> fromNetwork() async {
    final value = await network();
    await save(value);
    return value;
  }

  switch (policy) {
    case FetchPolicy.networkOnly:
      return fromNetwork();
    case FetchPolicy.cachePreferably:
      return cached() ?? await fromNetwork();
    case FetchPolicy.networkPreferably:
      try {
        return await fromNetwork();
      } on NetworkException {
        final copy = cached();
        if (copy == null) {
          rethrow;
        }
        return copy;
      }
    case FetchPolicy.cacheAndNetwork:
      final copy = cached();
      if (copy == null) {
        return fromNetwork();
      }
      // the server after the copy is shown: an answer that came before
      // would be covered by the copy
      unawaited(
        Future(fromNetwork).then(
          (fresh) => onFresh?.call(fresh),
          // the copy is shown: a failed refresh only tells [onFailed]
          onError: (Object error, StackTrace stack) =>
              onFailed?.call(error, stack),
        ),
      );
      return copy;
  }
}
