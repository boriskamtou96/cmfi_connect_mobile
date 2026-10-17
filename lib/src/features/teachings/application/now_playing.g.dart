// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The teaching heard now, for the screens (the mini player, the player),
/// and what they ask: play one (from the file kept, else from the network,
/// where it stopped), pause, ±15 s, the speed. The place reached is kept
/// every 5 seconds, at each pause and at the end.

@ProviderFor(NowPlaying)
final nowPlayingProvider = NowPlayingProvider._();

/// The teaching heard now, for the screens (the mini player, the player),
/// and what they ask: play one (from the file kept, else from the network,
/// where it stopped), pause, ±15 s, the speed. The place reached is kept
/// every 5 seconds, at each pause and at the end.
final class NowPlayingProvider
    extends $NotifierProvider<NowPlaying, PlayerSnapshot> {
  /// The teaching heard now, for the screens (the mini player, the player),
  /// and what they ask: play one (from the file kept, else from the network,
  /// where it stopped), pause, ±15 s, the speed. The place reached is kept
  /// every 5 seconds, at each pause and at the end.
  NowPlayingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowPlayingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowPlayingHash();

  @$internal
  @override
  NowPlaying create() => NowPlaying();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerSnapshot value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerSnapshot>(value),
    );
  }
}

String _$nowPlayingHash() => r'44d22ed9213104ae55f6ce3eaa2e605824a65693';

/// The teaching heard now, for the screens (the mini player, the player),
/// and what they ask: play one (from the file kept, else from the network,
/// where it stopped), pause, ±15 s, the speed. The place reached is kept
/// every 5 seconds, at each pause and at the end.

abstract class _$NowPlaying extends $Notifier<PlayerSnapshot> {
  PlayerSnapshot build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlayerSnapshot, PlayerSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayerSnapshot, PlayerSnapshot>,
              PlayerSnapshot,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
