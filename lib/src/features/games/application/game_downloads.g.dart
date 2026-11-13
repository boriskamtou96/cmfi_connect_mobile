// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_downloads.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// « Jouer hors ligne »: downloads every lesson of a course (again to update
/// it) or takes it off the phone.

@ProviderFor(GameDownloads)
final gameDownloadsProvider = GameDownloadsProvider._();

/// « Jouer hors ligne »: downloads every lesson of a course (again to update
/// it) or takes it off the phone.
final class GameDownloadsProvider
    extends $AsyncNotifierProvider<GameDownloads, GameDownloadsState> {
  /// « Jouer hors ligne »: downloads every lesson of a course (again to update
  /// it) or takes it off the phone.
  GameDownloadsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameDownloadsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameDownloadsHash();

  @$internal
  @override
  GameDownloads create() => GameDownloads();
}

String _$gameDownloadsHash() => r'57d5e8b29952e4e4a902a63b64500e4f77eab2f5';

/// « Jouer hors ligne »: downloads every lesson of a course (again to update
/// it) or takes it off the phone.

abstract class _$GameDownloads extends $AsyncNotifier<GameDownloadsState> {
  FutureOr<GameDownloadsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<GameDownloadsState>, GameDownloadsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GameDownloadsState>, GameDownloadsState>,
              AsyncValue<GameDownloadsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
