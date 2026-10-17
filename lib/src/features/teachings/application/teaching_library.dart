import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/media_images.dart';
import '../../../core/storage/preferences.dart';
import '../domain/teaching.dart';
import '../infrastructure/teaching_files.dart';

part 'teaching_library.g.dart';

/// A download stopped by the member: not an error to show.
bool isCancel(Object error) =>
    error is DioException && error.type == DioExceptionType.cancel;

/// Where the member is in a teaching (seconds), and its length.
typedef Listened = ({int position, int duration});

/// How far each teaching was heard (key `teaching_progress`: id → [position,
/// duration] in seconds), to start again where it stopped and to show a bar
/// in the list. Kept at sign-out: it is about public messages.
@Riverpod(keepAlive: true)
class TeachingProgress extends _$TeachingProgress {
  static const key = 'teaching_progress';

  /// Within the last 30 seconds: heard (the closing words, the silence).
  static const _end = 30;

  @override
  Map<int, Listened> build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    if (raw == null) {
      return const {};
    }
    try {
      return {
        for (final MapEntry(:key, :value)
            in (jsonDecode(raw) as Map<String, dynamic>).entries)
          int.parse(key): (
            position: (value as List<dynamic>)[0] as int,
            duration: value[1] as int,
          ),
      };
    } on Object {
      return const {};
    }
  }

  Future<void> save(int id, Duration position, Duration? duration) async {
    final length = duration?.inSeconds ?? state[id]?.duration ?? 0;
    state = {
      ...state,
      id: (position: position.inSeconds.clamp(0, 1 << 30), duration: length),
    };
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          key,
          jsonEncode({
            for (final MapEntry(:key, :value) in state.entries)
              '$key': [value.position, value.duration],
          }),
        );
  }

  /// From 0 to 1; 0 when never heard.
  double fraction(int id) {
    final listened = state[id];
    if (listened == null || listened.duration <= 0) {
      return 0;
    }
    return finished(id) ? 1 : listened.position / listened.duration;
  }

  bool finished(int id) {
    final listened = state[id];
    return listened != null &&
        listened.duration > 0 &&
        listened.position >= listened.duration - _end;
  }

  /// Where to start [id] again: where it stopped (3 seconds before, to hear
  /// the end of the sentence), or the beginning once heard.
  Duration resumeAt(int id) {
    final listened = state[id];
    if (listened == null || finished(id) || listened.position < 10) {
      return Duration.zero;
    }
    return Duration(seconds: listened.position - 3);
  }
}

/// The teachings kept on the phone (key `teaching_downloads`: the teachings
/// themselves, to list them without network) and those downloading.
class DownloadsState {
  const DownloadsState({this.kept = const {}, this.progress = const {}});

  final Map<int, Teaching> kept;

  /// id → 0 to 1, while downloading.
  final Map<int, double> progress;

  bool has(int id) => kept.containsKey(id);
}

@Riverpod(keepAlive: true)
class TeachingDownloads extends _$TeachingDownloads {
  static const key = 'teaching_downloads';

  final _cancels = <int, CancelToken>{};

  @override
  Future<DownloadsState> build() async {
    final files = ref.watch(teachingFilesProvider);
    final raw = ref.watch(sharedPreferencesProvider).getString(key);
    final kept = <int, Teaching>{};
    if (raw != null) {
      try {
        for (final json in jsonDecode(raw) as List<dynamic>) {
          final teaching = Teaching.fromJson(json as Map<String, dynamic>);
          // a file the system removed is no longer kept
          if (await files.fileOf(teaching) != null) {
            kept[teaching.id] = teaching;
          }
        }
      } on Object {
        // written by an older version of the app
      }
    }
    return DownloadsState(kept: kept);
  }

  Future<void> _write(Map<int, Teaching> kept) => ref
      .read(sharedPreferencesProvider)
      .setString(
        key,
        jsonEncode([for (final teaching in kept.values) teaching.toJson()]),
      );

  /// Keeps [teaching] on the phone. Throws when the download fails.
  Future<void> download(Teaching teaching) async {
    final current = await future;
    if (current.has(teaching.id) || current.progress.containsKey(teaching.id)) {
      return;
    }
    void set(Map<int, Teaching> kept, Map<int, double> progress) {
      if (ref.mounted) {
        state = AsyncData(DownloadsState(kept: kept, progress: progress));
      }
    }

    set(current.kept, {...current.progress, teaching.id: 0});
    final cancel = _cancels[teaching.id] = CancelToken();
    try {
      await ref
          .read(teachingFilesProvider)
          .download(
            teaching,
            ref.read(mediaImagesProvider).resolve(teaching.audio.url),
            cancel: cancel,
            onProgress: (progress) {
              final now = state.value ?? current;
              set(now.kept, {...now.progress, teaching.id: progress});
            },
          );
      final now = state.value ?? current;
      final kept = {...now.kept, teaching.id: teaching};
      set(kept, {...now.progress}..remove(teaching.id));
      await _write(kept);
    } on Object {
      final now = state.value ?? current;
      set(now.kept, {...now.progress}..remove(teaching.id));
      rethrow;
    } finally {
      _cancels.remove(teaching.id);
    }
  }

  /// Stops a download under way.
  void cancel(int id) => _cancels[id]?.cancel();

  Future<void> remove(Teaching teaching) async {
    final current = await future;
    await ref.read(teachingFilesProvider).delete(teaching);
    final kept = {...current.kept}..remove(teaching.id);
    state = AsyncData(DownloadsState(kept: kept, progress: current.progress));
    await _write(kept);
  }
}
