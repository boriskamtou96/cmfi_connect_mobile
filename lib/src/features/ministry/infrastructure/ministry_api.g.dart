// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministry_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ministryApi)
final ministryApiProvider = MinistryApiProvider._();

final class MinistryApiProvider
    extends $FunctionalProvider<MinistryApi, MinistryApi, MinistryApi>
    with $Provider<MinistryApi> {
  MinistryApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ministryApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ministryApiHash();

  @$internal
  @override
  $ProviderElement<MinistryApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MinistryApi create(Ref ref) {
    return ministryApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MinistryApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MinistryApi>(value),
    );
  }
}

String _$ministryApiHash() => r'2b2ce3f79245b0686449324fc05a83e5bcd127ec';

@ProviderFor(ministryLocalStore)
final ministryLocalStoreProvider = MinistryLocalStoreProvider._();

final class MinistryLocalStoreProvider
    extends
        $FunctionalProvider<
          MinistryLocalStore,
          MinistryLocalStore,
          MinistryLocalStore
        >
    with $Provider<MinistryLocalStore> {
  MinistryLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ministryLocalStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ministryLocalStoreHash();

  @$internal
  @override
  $ProviderElement<MinistryLocalStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MinistryLocalStore create(Ref ref) {
    return ministryLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MinistryLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MinistryLocalStore>(value),
    );
  }
}

String _$ministryLocalStoreHash() =>
    r'b9d7bfdf5e040fb04d1030eef1d88f61f546f4c4';
