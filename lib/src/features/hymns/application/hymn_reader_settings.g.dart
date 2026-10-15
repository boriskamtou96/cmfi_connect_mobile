// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_reader_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HymnReaderSettings _$HymnReaderSettingsFromJson(Map<String, dynamic> json) =>
    _HymnReaderSettings(
      textScale: (json['text_scale'] as num?)?.toDouble() ?? 1.0,
      typeface:
          $enumDecodeNullable(_$HymnTypefaceEnumMap, json['typeface']) ??
          HymnTypeface.auto,
      theme:
          $enumDecodeNullable(_$ReaderThemeEnumMap, json['theme']) ??
          ReaderTheme.auto,
      repeatChorus: json['repeat_chorus'] as bool? ?? false,
      keepScreenOn: json['keep_screen_on'] as bool? ?? true,
    );

Map<String, dynamic> _$HymnReaderSettingsToJson(_HymnReaderSettings instance) =>
    <String, dynamic>{
      'text_scale': instance.textScale,
      'typeface': _$HymnTypefaceEnumMap[instance.typeface]!,
      'theme': _$ReaderThemeEnumMap[instance.theme]!,
      'repeat_chorus': instance.repeatChorus,
      'keep_screen_on': instance.keepScreenOn,
    };

const _$HymnTypefaceEnumMap = {
  HymnTypeface.auto: 'auto',
  HymnTypeface.sans: 'sans',
  HymnTypeface.serif: 'serif',
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

@ProviderFor(HymnReaderSettingsController)
final hymnReaderSettingsControllerProvider =
    HymnReaderSettingsControllerProvider._();

final class HymnReaderSettingsControllerProvider
    extends
        $NotifierProvider<HymnReaderSettingsController, HymnReaderSettings> {
  HymnReaderSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hymnReaderSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hymnReaderSettingsControllerHash();

  @$internal
  @override
  HymnReaderSettingsController create() => HymnReaderSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnReaderSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnReaderSettings>(value),
    );
  }
}

String _$hymnReaderSettingsControllerHash() =>
    r'f9eb4f8e87db3cd30640e31c4911f3d7af592a34';

abstract class _$HymnReaderSettingsController
    extends $Notifier<HymnReaderSettings> {
  HymnReaderSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HymnReaderSettings, HymnReaderSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HymnReaderSettings, HymnReaderSettings>,
              HymnReaderSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
