import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/date_extensions.dart';

part 'current_day.g.dart';

/// Today, read again each time the app comes back to the front: an app left
/// open in the background overnight shows the new day (the verse of the
/// day, the date of Home, the steps of the day) without being restarted.
/// What depends on the day watches it instead of calling [today] once.
@Riverpod(keepAlive: true)
class CurrentDay extends _$CurrentDay {
  @override
  DateTime build() {
    try {
      final listener = AppLifecycleListener(onResume: check);
      ref.onDispose(listener.dispose);
    } on Object {
      // no Flutter binding (a unit test): the day is read once
    }
    return today();
  }

  /// The day changed since it was last read: everything watching it again.
  void check() {
    final now = today();
    if (now != state) {
      state = now;
    }
  }
}
