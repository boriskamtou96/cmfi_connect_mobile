// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BibleSettings _$BibleSettingsFromJson(Map<String, dynamic> json) =>
    _BibleSettings(
      version: json['version'] as String?,
      textScale: (json['text_scale'] as num?)?.toDouble() ?? 1.0,
      theme:
          $enumDecodeNullable(_$ReaderThemeEnumMap, json['theme']) ??
          ReaderTheme.auto,
      serif: json['serif'] as bool? ?? true,
      jesusInRed: json['jesus_in_red'] as bool? ?? true,
      keepScreenOn: json['keep_screen_on'] as bool? ?? true,
    );

Map<String, dynamic> _$BibleSettingsToJson(_BibleSettings instance) =>
    <String, dynamic>{
      'version': ?instance.version,
      'text_scale': instance.textScale,
      'theme': _$ReaderThemeEnumMap[instance.theme]!,
      'serif': instance.serif,
      'jesus_in_red': instance.jesusInRed,
      'keep_screen_on': instance.keepScreenOn,
    };

const _$ReaderThemeEnumMap = {
  ReaderTheme.auto: 'auto',
  ReaderTheme.light: 'light',
  ReaderTheme.sepia: 'sepia',
  ReaderTheme.dark: 'dark',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BibleSettingsController)
final bibleSettingsControllerProvider = BibleSettingsControllerProvider._();

final class BibleSettingsControllerProvider
    extends $NotifierProvider<BibleSettingsController, BibleSettings> {
  BibleSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleSettingsControllerHash();

  @$internal
  @override
  BibleSettingsController create() => BibleSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleSettings>(value),
    );
  }
}

String _$bibleSettingsControllerHash() =>
    r'3de80ec69fc8fa54d7714b17389b4d2190c6574a';

abstract class _$BibleSettingsController extends $Notifier<BibleSettings> {
  BibleSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BibleSettings, BibleSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BibleSettings, BibleSettings>,
              BibleSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The version read: the one chosen, else the one of the app's language.

@ProviderFor(bibleVersion)
final bibleVersionProvider = BibleVersionProvider._();

/// The version read: the one chosen, else the one of the app's language.

final class BibleVersionProvider
    extends $FunctionalProvider<BibleVersion, BibleVersion, BibleVersion>
    with $Provider<BibleVersion> {
  /// The version read: the one chosen, else the one of the app's language.
  BibleVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleVersionHash();

  @$internal
  @override
  $ProviderElement<BibleVersion> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BibleVersion create(Ref ref) {
    return bibleVersion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleVersion value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleVersion>(value),
    );
  }
}

String _$bibleVersionHash() => r'f31e58da50d92c8fee670caf0e169545cf76c031';
