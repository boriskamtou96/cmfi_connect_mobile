import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/countries.dart';

part 'preferences.g.dart';

/// Overridden in bootstrap.dart with the loaded instance.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('sharedPreferencesProvider must be overridden');

/// Whether the presentation screens were already shown (first launch only).
@Riverpod(keepAlive: true)
class OnboardingSeen extends _$OnboardingSeen {
  static const _key = 'onboarding_seen';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> markSeen() async {
    await ref.read(sharedPreferencesProvider).setBool(_key, true);
    state = true;
  }
}

/// Language chosen in the app ("fr", "en"); null follows the phone.
@Riverpod(keepAlive: true)
class SavedLanguage extends _$SavedLanguage {
  static const key = 'language';

  @override
  String? build() => ref.watch(sharedPreferencesProvider).getString(key);

  Future<void> save(String languageCode) async {
    await ref.read(sharedPreferencesProvider).setString(key, languageCode);
    state = languageCode;
  }
}

/// Light or dark look, or the phone's own (the default).
@Riverpod(keepAlive: true)
class SavedThemeMode extends _$SavedThemeMode {
  static const key = 'theme_mode';

  @override
  ThemeMode build() {
    final saved = ref.watch(sharedPreferencesProvider).getString(key);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  Future<void> save(ThemeMode mode) async {
    // the app changes at once, the write follows
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(key, mode.name);
  }
}

/// The region of the phone's settings ("CM", "FR"), null when it has none.
@Riverpod(keepAlive: true)
String? deviceRegion(Ref ref) => PlatformDispatcher.instance.locale.countryCode;

/// The country of the phone number fields: the last one chosen to sign in or
/// sign up, else the phone's region, else Cameroon.
@Riverpod(keepAlive: true)
class PhoneCountry extends _$PhoneCountry {
  static const key = 'phone_country';

  @override
  Country build() =>
      Country.tryCode(ref.watch(sharedPreferencesProvider).getString(key)) ??
      Country.tryCode(ref.watch(deviceRegionProvider)) ??
      Country.cameroon;

  Future<void> save(Country country) async {
    state = country;
    await ref.read(sharedPreferencesProvider).setString(key, country.code);
  }
}
