import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/play_queue.dart';
import '../domain/teaching.dart';
import '../infrastructure/teaching_files.dart';
import '../infrastructure/teachings_api.dart';
import 'now_playing.dart';
import 'teaching_player.dart';
import 'teachings.dart';

part 'listening.g.dart';

/// Listening in a row: the queue (the list the message was played from),
/// whether the next one starts by itself, and the sleep timer.
@immutable
class ListeningState {
  const ListeningState({
    this.queue = const PlayQueue(),
    this.continuous = true,
    this.sleepUntil,
    this.sleepAtEnd = false,
  });

  final PlayQueue queue;

  /// At the end of a message the next one starts.
  final bool continuous;

  /// The sleep timer: when the player pauses…
  final DateTime? sleepUntil;

  /// …or: at the end of the message heard, nothing follows.
  final bool sleepAtEnd;

  bool get sleeping => sleepUntil != null || sleepAtEnd;
}

/// Plays the teachings one after the other, like a playlist: a message is
/// started with the list around it ([start]); when it ends the next one
/// plays (unless [ListeningState.continuous] is off, or the sleep timer said
/// to stop there), from the phone when it is kept, from the network
/// otherwise — and without network, the next one that is kept. At the end of
/// the pages the screen had read, the list is read further. The buttons
/// « next » and « previous » of the system (lock screen, notification,
/// headphones) come here too.
@Riverpod(keepAlive: true)
class Listening extends _$Listening {
  /// key `teaching_continuous`: false once the member turned it off.
  static const continuousKey = 'teaching_continuous';

  /// « Previous » further than this in a message goes back to its start.
  static const restartAfter = Duration(seconds: 5);

  Timer? _sleep;
  bool _moving = false;

  @override
  ListeningState build() {
    ref
      ..listen(nowPlayingProvider, _follow)
      ..onDispose(() => _sleep?.cancel());
    return ListeningState(
      continuous:
          ref.read(sharedPreferencesProvider).getBool(continuousKey) ?? true,
    );
  }

  NowPlaying get _player => ref.read(nowPlayingProvider.notifier);

  void _follow(PlayerSnapshot? before, PlayerSnapshot now) {
    if (now.teaching == null) {
      // closed (the cross, signing out): nothing follows, nothing to stop
      if (state.queue.items.isNotEmpty || state.sleeping) {
        _sleep?.cancel();
        _set(const PlayQueue(), sleepUntil: null, sleepAtEnd: false);
      }
      return;
    }
    if (now.completed && !(before?.completed ?? false) && !_moving) {
      unawaited(_ended());
    }
  }

  Future<void> _ended() async {
    if (state.sleepAtEnd) {
      _set(state.queue, sleepUntil: null, sleepAtEnd: false);
      return;
    }
    if (state.continuous) {
      await next();
    }
  }

  /// The state with [queue], and the buttons of the system that go with it.
  void _set(PlayQueue queue, {DateTime? sleepUntil, bool? sleepAtEnd}) {
    state = ListeningState(
      queue: queue,
      continuous: state.continuous,
      sleepUntil: sleepUntil,
      sleepAtEnd: sleepAtEnd ?? false,
    );
    ref
        .read(teachingPlayerProvider)
        .setSkips(
          next: queue.hasNext || queue.hasMorePages ? next : null,
          previous: queue.current == null ? null : previous,
        );
  }

  void _move(PlayQueue queue) =>
      _set(queue, sleepUntil: state.sleepUntil, sleepAtEnd: state.sleepAtEnd);

  /// Plays [teaching]; what follows is the rest of [among], the list it was
  /// played from. Without a list: the rest of the queue when it is in it,
  /// else nothing.
  Future<void> start(Teaching teaching, {TeachingList? among}) async {
    _move(
      among == null
          ? state.queue.pointingAt(teaching) ?? PlayQueue.around(teaching, null)
          : PlayQueue.around(teaching, among),
    );
    await _player.listen(teaching);
  }

  /// The next message: true once one plays. One that can't be opened
  /// (no network) gives way to the next one kept on the phone; when none
  /// is, the player closes.
  Future<bool> next() async {
    if (_moving) {
      return false;
    }
    _moving = true;
    try {
      final files = ref.read(teachingFilesProvider);
      var queue = state.queue;
      var index = queue.index + 1;
      var refused = false;
      while (true) {
        if (index >= queue.items.length) {
          final longer = refused ? null : await _nextPage(queue);
          if (longer == null || longer.items.length == queue.items.length) {
            break;
          }
          queue = longer;
          continue;
        }
        final candidate = queue.items[index];
        if (refused && await files.fileOf(candidate) == null) {
          index++;
          continue;
        }
        try {
          _move(queue.at(index));
          await _player.listen(candidate);
          return true;
        } on Object {
          // no network (or a file that won't open): what is kept, further on
          refused = true;
          index++;
        }
      }
      if (refused) {
        // the player holds a message it could not open: nothing to hear
        await _player.stop();
      } else {
        _move(queue.at(state.queue.index));
      }
      return false;
    } finally {
      _moving = false;
    }
  }

  /// The next page of the list the queue came from; null when it has none
  /// or can't be read.
  Future<PlayQueue?> _nextPage(PlayQueue queue) async {
    final query = queue.query;
    if (query == null || !queue.hasMorePages) {
      return null;
    }
    try {
      final page = await ref
          .read(teachingsApiProvider)
          .list(query: query, page: queue.page + 1, size: Teachings.pageSize);
      return queue.extended(page.items, total: page.total);
    } on Object {
      return null;
    }
  }

  /// The message before; once this one is begun (or is the first), its
  /// start.
  Future<void> previous() async {
    final now = ref.read(nowPlayingProvider);
    final queue = state.queue;
    if (now.position > restartAfter || !queue.hasPrevious) {
      await _player.seek(Duration.zero);
      return;
    }
    await _open(queue.index - 1);
  }

  /// A message of the queue, touched in « À suivre ».
  Future<void> jumpTo(Teaching teaching) async {
    final index = state.queue.items.indexWhere((one) => one.id == teaching.id);
    if (index >= 0) {
      await _open(index);
    }
  }

  Future<void> _open(int index) async {
    final before = state.queue;
    _moving = true;
    try {
      _move(before.at(index));
      await _player.listen(before.items[index]);
    } on Object {
      _move(before);
      rethrow;
    } finally {
      _moving = false;
    }
  }

  Future<void> setContinuous({required bool on}) async {
    state = ListeningState(
      queue: state.queue,
      continuous: on,
      sleepUntil: state.sleepUntil,
      sleepAtEnd: state.sleepAtEnd,
    );
    await ref.read(sharedPreferencesProvider).setBool(continuousKey, on);
  }

  /// The sleep timer: the player pauses in [after].
  void sleepIn(Duration after) {
    _sleep?.cancel();
    _sleep = Timer(after, () {
      _set(state.queue, sleepUntil: null, sleepAtEnd: false);
      unawaited(ref.read(teachingPlayerProvider).pause());
    });
    _set(state.queue, sleepUntil: DateTime.now().add(after));
  }

  /// The sleep timer: nothing plays after the message heard.
  void sleepAtEnd() {
    _sleep?.cancel();
    _set(state.queue, sleepAtEnd: true);
  }

  void cancelSleep() {
    _sleep?.cancel();
    _set(state.queue, sleepUntil: null, sleepAtEnd: false);
  }
}
