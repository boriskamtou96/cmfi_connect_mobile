import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';

part 'verse_share_background.g.dart';

/// The background last chosen for the image of a verse (its id in
/// `verseBackgrounds`), kept on the phone (`verse_share_background`): the
/// next share starts from it. null: the first photo.
@Riverpod(keepAlive: true)
class VerseShareBackground extends _$VerseShareBackground {
  static const key = 'verse_share_background';

  @override
  String? build() => ref.watch(sharedPreferencesProvider).getString(key);

  Future<void> choose(String id) async {
    state = id;
    await ref.read(sharedPreferencesProvider).setString(key, id);
  }
}
