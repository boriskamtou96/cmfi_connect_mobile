import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_sounds.g.dart';

/// The short sounds of the games: a lesson done, a level done. Bell-like
/// notes made for the app (assets/sounds/games, synthesized, no sample).
/// Silent when the phone is on silent, mixed with the music of other apps.
/// Behind a provider so tests hear nothing.
class GameSounds {
  AudioPlayer? _player;

  static const _lesson = 'sounds/games/lesson_done.wav';
  static const _level = 'sounds/games/level_done.wav';

  /// The end of a lesson; [level] when it finished its level (or the
  /// player went up a level): a longer fanfare.
  Future<void> lessonDone({bool level = false}) async {
    try {
      final player = _player ??= AudioPlayer(playerId: 'games');
      await player.setAudioContext(
        AudioContextConfig(
          focus: AudioContextConfigFocus.mixWithOthers,
          // the « ambient » category on iOS: nothing on silent
          respectSilence: true,
        ).build(),
      );
      await player.play(AssetSource(level ? _level : _lesson), volume: 0.8);
    } on Object {
      // no sound is not a problem: the end of the lesson still shows
    }
  }
}

@Riverpod(keepAlive: true)
GameSounds gameSounds(Ref ref) => GameSounds();
