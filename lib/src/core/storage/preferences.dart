import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
