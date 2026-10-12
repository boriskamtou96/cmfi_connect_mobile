// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prayerLocalStore)
final prayerLocalStoreProvider = PrayerLocalStoreProvider._();

final class PrayerLocalStoreProvider
    extends
        $FunctionalProvider<
          PrayerLocalStore,
          PrayerLocalStore,
          PrayerLocalStore
        >
    with $Provider<PrayerLocalStore> {
  PrayerLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerLocalStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerLocalStoreHash();

  @$internal
  @override
  $ProviderElement<PrayerLocalStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrayerLocalStore create(Ref ref) {
    return prayerLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerLocalStore>(value),
    );
  }
}

String _$prayerLocalStoreHash() => r'40623e66672752b9068b4d5ac73cc1bb1b6647e2';
