import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flavor.dart';

part 'app_config.g.dart';

class AppConfig {
  const AppConfig({required this.apiBaseUrl});

  /// Overrides the URL without touching the code, e.g. to test on a real phone:
  /// flutter run --flavor dev --dart-define=API_BASE_URL=http://192.168.1.20:8080/v1
  static const _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

  factory AppConfig.forFlavor(Flavor flavor) {
    if (_apiBaseUrlOverride.isNotEmpty) {
      return const AppConfig(apiBaseUrl: _apiBaseUrlOverride);
    }

    return switch (flavor) {
      // On the Android emulator, 10.0.2.2 is the Mac's localhost
      Flavor.dev => AppConfig(
        apiBaseUrl: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? 'http://10.0.2.2:8080/v1'
            : 'http://localhost:8080/v1', // if running on real device, use the local IP address http://192.168.100.3:8080/v1
      ),
      // TODO(cmfi): set the production API URL once it is deployed
      Flavor.prod => const AppConfig(
        apiBaseUrl: 'https://api.cmfi-connect.example/v1',
      ),
    };
  }

  final String apiBaseUrl;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => AppConfig.forFlavor(ref.watch(flavorProvider));
