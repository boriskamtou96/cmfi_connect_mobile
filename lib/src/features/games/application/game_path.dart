import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/session/session.dart';
import '../domain/game.dart';
import '../infrastructure/game_storage.dart';
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
  final storage = ref.watch(gameStorageProvider);
  try {
    final path = await api.path(course: course);
    // kept for the tab opened without network
    try {
      await storage.savePath(path);
      await storage.saveLastCourse(path.course);
    } on Object {
      // no copy: the tab still works online
    }
    return path;
  } on ApiException catch (error) {
    if (error.code == 'NOT_FOUND') {
      return null;
    }
    rethrow;
  } on Object {
    // without network: the last path seen of this course, with the lessons
    // finished since then and not sent yet
    final code = course ?? await storage.lastCourse();
    final kept = code == null ? null : await storage.path(code);
    if (kept == null) {
      rethrow;
    }
    final waiting = {
      for (final play in ref.read(pendingGamePlaysProvider))
        if (account == null || play.accountId == account.id) play.lessonId,
    };
    return withPlayedOffline(kept, waiting).copyWith(offline: true);
  }
}
