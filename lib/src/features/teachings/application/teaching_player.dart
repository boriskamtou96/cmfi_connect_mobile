import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/teaching.dart';
import '../infrastructure/audio_service_player.dart';

part 'teaching_player.g.dart';

/// What the player is doing: the teaching opened (null before the first),
/// where it is, and how fast.
class PlayerSnapshot {
  const PlayerSnapshot({
    this.teaching,
    this.playing = false,
    this.loading = false,
    this.completed = false,
    this.position = Duration.zero,
    this.duration,
    this.speed = 1,
  });

  final Teaching? teaching;
  final bool playing;

  /// Opening the sound, or waiting for the network.
  final bool loading;

  /// Heard to the end.
  final bool completed;
  final Duration position;

  /// From the file once read, else the one the admins gave.
  final Duration? duration;
  final double speed;

  PlayerSnapshot copyWith({
    Teaching? teaching,
    bool? playing,
    bool? loading,
    bool? completed,
    Duration? position,
    Duration? duration,
    double? speed,
  }) => PlayerSnapshot(
    teaching: teaching ?? this.teaching,
    playing: playing ?? this.playing,
    loading: loading ?? this.loading,
    completed: completed ?? this.completed,
    position: position ?? this.position,
    duration: duration ?? this.duration,
    speed: speed ?? this.speed,
  );
}

/// Plays one teaching at a time, on with the screen locked, with its
/// controls on the lock screen and in the notification. Behind a provider so
/// tests play nothing.
abstract class TeachingPlayer {
  Stream<PlayerSnapshot> get snapshots;
  PlayerSnapshot get snapshot;

  /// Opens [teaching] from [source] (its address, or the file kept on the
  /// phone) at [start], and plays it; [artwork]: the cover for the lock
  /// screen.
  Future<void> open(
    Teaching teaching, {
    required Uri source,
    Uri? artwork,
    Duration start = Duration.zero,
    double speed = 1,
  });
  Future<void> play();
  Future<void> pause();
  Future<void> seek(Duration position);
  Future<void> setSpeed(double speed);

  /// Stops and forgets the teaching (signing out).
  Future<void> stop();
}

@Riverpod(keepAlive: true)
TeachingPlayer teachingPlayer(Ref ref) {
  final player = AudioServicePlayer();
  ref.onDispose(player.dispose);
  return player;
}
