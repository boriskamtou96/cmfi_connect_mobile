import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/media_images.dart';
import '../../../core/storage/preferences.dart';
import '../domain/teaching.dart';
import '../infrastructure/teaching_files.dart';
import 'teaching_library.dart';
import 'teaching_player.dart';

part 'now_playing.g.dart';

/// The teaching heard now, for the screens (the mini player, the player),
/// and what they ask: play one (from the file kept, else from the network,
/// where it stopped), pause, ±15 s, the speed. The place reached is kept
/// every 5 seconds, at each pause and at the end.
@Riverpod(keepAlive: true)
class NowPlaying extends _$NowPlaying {
  /// key `teaching_speed`: the speed chosen, for the next ones too.
  static const speedKey = 'teaching_speed';
  static const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  static const step = Duration(seconds: 15);

  Duration _saved = Duration.zero;

  @override
  PlayerSnapshot build() {
    final player = ref.watch(teachingPlayerProvider);
    final subscription = player.snapshots.listen((snapshot) {
      final before = state;
      state = snapshot;
      _keep(before, snapshot);
    });
    ref.onDispose(subscription.cancel);
    return player.snapshot;
  }

  void _keep(PlayerSnapshot before, PlayerSnapshot now) {
    final teaching = now.teaching;
    if (teaching == null || now.loading) {
      return;
    }
    final progress = ref.read(teachingProgressProvider.notifier);
    if (now.completed && !before.completed) {
      final end = now.duration ?? now.position;
      _saved = end;
      unawaited(progress.save(teaching.id, end, end));
    } else if ((before.playing && !now.playing) ||
        (now.position - _saved).abs() >= const Duration(seconds: 5)) {
      _saved = now.position;
      unawaited(progress.save(teaching.id, now.position, now.duration));
    }
  }

  double get _speed =>
      ref.read(sharedPreferencesProvider).getDouble(speedKey) ?? 1;

  /// Plays [teaching]: goes on if it is the one opened, else opens it where
  /// it stopped.
  Future<void> listen(Teaching teaching) async {
    final player = ref.read(teachingPlayerProvider);
    if (state.teaching?.id == teaching.id) {
      if (!state.playing) {
        await player.play();
      }
      return;
    }
    final images = ref.read(mediaImagesProvider);
    final file = await ref.read(teachingFilesProvider).fileOf(teaching);
    final start = ref
        .read(teachingProgressProvider.notifier)
        .resumeAt(teaching.id);
    _saved = start;
    await player.open(
      teaching,
      source: file?.uri ?? Uri.parse(images.resolve(teaching.audio.url)),
      artwork: teaching.cover == null
          ? null
          : Uri.parse(images.resolve(teaching.cover!.url)),
      start: start,
      speed: _speed,
    );
  }

  Future<void> toggle() {
    final player = ref.read(teachingPlayerProvider);
    return state.playing ? player.pause() : player.play();
  }

  /// [by]: forward, or back when negative; never past the ends.
  Future<void> skip(Duration by) {
    final duration = state.duration;
    var target = state.position + by;
    if (target < Duration.zero) {
      target = Duration.zero;
    }
    if (duration != null && target > duration) {
      target = duration;
    }
    return seek(target);
  }

  Future<void> seek(Duration position) =>
      ref.read(teachingPlayerProvider).seek(position);

  /// The next speed of [speeds], back to the first after the last.
  Future<void> nextSpeed() async {
    final index = speeds.indexWhere((speed) => speed >= state.speed - 0.01);
    final speed = speeds[(index + 1) % speeds.length];
    await ref.read(sharedPreferencesProvider).setDouble(speedKey, speed);
    await ref.read(teachingPlayerProvider).setSpeed(speed);
  }

  Future<void> stop() => ref.read(teachingPlayerProvider).stop();

  /// The cross of the mini player: where it is kept, then the player
  /// stops and goes away (the teaching resumes there next time).
  Future<void> close() async {
    final teaching = state.teaching;
    if (teaching != null && state.position > Duration.zero) {
      await ref
          .read(teachingProgressProvider.notifier)
          .save(teaching.id, state.position, state.duration);
    }
    await stop();
  }
}
