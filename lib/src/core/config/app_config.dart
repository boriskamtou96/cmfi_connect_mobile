import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flavor.dart';

part 'app_config.g.dart';

class AppConfig {
  const AppConfig({required this.apiBaseUrl});

  /// flutter run --flavor dev --dart-define=API_BASE_URL=http://192.168.100.2:8080/v1
  static const _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

  static const siteUrl = 'https://cmfi-connect.com';

  // La Bible du Semeur in the app, through the YouVersion Platform (Biblica's
  // channel), once Biblica's licence covers the app: the app key of the
  // platform and the switch in .env (YOUVERSION_APP_KEY, BIBLE_SEMEUR=on).
  // Without them it stays read on Bibleserver.
  static const youversionAppKey = String.fromEnvironment('YOUVERSION_APP_KEY');
  static const semeurInApp =
      youversionAppKey != '' && String.fromEnvironment('BIBLE_SEMEUR') == 'on';

  // Premium is bought on the website (cmfi-connect.com/premium, mobile money
  // through Wajub): the paywall says so and opens the site. PREMIUM_ON_SITE=off
  // in .env takes the link out (a build sent to a store review that refuses
  // it): the paywall then says Premium comes soon.
  static const premiumOnSite =
      String.fromEnvironment('PREMIUM_ON_SITE', defaultValue: 'on') != 'off';

  factory AppConfig.forFlavor(Flavor flavor) {
    if (_apiBaseUrlOverride.isNotEmpty) {
      return const AppConfig(apiBaseUrl: _apiBaseUrlOverride);
    }

    return switch (flavor) {
      Flavor.dev => AppConfig(
        apiBaseUrl: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? 'http://10.0.2.2:8080/v1'
            : 'http://localhost:8080/v1',
      ),
      // the server on Render, behind our domain (the onrender.com address
      // stays for the versions already installed)
      Flavor.prod => const AppConfig(
        apiBaseUrl: 'https://api.cmfi-connect.com/v1',
      ),
    };
  }

  final String apiBaseUrl;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => AppConfig.forFlavor(ref.watch(flavorProvider));
