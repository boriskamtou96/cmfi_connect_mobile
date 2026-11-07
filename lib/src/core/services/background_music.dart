import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_music.g.dart';

/// Heard even with the phone on silent, as people pray with it so (the
/// button of the retreat turns it off), with the music of other apps. On
/// iOS the context is the app's, for every player.
AudioContext _prayerSoundContext() => AudioContextConfig(
  focus: AudioContextConfigFocus.mixWithOthers,
  // true is the "ambient" category on iOS: silent switch on, nothing
  respectSilence: false,
).build();

/// Soft piano behind a retreat, turned on by the user: the tracks one after
/// the other, from a different one each time, faded in and out. Heard even
/// on silent, with the music of other apps; lower while a
/// voice reads the points. Behind a provider so tests hear nothing.
///
/// The tracks (assets/sounds/music) come from Pixabay, under the Pixabay
/// Content License (free, commercial use, no credit; not to be sold or
/// shared as files on their own), none registered with Content ID:
/// - all_creatures: "All Creatures of Our God and King - Piano
///   Improvisation", smccleery
///   (pixabay.com/music/modern-classical-all-creatures-of-our-god-and-king-piano-improvisation-247210)
/// - soaking: "Christian Instrumental Piano Worship Calm Emotional Soaking
///   Prayer", JesseQuinnMedia
///   (pixabay.com/music/ambient-christian-instrumental-piano-worship-calm-emotional-soaking-prayer-249459)
class BackgroundMusic {
  static const tracks = [
    'sounds/music/all_creatures.m4a',
    'sounds/music/soaking.m4a',
  ];

  static const _volume = 0.4;
  static const _quietVolume = 0.15;

  AudioPlayer? _player;
  StreamSubscription<void>? _ended;
  var _track = Random().nextInt(tracks.length);
  var _quiet = false;
  var _started = false;
  // a newer play / pause / stop cancels the fade under way
  var _turn = 0;

  double get _target => _quiet ? _quietVolume : _volume;

  /// Starts, or goes on where it was paused.
  Future<void> play() async {
    final turn = ++_turn;
    try {
      final player = _player ??= _newPlayer();
      await player.setAudioContext(_prayerSoundContext());
      if (_started) {
        await player.resume();
      } else {
        _started = true;
        await player.play(AssetSource(tracks[_track]), volume: 0);
      }
      await _fade(player, to: _target, turn: turn, steps: 15);
    } on Object {
      // no music is not a problem: the retreat goes on
    }
  }

  Future<void> pause() async {
    final player = _player;
    if (player == null || !_started) {
      return;
    }
    final turn = ++_turn;
    try {
      await _fade(player, to: 0, turn: turn, steps: 6);
      if (turn == _turn) {
        await player.pause();
      }
    } on Object {
      // already stopped
    }
  }

  /// At the end of the retreat, or when it is left: the next one starts
  /// with another track.
  Future<void> stop() async {
    final player = _player;
    if (player == null || !_started) {
      return;
    }
    final turn = ++_turn;
    _started = false;
    _track = (_track + 1) % tracks.length;
    try {
      await _fade(player, to: 0, turn: turn, steps: 8);
      if (turn == _turn) {
        await player.stop();
      }
    } on Object {
      // already stopped
    }
  }

  /// Lower while a voice reads the points.
  Future<void> quiet({required bool on}) async {
    _quiet = on;
    final player = _player;
    if (player == null || !_started) {
      return;
    }
    try {
      await player.setVolume(_target);
    } on Object {
      // the volume comes back with the next play
    }
  }

  Future<void> dispose() async {
    await _ended?.cancel();
    await _player?.dispose();
  }

  AudioPlayer _newPlayer() {
    final player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _ended = player.onPlayerComplete.listen((_) async {
      _track = (_track + 1) % tracks.length;
      try {
        await player.play(AssetSource(tracks[_track]), volume: _target);
      } on Object {
        // the next track will not come: the retreat goes on in silence
      }
    });
    return player;
  }

  /// From the volume now to [to], 100 ms a step.
  Future<void> _fade(
    AudioPlayer player, {
    required double to,
    required int turn,
    required int steps,
  }) async {
    final from = player.volume;
    for (var step = 1; step <= steps; step++) {
      if (turn != _turn) {
        return;
      }
      await player.setVolume(from + (to - from) * step / steps);
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
}

@Riverpod(keepAlive: true)
BackgroundMusic backgroundMusic(Ref ref) {
  final music = BackgroundMusic();
  ref.onDispose(music.dispose);
  return music;
}
