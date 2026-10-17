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
      builder: () => _Handler(_player),
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
  Future<void> stop() async {
    if (_ready == null) {
      return;
    }
    final handler = await _ready!;
    await handler.stop();
    _emit(const PlayerSnapshot());
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _player.dispose();
    await _snapshots.close();
  }
}

/// What the system sees: the state of the player for the lock screen and
/// the notification, and its buttons (play, pause, ±15 s, the bar).
class _Handler extends BaseAudioHandler with SeekHandler {
  _Handler(this._player) {
    _player.playbackEventStream.map(_state).pipe(playbackState);
  }

  final AudioPlayer _player;

  PlaybackState _state(PlaybackEvent event) => PlaybackState(
    controls: [
      MediaControl.rewind,
      if (_player.playing) MediaControl.pause else MediaControl.play,
      MediaControl.fastForward,
    ],
    systemActions: const {
      MediaAction.seek,
      MediaAction.seekForward,
      MediaAction.seekBackward,
    },
    androidCompactActionIndices: const [0, 1, 2],
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
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }
}
