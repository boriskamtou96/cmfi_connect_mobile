import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/hymn.dart';

part 'hymn_collections.g.dart';

/// Hymns starred by the user, most recent first. Kept on the phone.
@Riverpod(keepAlive: true)
class FavoriteHymns extends _$FavoriteHymns {
  static const _key = 'hymn_favorites';

  @override
  List<HymnRef> build() =>
      (ref.watch(sharedPreferencesProvider).getStringList(_key) ?? const [])
          .map(HymnRef.parse)
          .toList();

  bool contains(HymnRef hymn) => state.contains(hymn);

  /// Adds or removes; returns true when the hymn is now a favorite.
  Future<bool> toggle(HymnRef hymn) async {
    final added = !state.contains(hymn);
    state = added
        ? [hymn, ...state]
        : [...state.where((other) => other != hymn)];
    await ref.read(sharedPreferencesProvider).setStringList(_key, [
      for (final ref in state) ref.key,
    ]);
    return added;
  }
}

/// The last hymns opened, most recent first.
@Riverpod(keepAlive: true)
class RecentHymns extends _$RecentHymns {
  static const _key = 'hymn_recents';
  static const _max = 30;

  @override
  List<HymnRef> build() =>
      (ref.watch(sharedPreferencesProvider).getStringList(_key) ?? const [])
          .map(HymnRef.parse)
          .toList();

  Future<void> opened(HymnRef hymn) async {
    if (state.firstOrNull == hymn) {
      return;
    }
    state = [
      hymn,
      ...state.where((other) => other != hymn),
    ].take(_max).toList();
    await ref.read(sharedPreferencesProvider).setStringList(_key, [
      for (final ref in state) ref.key,
    ]);
  }
}
