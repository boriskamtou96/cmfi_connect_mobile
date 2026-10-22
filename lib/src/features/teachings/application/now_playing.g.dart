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

String _$nowPlayingHash() => r'3c04fca5d7cb35eb891c5e5bc6f86f7cdc25f5a7';

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
