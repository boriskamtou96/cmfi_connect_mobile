import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';

part 'home_privacy.g.dart';

/// The eye of the home screen: the numbers of the summary hidden (••), as
/// in a bank app, when someone looks at the screen. Kept on the phone.
@Riverpod(keepAlive: true)
class HomeNumbersHidden extends _$HomeNumbersHidden {
  static const _key = 'home_numbers_hidden';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> toggle() async {
    state = !state;
    await ref.read(sharedPreferencesProvider).setBool(_key, state);
  }
}
