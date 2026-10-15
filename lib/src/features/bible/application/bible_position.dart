import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/bible.dart';

part 'bible_position.g.dart';

/// The chapter read last: the Bible opens on it again. The first time, John 1
/// (an easier start than Genesis).
@Riverpod(keepAlive: true)
class BiblePosition extends _$BiblePosition {
  static const _key = 'bible_position';
  static const start = BibleRef('JHN', 1);

  @override
  BibleRef build() =>
      BibleRef.parse(
        ref.watch(sharedPreferencesProvider).getString(_key),
      )?.chapterRef ??
      start;

  Future<void> set(BibleRef chapter) async {
    if (chapter.chapterRef == state) {
      return;
    }
    state = chapter.chapterRef;
    await ref.read(sharedPreferencesProvider).setString(_key, state.key);
  }
}

/// A verse to show (the verse of the day, a search result, a shared link):
/// the Bible goes to its chapter, brings it into view and lights it a moment.
@Riverpod(keepAlive: true)
class BibleFocus extends _$BibleFocus {
  @override
  BibleRef? build() => null;

  Future<void> show(BibleRef place) async {
    await ref.read(biblePositionProvider.notifier).set(place);
    state = place;
  }

  /// The verse has been shown.
  void clear() => state = null;
}
