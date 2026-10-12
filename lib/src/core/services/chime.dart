import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chime.g.dart';

/// The soft sound between two points of a retreat (assets/sounds/chime.wav).
/// It respects the phone's silent mode and doesn't stop the music of other
/// apps. Behind a provider so tests replace it.
class Chime {
  AudioPlayer? _player;

  Future<void> play() async {
    try {
      final player = _player ??= AudioPlayer()
        ..setReleaseMode(ReleaseMode.stop);
      await player.setAudioContext(
        AudioContextConfig(
          focus: AudioContextConfigFocus.mixWithOthers,
          respectSilence: true,
        ).build(),
      );
      await player.play(AssetSource('sounds/chime.wav'), volume: 0.7);
    } on Object {
      // no sound is not a problem: the point changes on screen
    }
  }

  Future<void> dispose() async => _player?.dispose();
}

@Riverpod(keepAlive: true)
Chime chime(Ref ref) {
  final chime = Chime();
  ref.onDispose(chime.dispose);
  return chime;
}
