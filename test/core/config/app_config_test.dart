import 'package:cmfi_connect/src/core/config/app_config.dart';
import 'package:cmfi_connect/src/core/config/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

String _key(
  Flavor flavor, {
  TargetPlatform platform = TargetPlatform.iOS,
  bool release = false,
  String test = 'test_key',
}) => AppConfig.revenueCatKeyOf(
  flavor,
  platform: platform,
  release: release,
  test: test,
  apple: 'appl_key',
  google: 'goog_key',
);

void main() {
  test('the dev app sells through the Test Store while developing', () {
    expect(_key(Flavor.dev), 'test_key');
  });

  test('a release build of the dev app sells nothing: RevenueCat stops any '
      'release build that uses the Test Store key (TestFlight)', () {
    expect(_key(Flavor.dev, release: true), '');
    expect(
      _key(Flavor.dev, release: true, platform: TargetPlatform.android),
      '',
    );
  });

  test('the published app sells through its store', () {
    expect(_key(Flavor.prod, release: true), 'appl_key');
    expect(
      _key(Flavor.prod, release: true, platform: TargetPlatform.android),
      'goog_key',
    );
  });

  test('the dev app without a Test Store key uses the store, as before', () {
    expect(_key(Flavor.dev, test: ''), 'appl_key');
  });
}
