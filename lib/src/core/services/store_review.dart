import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/preferences.dart';

part 'store_review.g.dart';

/// The rating sheet of the App Store / Google Play (in_app_review), and the
/// version of the app it is asked for. Behind a provider: tests use a fake,
/// and debug builds never ask.
abstract class StoreReview {
  /// "1.0.21": the version shown in the store.
  Future<String> appVersion();

  /// Shows the store's sheet, if the phone can (the store may still decide
  /// not to show it: it limits how often).
  Future<void> requestReview();
}

/// Debug builds and platforms without a store: never asks.
class NoStoreReview implements StoreReview {
  const NoStoreReview();

  @override
  Future<String> appVersion() async => '';

  @override
  Future<void> requestReview() async {}
}

class NativeStoreReview implements StoreReview {
  const NativeStoreReview();

  /// Answered by MainActivity.kt and AppDelegate.swift.
  static const _channel = MethodChannel('cmficonnect/app');

  @override
  Future<String> appVersion() async {
    try {
      return await _channel.invokeMethod<String>('version') ?? '';
    } on PlatformException {
      return '';
    } on MissingPluginException {
      return '';
    }
  }

  @override
  Future<void> requestReview() async {
    final review = InAppReview.instance;
    if (await review.isAvailable()) {
      await review.requestReview();
    }
  }
}

@Riverpod(keepAlive: true)
StoreReview storeReview(Ref ref) =>
    kDebugMode ||
        kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.iOS &&
            defaultTargetPlatform != TargetPlatform.android)
    ? const NoStoreReview()
    : const NativeStoreReview();

/// When to ask for a rating: at a happy moment chosen by the app (7 days in
/// a row), at most once per version of the app and never twice within
/// [minInterval]. The version and the day asked stay on the phone, whatever
/// the account.
class RatingPrompt {
  const RatingPrompt(this._review, this._preferences);

  final StoreReview _review;
  final SharedPreferences _preferences;

  static const versionKey = 'rating_asked_version';
  static const dateKey = 'rating_asked_on';
  static const minInterval = Duration(days: 120);

  /// Asks the store for its rating sheet when allowed; true when asked.
  Future<bool> maybeAsk({DateTime? now}) async {
    final version = await _review.appVersion();
    if (version.isEmpty || _preferences.getString(versionKey) == version) {
      return false;
    }
    final at = now ?? DateTime.now();
    final last = DateTime.tryParse(_preferences.getString(dateKey) ?? '');
    if (last != null && at.difference(last) < minInterval) {
      return false;
    }
    await _preferences.setString(versionKey, version);
    await _preferences.setString(dateKey, at.toIso8601String());
    try {
      await _review.requestReview();
    } on Object {
      // no store on this phone: nothing to show
    }
    return true;
  }
}

@Riverpod(keepAlive: true)
RatingPrompt ratingPrompt(Ref ref) => RatingPrompt(
  ref.watch(storeReviewProvider),
  ref.watch(sharedPreferencesProvider),
);
