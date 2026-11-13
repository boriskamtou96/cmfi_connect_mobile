import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/game.dart';
import '../infrastructure/games_api.dart';
import 'game_path.dart';

part 'leaderboard.g.dart';

/// The leaderboard over [period] (« week » or « all ») and [scope] (« all »
/// or « circle »: the member, their authorities and their disciples).
@riverpod
Future<GameLeaderboard> gameLeaderboard(
  Ref ref, {
  required String period,
  required String scope,
}) => ref.watch(gamesApiProvider).leaderboard(period: period, scope: scope);

/// The choices of the player. To appear in the leaderboard or not is theirs:
/// asked the first time they open it, changed whenever they want.
@riverpod
class GamePlayerSettings extends _$GamePlayerSettings {
  @override
  FutureOr<void> build() {}

  /// Says yes or no to the leaderboard; false when it could not be saved
  /// (the error is in the state).
  Future<bool> appear({required bool inLeaderboard}) async {
    state = const AsyncLoading();
    final saved = await AsyncValue.guard(
      () => ref.read(gamesApiProvider).updateMe(inLeaderboard: inLeaderboard),
    );
    if (!ref.mounted) {
      return !saved.hasError;
    }
    state = saved.hasError
        ? AsyncError(saved.error!, saved.stackTrace!)
        : const AsyncData(null);
    if (!saved.hasError) {
      // the player (their choice, their rank) and every leaderboard
      ref
        ..invalidate(gamePathProvider)
        ..invalidate(gameLeaderboardProvider);
    }
    return !saved.hasError;
  }
}
