// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachings_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teachingsLocalStore)
final teachingsLocalStoreProvider = TeachingsLocalStoreProvider._();

final class TeachingsLocalStoreProvider
    extends
        $FunctionalProvider<
          TeachingsLocalStore,
          TeachingsLocalStore,
          TeachingsLocalStore
        >
    with $Provider<TeachingsLocalStore> {
  TeachingsLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingsLocalStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingsLocalStoreHash();

  @$internal
  @override
  $ProviderElement<TeachingsLocalStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TeachingsLocalStore create(Ref ref) {
    return teachingsLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeachingsLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeachingsLocalStore>(value),
    );
  }
}

String _$teachingsLocalStoreHash() =>
    r'4a074b4f34408aa062f781298deb6878d6778d46';
