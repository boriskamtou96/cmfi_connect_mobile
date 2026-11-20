import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/teaching.dart';
import '../domain/teaching_query.dart';
import '../infrastructure/teachings_api.dart';
import 'teaching_library.dart';

part 'teaching_batch.g.dart';

/// Many teachings kept on the phone at once: an edition, or a day of it.
/// [scope] says which, for the screen to show it under way there; [done]
/// counts the messages already tried (kept, or failed: what is missing can
/// be asked again).
@immutable
class TeachingBatchState {
  const TeachingBatchState({this.scope, this.total = 0, this.done = 0});

  final String? scope;
  final int total;
  final int done;

  bool get running => scope != null && done < total;
}

/// Downloads the messages of an edition or a day, one after the other
/// (through [TeachingDownloads], so each row shows its own progress), and
/// removes them again. Kept alive: it goes on when the page is left. Stopped
/// by [stop], and by signing out.
@Riverpod(keepAlive: true)
class TeachingBatch extends _$TeachingBatch {
  var _stopped = false;
  int? _current;

  @override
  TeachingBatchState build() => const TeachingBatchState();

  /// "edition:7", "edition:7:day:3": what a batch is about.
  static String scopeOf(int edition, int? day) =>
      day == null ? 'edition:$edition' : 'edition:$edition:day:$day';

  /// Every message of [query], all its pages read.
  Future<List<Teaching>> messagesOf(TeachingQuery query) async {
    final api = ref.read(teachingsApiProvider);
    final all = <Teaching>[];
    for (var page = 1; ; page++) {
      final result = await api.list(query: query, page: page, size: 50);
      all.addAll(result.items);
      if (result.items.isEmpty || all.length >= result.total) {
        return all;
      }
    }
  }

  /// Keeps on the phone those of [teachings] that are not yet, one after
  /// the other. Nothing when a batch is under way.
  Future<void> start(String scope, List<Teaching> teachings) async {
    if (state.running) {
      return;
    }
    final downloads = ref.read(teachingDownloadsProvider.notifier);
    final kept = (await ref.read(teachingDownloadsProvider.future)).kept;
    final missing = [
      for (final teaching in teachings)
        if (!kept.containsKey(teaching.id)) teaching,
    ];
    if (missing.isEmpty || !ref.mounted) {
      return;
    }
    _stopped = false;
    state = TeachingBatchState(scope: scope, total: missing.length);
    for (final teaching in missing) {
      if (_stopped) {
        break;
      }
      _current = teaching.id;
      try {
        await downloads.download(teaching);
      } on Object {
        // stopped, or no network: it stays missing, to be asked again
      }
      if (!ref.mounted) {
        return;
      }
      state = TeachingBatchState(
        scope: scope,
        total: missing.length,
        done: state.done + 1,
      );
    }
    _current = null;
    state = const TeachingBatchState();
  }

  /// Stops the batch: the message downloading now too; those kept stay.
  void stop() {
    _stopped = true;
    final current = _current;
    if (current != null) {
      ref.read(teachingDownloadsProvider.notifier).cancel(current);
    }
  }

  /// Takes [teachings] off the phone.
  Future<void> removeAll(Iterable<Teaching> teachings) async {
    final downloads = ref.read(teachingDownloadsProvider.notifier);
    for (final teaching in teachings.toList()) {
      await downloads.remove(teaching);
    }
  }
}
