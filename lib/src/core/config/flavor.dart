import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flavor.g.dart';

enum Flavor { dev, prod }

/// Reads the flavor the app was built with (`flutter run --flavor dev`).
Flavor currentFlavor() {
  // --flavor is not supported on web: a web release build is always prod
  if (kIsWeb && kReleaseMode) {
    return Flavor.prod;
  }
  return switch (appFlavor) {
    'prod' => Flavor.prod,
    'dev' || null => Flavor.dev,
    _ => throw UnsupportedError('Unknown flavor: $appFlavor'),
  };
}

/// Overridden in bootstrap.dart with the real flavor.
@Riverpod(keepAlive: true)
Flavor flavor(Ref ref) =>
    throw UnimplementedError('flavorProvider must be overridden');
