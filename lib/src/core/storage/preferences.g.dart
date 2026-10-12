// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Overridden in bootstrap.dart with the loaded instance.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Overridden in bootstrap.dart with the loaded instance.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Overridden in bootstrap.dart with the loaded instance.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'70ef90bd70df9f89260fca9b542d9f8d25d8e3cb';

/// Whether the presentation screens were already shown (first launch only).

@ProviderFor(OnboardingSeen)
final onboardingSeenProvider = OnboardingSeenProvider._();

/// Whether the presentation screens were already shown (first launch only).
final class OnboardingSeenProvider
    extends $NotifierProvider<OnboardingSeen, bool> {
  /// Whether the presentation screens were already shown (first launch only).
  OnboardingSeenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingSeenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingSeenHash();

  @$internal
  @override
  OnboardingSeen create() => OnboardingSeen();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingSeenHash() => r'a69371c1da5d52d46f645c91f55fa3025941b73a';

/// Whether the presentation screens were already shown (first launch only).

abstract class _$OnboardingSeen extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Language chosen in the app ("fr", "en"); null follows the phone.

@ProviderFor(SavedLanguage)
final savedLanguageProvider = SavedLanguageProvider._();

/// Language chosen in the app ("fr", "en"); null follows the phone.
final class SavedLanguageProvider
    extends $NotifierProvider<SavedLanguage, String?> {
  /// Language chosen in the app ("fr", "en"); null follows the phone.
  SavedLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedLanguageHash();

  @$internal
  @override
  SavedLanguage create() => SavedLanguage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$savedLanguageHash() => r'2ccd957f19a69780b6cb46805469c5988ffa6b99';

/// Language chosen in the app ("fr", "en"); null follows the phone.

abstract class _$SavedLanguage extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Light or dark look, or the phone's own (the default).

@ProviderFor(SavedThemeMode)
final savedThemeModeProvider = SavedThemeModeProvider._();

/// Light or dark look, or the phone's own (the default).
final class SavedThemeModeProvider
    extends $NotifierProvider<SavedThemeMode, ThemeMode> {
  /// Light or dark look, or the phone's own (the default).
  SavedThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedThemeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedThemeModeHash();

  @$internal
  @override
  SavedThemeMode create() => SavedThemeMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$savedThemeModeHash() => r'77d79fa518b516b49e60c2a8ef5d760f9b5a7524';

/// Light or dark look, or the phone's own (the default).

abstract class _$SavedThemeMode extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
