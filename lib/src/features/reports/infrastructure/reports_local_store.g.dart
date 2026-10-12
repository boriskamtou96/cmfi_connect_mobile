// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsLocalStore)
final reportsLocalStoreProvider = ReportsLocalStoreProvider._();

final class ReportsLocalStoreProvider
    extends
        $FunctionalProvider<
          ReportsLocalStore,
          ReportsLocalStore,
          ReportsLocalStore
        >
    with $Provider<ReportsLocalStore> {
  ReportsLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsLocalStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsLocalStoreHash();

  @$internal
  @override
  $ProviderElement<ReportsLocalStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportsLocalStore create(Ref ref) {
    return reportsLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsLocalStore>(value),
    );
  }
}

String _$reportsLocalStoreHash() => r'028e147b16044b88e1a2d81303fcf5eb00a0bde1';
