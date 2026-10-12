// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prayerApi)
final prayerApiProvider = PrayerApiProvider._();

final class PrayerApiProvider
    extends $FunctionalProvider<PrayerApi, PrayerApi, PrayerApi>
    with $Provider<PrayerApi> {
  PrayerApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerApiHash();

  @$internal
  @override
  $ProviderElement<PrayerApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrayerApi create(Ref ref) {
    return prayerApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerApi>(value),
    );
  }
}

String _$prayerApiHash() => r'cbd579517791a3c72d21c52b6e84341c826c73e4';
