// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The leaderboard over [period] (« week » or « all ») and [scope] (« all »
/// or « circle »: the member, their authorities and their disciples).

@ProviderFor(gameLeaderboard)
final gameLeaderboardProvider = GameLeaderboardFamily._();

/// The leaderboard over [period] (« week » or « all ») and [scope] (« all »
/// or « circle »: the member, their authorities and their disciples).

final class GameLeaderboardProvider
    extends
        $FunctionalProvider<
          AsyncValue<GameLeaderboard>,
          GameLeaderboard,
          FutureOr<GameLeaderboard>
        >
    with $FutureModifier<GameLeaderboard>, $FutureProvider<GameLeaderboard> {
  /// The leaderboard over [period] (« week » or « all ») and [scope] (« all »
  /// or « circle »: the member, their authorities and their disciples).
  GameLeaderboardProvider._({
    required GameLeaderboardFamily super.from,
    required ({String period, String scope}) super.argument,
  }) : super(
         retry: null,
         name: r'gameLeaderboardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameLeaderboardHash();

  @override
  String toString() {
    return r'gameLeaderboardProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<GameLeaderboard> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GameLeaderboard> create(Ref ref) {
    final argument = this.argument as ({String period, String scope});
    return gameLeaderboard(ref, period: argument.period, scope: argument.scope);
  }

  @override
  bool operator ==(Object other) {
    return other is GameLeaderboardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameLeaderboardHash() => r'846d3a2f503bb49f207da3b31f6e2ee4c4605fb9';

/// The leaderboard over [period] (« week » or « all ») and [scope] (« all »
/// or « circle »: the member, their authorities and their disciples).

final class GameLeaderboardFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<GameLeaderboard>,
          ({String period, String scope})
        > {
  GameLeaderboardFamily._()
    : super(
        retry: null,
        name: r'gameLeaderboardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The leaderboard over [period] (« week » or « all ») and [scope] (« all »
  /// or « circle »: the member, their authorities and their disciples).

  GameLeaderboardProvider call({
    required String period,
    required String scope,
  }) => GameLeaderboardProvider._(
    argument: (period: period, scope: scope),
    from: this,
  );

  @override
  String toString() => r'gameLeaderboardProvider';
}

/// The choices of the player. To appear in the leaderboard or not is theirs:
/// asked the first time they open it, changed whenever they want.

@ProviderFor(GamePlayerSettings)
final gamePlayerSettingsProvider = GamePlayerSettingsProvider._();

/// The choices of the player. To appear in the leaderboard or not is theirs:
/// asked the first time they open it, changed whenever they want.
final class GamePlayerSettingsProvider
    extends $AsyncNotifierProvider<GamePlayerSettings, void> {
  /// The choices of the player. To appear in the leaderboard or not is theirs:
  /// asked the first time they open it, changed whenever they want.
  GamePlayerSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamePlayerSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamePlayerSettingsHash();

  @$internal
  @override
  GamePlayerSettings create() => GamePlayerSettings();
}

String _$gamePlayerSettingsHash() =>
    r'8f82be720d25e53b8f2e6263cef26c86fd6e6e27';

/// The choices of the player. To appear in the leaderboard or not is theirs:
/// asked the first time they open it, changed whenever they want.

abstract class _$GamePlayerSettings extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
