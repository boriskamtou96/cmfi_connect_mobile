import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/bible.dart';

part 'bible_bookmark.g.dart';

/// The reading bookmark: one chapter where the member stopped ("MAT.5"), to
/// come back to after browsing elsewhere. The same in every version; kept at
/// sign-out, like the marks. Null: none placed (or an unreadable value).
@Riverpod(keepAlive: true)
class BibleBookmark extends _$BibleBookmark {
  static const _key = 'bible_bookmark';

  @override
  BibleRef? build() => BibleRef.parse(
    ref.watch(sharedPreferencesProvider).getString(_key),
  )?.chapterRef;

  /// Places the bookmark on [chapter] (moved there when it was elsewhere).
  Future<void> set(BibleRef chapter) async {
    state = chapter.chapterRef;
    await ref.read(sharedPreferencesProvider).setString(_key, state!.key);
  }

  Future<void> clear() async {
    state = null;
    await ref.read(sharedPreferencesProvider).remove(_key);
  }
}
