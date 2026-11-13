// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameStorage)
final gameStorageProvider = GameStorageProvider._();

final class GameStorageProvider
    extends $FunctionalProvider<GameStorage, GameStorage, GameStorage>
    with $Provider<GameStorage> {
  GameStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameStorageHash();

  @$internal
  @override
  $ProviderElement<GameStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GameStorage create(Ref ref) {
    return gameStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameStorage>(value),
    );
  }
}

String _$gameStorageHash() => r'424c32500d9a722219b1b348a43f7d99381a9c51';
