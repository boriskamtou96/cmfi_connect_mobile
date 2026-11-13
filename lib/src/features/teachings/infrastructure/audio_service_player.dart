import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/theme/app_colors.dart';
import '../application/teaching_player.dart';
import '../domain/teaching.dart';

/// The real player: just_audio for the sound, audio_service for the lock
/// screen, the notification and the headphones' buttons. Started the first
/// time a teaching is played, not at launch.
class AudioServicePlayer implements TeachingPlayer {
  final _player = AudioPlayer();
  final _snapshots = StreamController<PlayerSnapshot>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _skips = _Skips();
  Future<_Handler>? _ready;
  PlayerSnapshot _snapshot = const PlayerSnapshot();

  @override
  Stream<PlayerSnapshot> get snapshots => _snapshots.stream;

  @override
  PlayerSnapshot get snapshot => _snapshot;

  void _emit(PlayerSnapshot snapshot) {
    _snapshot = snapshot;
    _snapshots.add(snapshot);
  }

  Future<_Handler> _init() => _ready ??= () async {
    // a voice: other sounds pause, and it goes on in the background
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    final handler = await AudioService.init(
      builder: () => _Handler(_player, _skips),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'teachings_player',
        androidNotificationChannelName: 'Enseignements',
        androidNotificationIcon: 'drawable/ic_notification',
        notificationColor: AppColors.primary,
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        fastForwardInterval: Duration(seconds: 15),
        rewindInterval: Duration(seconds: 15),
      ),
    );
    _subscriptions
      ..add(
        _player.playerStateStream.listen((state) {
          final completed = state.processingState == ProcessingState.completed;
          _emit(
            _snapshot.copyWith(
              playing: state.playing && !completed,
              loading:
                  state.processingState == ProcessingState.loading ||
                  state.processingState == ProcessingState.buffering,
              completed: completed,
            ),
          );
        }),
      )
      ..add(
        _player.positionStream.listen(
          (position) => _emit(_snapshot.copyWith(position: position)),
        ),
      )
      ..add(
        _player.durationStream.listen((duration) {
          if (duration != null) {
            _emit(_snapshot.copyWith(duration: duration));
          }
        }),
      )
      ..add(
        _player.speedStream.listen(
          (speed) => _emit(_snapshot.copyWith(speed: speed)),
        ),
      );
    return handler;
  }();

  @override
  Future<void> open(
    Teaching teaching, {
    required Uri source,
    Uri? artwork,
    Duration start = Duration.zero,
    double speed = 1,
  }) async {
    final handler = await _init();
    _emit(
      PlayerSnapshot(
        teaching: teaching,
        loading: true,
        position: start,
        duration: teaching.duration,
        speed: speed,
      ),
    );
    handler.mediaItem.add(
      MediaItem(
        id: '${teaching.id}',
        title: teaching.title,
        artist: teaching.speaker.isEmpty ? null : teaching.speaker,
        album: teaching.category.isEmpty ? null : teaching.category,
        duration: teaching.duration,
        artUri: artwork,
      ),
    );
    final duration = await _player.setAudioSource(
      AudioSource.uri(source),
      initialPosition: start,
    );
    if (duration != null) {
      handler.mediaItem.add(
        handler.mediaItem.value?.copyWith(duration: duration),
      );
    }
    await _player.setSpeed(speed);
    unawaited(_player.play());
  }

  @override
  Future<void> play() async {
    if (_player.processingState == ProcessingState.completed) {
      await _player.seek(Duration.zero);
    }
    unawaited(_player.play());
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  @override
  void setSkips({
    Future<void> Function()? next,
    Future<void> Function()? previous,
  }) {
    _skips
      ..next = next
      ..previous = previous;
    // the notification and the lock screen draw their buttons again
    unawaited(_ready?.then((handler) => handler.refresh()));
  }

  @override
  Future<void> stop() async {
    if (_ready == null) {
      return;
    }
    final handler = await _ready!;
    try {
      await handler.stop();
    } finally {
      // the mini player goes away even if the system answered badly
      _emit(const PlayerSnapshot());
    }
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _player.dispose();
    await _snapshots.close();
  }
}

/// What « next » and « previous » do now; null: the button is not shown.
class _Skips {
  Future<void> Function()? next;
  Future<void> Function()? previous;
}

/// What the system sees: the state of the player for the lock screen and
/// the notification, and its buttons (play, pause, ±15 s, the bar, the
/// message before and the next one when there is one).
class _Handler extends BaseAudioHandler with SeekHandler {
  _Handler(this._player, this._skips) {
    // listened, not piped: a pipe holds playbackState for itself
    // (addStream), and stop() could no longer say « stopped » to the system
    _player.playbackEventStream.listen(
      (event) => playbackState.add(_state(event)),
      onError: playbackState.addError,
    );
  }

  final AudioPlayer _player;
  final _Skips _skips;

  /// Says the state again: the buttons changed.
  void refresh() => playbackState.add(_state(_player.playbackEvent));

  PlaybackState _state(PlaybackEvent event) => PlaybackState(
    controls: [
      if (_skips.previous != null) MediaControl.skipToPrevious,
      MediaControl.rewind,
      if (_player.playing) MediaControl.pause else MediaControl.play,
      MediaControl.fastForward,
      if (_skips.next != null) MediaControl.skipToNext,
    ],
    systemActions: {
      MediaAction.seek,
      MediaAction.seekForward,
      MediaAction.seekBackward,
      if (_skips.next != null) MediaAction.skipToNext,
      if (_skips.previous != null) MediaAction.skipToPrevious,
    },
    // folded, the notification keeps −15, play and +15
    androidCompactActionIndices: _skips.previous != null
        ? const [1, 2, 3]
        : const [0, 1, 2],
    processingState: const {
      ProcessingState.idle: AudioProcessingState.idle,
      ProcessingState.loading: AudioProcessingState.loading,
      ProcessingState.buffering: AudioProcessingState.buffering,
      ProcessingState.ready: AudioProcessingState.ready,
      ProcessingState.completed: AudioProcessingState.completed,
    }[_player.processingState]!,
    playing: _player.playing,
    updatePosition: _player.position,
    bufferedPosition: _player.bufferedPosition,
    speed: _player.speed,
  );

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  @override
  Future<void> skipToNext() async => _skips.next?.call();

  @override
  Future<void> skipToPrevious() async => _skips.previous?.call();

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }
}
