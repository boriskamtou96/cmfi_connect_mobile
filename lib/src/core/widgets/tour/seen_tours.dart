import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../storage/preferences.dart';
import 'tour_step.dart';

part 'seen_tours.g.dart';

/// The spaces whose short tour was already shown on this phone: each space
/// presents itself once, the first time the member arrives there (23/11/2026).
/// « Revoir la présentation des espaces » (Réglages) forgets them all.
@Riverpod(keepAlive: true)
class SeenTours extends _$SeenTours {
  static const _key = 'seen_tours';

  @override
  Set<TourSpace> build() {
    final names = ref.watch(sharedPreferencesProvider).getStringList(_key);
    final byName = TourSpace.values.asNameMap();
    return {...?names?.map((name) => byName[name]).nonNulls};
  }

  Future<void> markSeen(TourSpace space) async {
    if (state.contains(space)) return;
    state = {...state, space};
    await ref.read(sharedPreferencesProvider).setStringList(_key, [
      for (final seen in state) seen.name,
    ]);
  }

  /// Every space presents itself again, the next time the member opens it.
  Future<void> forgetAll() async {
    state = const {};
    await ref.read(sharedPreferencesProvider).remove(_key);
  }
}
