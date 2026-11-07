// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_music.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backgroundMusic)
final backgroundMusicProvider = BackgroundMusicProvider._();

final class BackgroundMusicProvider
    extends
        $FunctionalProvider<BackgroundMusic, BackgroundMusic, BackgroundMusic>
    with $Provider<BackgroundMusic> {
  BackgroundMusicProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundMusicProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundMusicHash();

  @$internal
  @override
  $ProviderElement<BackgroundMusic> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackgroundMusic create(Ref ref) {
    return backgroundMusic(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackgroundMusic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackgroundMusic>(value),
    );
  }
}

String _$backgroundMusicHash() => r'67c41712ad740e91213c3460a5f5edad70d15161';
