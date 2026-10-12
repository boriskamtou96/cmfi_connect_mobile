import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'screen_awake.g.dart';

/// Keeps the screen on (reading a hymn during worship). Behind a provider so tests replace it.
class ScreenAwake {
  const ScreenAwake();

  Future<void> keepOn({required bool on}) => WakelockPlus.toggle(enable: on);
}

@Riverpod(keepAlive: true)
ScreenAwake screenAwake(Ref ref) => const ScreenAwake();
