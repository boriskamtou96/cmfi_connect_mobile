import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flavor.dart';

part 'app_config.g.dart';

class AppConfig {
  const AppConfig({required this.apiBaseUrl, this.revenueCatKey = ''});

  /// flutter run --flavor dev --dart-define=API_BASE_URL=http://192.168.100.2:8080/v1
  static const _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

  // The public RevenueCat keys, from .env:
  // flutter run --flavor dev --dart-define-from-file=.env
  static const _revenueCatTestKey = String.fromEnvironment(
    'REVENUE_CAT_TEST_API_KEY',
  );
  static const _revenueCatAppleKey = String.fromEnvironment(
    'REVENUE_CAT_APPLE_API_KEY',
  );
  static const _revenueCatGoogleKey = String.fromEnvironment(
    'REVENUE_CAT_GOOGLE_API_KEY',
  );

  /// The site of the app: terms and privacy, linked from the Premium page.
  // TODO(cmfi): check once the site is online
  static const siteUrl = 'https://cmfi-connect.com';

  factory AppConfig.forFlavor(Flavor flavor) {
    final revenueCatKey = _revenueCatKeyFor(flavor);
    if (_apiBaseUrlOverride.isNotEmpty) {
      return AppConfig(
        apiBaseUrl: _apiBaseUrlOverride,
        revenueCatKey: revenueCatKey,
      );
    }

    return switch (flavor) {
      Flavor.dev => AppConfig(
        apiBaseUrl: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? 'http://10.0.2.2:8080/v1'
            : 'http://localhost:8080/v1',
        revenueCatKey: revenueCatKey,
      ),
      // TODO(cmfi): set the production API URL once it is deployed
      Flavor.prod => AppConfig(
        apiBaseUrl: 'https://cmfi-connect-backend-dev.onrender.com/v1',
        revenueCatKey: revenueCatKey,
      ),
    };
  }

  /// dev: the RevenueCat Test Store (no real payment) when its key is
  /// given; prod: the App Store or Google Play. '' turns Premium off.
  static String _revenueCatKeyFor(Flavor flavor) {
    if (kIsWeb) {
      return '';
    }
    if (flavor == Flavor.dev && _revenueCatTestKey.isNotEmpty) {
      return _revenueCatTestKey;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => _revenueCatAppleKey,
      TargetPlatform.android => _revenueCatGoogleKey,
      _ => '',
    };
  }

  final String apiBaseUrl;

  /// The public RevenueCat key of this flavor and platform; '' without one.
  final String revenueCatKey;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => AppConfig.forFlavor(ref.watch(flavorProvider));
