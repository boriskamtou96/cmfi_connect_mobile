import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/session/session.dart';
import '../domain/game.dart';
import '../infrastructure/games_api.dart';
import 'pending_plays.dart';

part 'game_path.g.dart';

/// The course shown in the tab (null: the first one), kept between tabs.
@Riverpod(keepAlive: true)
class SelectedGameCourse extends _$SelectedGameCourse {
  @override
  String? build() => null;

  void select(String code) => state = code;
}

/// The path of the course shown, as the member walks it. Null while no
/// course is published: the tab says the games are coming.
@riverpod
Future<GamePath?> gamePath(Ref ref) async {
  final course = ref.watch(selectedGameCourseProvider);
  final api = ref.watch(gamesApiProvider);
  // the plays finished without network go first: the path counts them
  final account = await ref.watch(signedInAccountProvider.future);
  if (account != null) {
    await ref.read(pendingGamePlaysProvider.notifier).flush(account.id);
  }
  try {
    return await api.path(course: course);
  } on ApiException catch (error) {
    if (error.code == 'NOT_FOUND') {
      return null;
    }
    rethrow;
  }
}
