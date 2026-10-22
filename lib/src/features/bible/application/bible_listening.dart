import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/voice_reader.dart';
import '../domain/bible.dart';
import 'bible_library.dart';
import 'bible_position.dart';
import 'bible_settings.dart';

part 'bible_listening.g.dart';

/// What is heard: the [chapters] to read (one, or the day's reading of the
/// plan), the one heard ([index]) and its verse; [playing] false while
/// paused.
@immutable
class BibleListeningState {
  const BibleListeningState({
    required this.chapters,
    this.index = 0,
    this.verse = 1,
    this.playing = true,
  });

  final List<BibleRef> chapters;
  final int index;
  final int verse;
  final bool playing;

  BibleRef get chapter => chapters[index];

  BibleListeningState copyWith({int? index, int? verse, bool? playing}) =>
      BibleListeningState(
        chapters: chapters,
        index: index ?? this.index,
        verse: verse ?? this.verse,
        playing: playing ?? this.playing,
      );
}

/// The Bible read aloud by the phone's voice (the voice of the retreats,
/// offline, in the language of the version read): a chapter, or the day's
/// chapters of the reading plan one after the other, verse by verse. The
/// verse heard is brought into view and lit (`BibleFocus`). null when
/// nothing is heard.
@Riverpod(keepAlive: true)
class BibleListening extends _$BibleListening {
  // a new start, pause or stop ends the loop under way
  var _run = 0;

  @override
  BibleListeningState? build() => null;

  /// Reads [chapters] from verse [verse] of the first.
  Future<void> start(List<BibleRef> chapters, {int verse = 1}) async {
    if (chapters.isEmpty) {
      return;
    }
    state = BibleListeningState(chapters: chapters, verse: verse);
    await _read();
  }

  Future<void> pause() async {
    final current = state;
    if (current == null || !current.playing) {
      return;
    }
    _run++;
    state = current.copyWith(playing: false);
    await ref.read(voiceReaderProvider).stop();
  }

  /// Goes on from the verse it stopped at.
  Future<void> resume() async {
    final current = state;
    if (current == null || current.playing) {
      return;
    }
    state = current.copyWith(playing: true);
    await _read();
  }

  Future<void> stop() async {
    _run++;
    state = null;
    await ref.read(voiceReaderProvider).stop();
  }

  Future<void> _read() async {
    final run = ++_run;
    final voice = ref.read(voiceReaderProvider);
    final version = ref.read(bibleVersionProvider);
    while (true) {
      final current = state;
      if (current == null || run != _run) {
        return;
      }
      final place = current.chapter;
      final BibleChapter chapter;
      try {
        chapter = await loadChapter(ref, version.id, place.book, place.chapter);
      } on Object {
        // not on the phone and no network: nothing more to read
        if (run == _run) {
          state = null;
        }
        return;
      }
      final verses = chapter.verses
          .where((verse) => verse.number >= current.verse)
          .toList();
      for (final verse in verses) {
        if (run != _run) {
          return;
        }
        state = state?.copyWith(verse: verse.number);
        unawaited(
          ref
              .read(bibleFocusProvider.notifier)
              .show(BibleRef(place.book, place.chapter, verse.number)),
        );
        await voice.speakToEnd(verse.text, version.language);
      }
      if (run != _run) {
        return;
      }
      final next = current.index + 1;
      if (next >= current.chapters.length) {
        state = null;
        return;
      }
      state = current.copyWith(index: next, verse: 1);
    }
  }
}

/// A chapter of [version], kept loaded while it is read.
Future<BibleChapter> loadChapter(
  Ref ref,
  String version,
  String book,
  int number,
) async {
  final provider = bibleChapterProvider(version, book, number);
  final subscription = ref.listen(provider, (_, _) {});
  try {
    return await ref.read(provider.future);
  } finally {
    subscription.close();
  }
}
