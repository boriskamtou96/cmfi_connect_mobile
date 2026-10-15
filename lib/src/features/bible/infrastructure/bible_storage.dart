import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_storage.g.dart';

/// What the phone keeps of each version, in the app's support directory:
/// the list of books, the chapters read (one file each) and, once
/// downloaded, the whole Bible (complete.json).
class BibleStorage {
  BibleStorage({required Future<Directory> Function() directory})
    : _directory = directory;

  final Future<Directory> Function() _directory;

  Future<File> _file(String version, String name) async {
    final directory = Directory('${(await _directory()).path}/bible/$version');
    await directory.create(recursive: true);
    return File('${directory.path}/$name');
  }

  /// [name] of [version] ("books.json", "JHN.3.json", "complete.json"), or
  /// null when it isn't there (or can't be read).
  Future<String?> read(String version, String name) async {
    final file = await _file(version, name);
    if (!file.existsSync()) {
      return null;
    }
    try {
      return await file.readAsString();
    } on FileSystemException {
      return null;
    }
  }

  Future<bool> has(String version, String name) async =>
      (await _file(version, name)).existsSync();

  /// Writes then renames: never a half-written file.
  Future<void> write(String version, String name, List<int> bytes) async {
    final file = await _file(version, name);
    final temp = File('${file.path}.tmp');
    await temp.writeAsBytes(bytes, flush: true);
    await temp.rename(file.path);
  }

  Future<void> remove(String version, String name) async {
    final file = await _file(version, name);
    if (file.existsSync()) {
      await file.delete();
    }
  }
}

@Riverpod(keepAlive: true)
BibleStorage bibleStorage(Ref ref) =>
    BibleStorage(directory: getApplicationSupportDirectory);
