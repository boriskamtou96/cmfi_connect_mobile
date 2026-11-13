import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../infrastructure/game_storage.dart';
import '../infrastructure/games_api.dart';

part 'game_downloads.g.dart';

/// The courses kept on the phone to play without network, and the one being
/// downloaded.
@immutable
class GameDownloadsState {
  const GameDownloadsState({this.courses = const {}, this.loading});

  final Set<String> courses;

  /// The code of the course being downloaded, null otherwise.
  final String? loading;
}

/// « Jouer hors ligne »: downloads every lesson of a course (again to update
/// it) or takes it off the phone.
@Riverpod(keepAlive: true)
class GameDownloads extends _$GameDownloads {
  @override
  Future<GameDownloadsState> build() async => GameDownloadsState(
    courses: await ref.watch(gameStorageProvider).downloaded(),
  );

  /// Keeps the lessons of [course]; throws (no network…) and keeps nothing.
  Future<void> download(String course) async {
    final storage = ref.read(gameStorageProvider);
    final before = state.value ?? const GameDownloadsState();
    state = AsyncData(
      GameDownloadsState(courses: before.courses, loading: course),
    );
    try {
      final lessons = await ref.read(gamesApiProvider).download(course);
      await storage.saveLessons(course, lessons);
      if (ref.mounted) {
        state = AsyncData(
          GameDownloadsState(courses: {...before.courses, course}),
        );
      }
    } on Object {
      if (ref.mounted) {
        state = AsyncData(GameDownloadsState(courses: before.courses));
      }
      rethrow;
    }
  }

  Future<void> remove(String course) async {
    await ref.read(gameStorageProvider).removeLessons(course);
    final before = state.value ?? const GameDownloadsState();
    state = AsyncData(
      GameDownloadsState(courses: {...before.courses}..remove(course)),
    );
  }
}
