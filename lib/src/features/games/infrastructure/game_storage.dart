import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/game.dart';

part 'game_storage.g.dart';

/// What the phone keeps of the games, in the app's support directory
/// (games/): the last path seen of each course (`path_<code>.json`), and the
/// courses downloaded to play without network (`lessons_<code>.json`).
class GameStorage {
  GameStorage({required Future<Directory> Function() directory})
    : _directory = directory;

  final Future<Directory> Function() _directory;

  Future<File> _file(String name) async {
    final directory = Directory('${(await _directory()).path}/games');
    await directory.create(recursive: true);
    return File('${directory.path}/$name');
  }

  Future<Object?> _read(String name) async {
    final file = await _file(name);
    if (!file.existsSync()) {
      return null;
    }
    try {
      return jsonDecode(await file.readAsString());
    } on Object {
      // unreadable: as if it were not there
      return null;
    }
  }

  /// Writes then renames: never a half-written file.
  Future<void> _write(String name, Object json) async {
    final file = await _file(name);
    final temp = File('${file.path}.tmp');
    await temp.writeAsString(jsonEncode(json), flush: true);
    await temp.rename(file.path);
  }

  Future<GamePath?> path(String course) async =>
      switch (await _read('path_$course.json')) {
        final Map<String, dynamic> json => GamePath.fromJson(json),
        _ => null,
      };

  Future<void> savePath(GamePath path) => _write(
    'path_${path.course}.json',
    path.copyWith(offline: false).toJson(),
  );

  /// The course shown last, for the tab opened without network.
  Future<String?> lastCourse() async => switch (await _read('last.json')) {
    {'course': final String course} => course,
    _ => null,
  };

  Future<void> saveLastCourse(String course) =>
      _write('last.json', {'course': course});

  /// The lessons of [course] downloaded, null when it is not.
  Future<List<GameLesson>?> lessons(String course) async =>
      switch (await _read('lessons_$course.json')) {
        final List<dynamic> list => [
          for (final lesson in list)
            GameLesson.fromJson(lesson as Map<String, dynamic>),
        ],
        _ => null,
      };

  Future<void> saveLessons(String course, List<GameLesson> lessons) => _write(
    'lessons_$course.json',
    [for (final lesson in lessons) lesson.toJson()],
  );

  Future<void> removeLessons(String course) async {
    final file = await _file('lessons_$course.json');
    if (file.existsSync()) {
      await file.delete();
    }
  }

  /// The codes of the courses downloaded.
  Future<Set<String>> downloaded() async {
    final directory = Directory('${(await _directory()).path}/games');
    if (!directory.existsSync()) {
      return {};
    }
    return {
      for (final file in directory.listSync())
        if (file.uri.pathSegments.last case final name
            when name.startsWith('lessons_') && name.endsWith('.json'))
          name.substring('lessons_'.length, name.length - '.json'.length),
    };
  }

  /// A lesson kept in one of the courses downloaded.
  Future<GameLesson?> lesson(int id) async {
    for (final course in await downloaded()) {
      for (final lesson in await lessons(course) ?? const <GameLesson>[]) {
        if (lesson.id == id) {
          return lesson;
        }
      }
    }
    return null;
  }

  /// Everything (at the sign-out: another account plays on its own).
  Future<void> clear() async {
    final directory = Directory('${(await _directory()).path}/games');
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  }
}

@Riverpod(keepAlive: true)
GameStorage gameStorage(Ref ref) =>
    GameStorage(directory: getApplicationSupportDirectory);
