import 'package:flutter/foundation.dart';

/// How the member knew the verse: the four buttons after it is shown.
enum MemoryGrade { again, hard, good, easy }

/// Where a verse is: never reviewed, being learnt, known (seen again in 3
/// weeks or more).
enum MemoryStage { fresh, learning, known }

/// What is shown of the verse before it is recited: all of it, with words
/// hidden, the first letter of each word, or only the reference.
enum MemoryHint { full, gaps, initials, none }

/// A verse (or a few that follow) learnt by heart, and when to see it again.
/// Reviews come further and further apart as it is known (a light SM-2:
/// 1 day, 3 days, then the last gap times the ease of the verse); « Encore »
/// starts it again.
@immutable
class MemoryVerse {
  const MemoryVerse({
    required this.book,
    required this.chapter,
    required this.first,
    required this.last,
    required this.label,
    required this.text,
    required this.version,
    required this.added,
    required this.due,
    this.reps = 0,
    this.interval = 0,
    this.ease = 2.5,
    this.lapses = 0,
    this.knownOn,
  });

  factory MemoryVerse.fromJson(Map<String, dynamic> json) => MemoryVerse(
    book: json['book'] as String,
    chapter: json['chapter'] as int,
    first: json['first'] as int,
    last: json['last'] as int,
    label: json['label'] as String,
    text: json['text'] as String,
    version: json['version'] as String? ?? '',
    added: DateTime.parse(json['added'] as String),
    due: DateTime.parse(json['due'] as String),
    reps: json['reps'] as int? ?? 0,
    interval: json['interval'] as int? ?? 0,
    ease: (json['ease'] as num?)?.toDouble() ?? 2.5,
    lapses: json['lapses'] as int? ?? 0,
    knownOn: json['known_on'] == null
        ? null
        : DateTime.parse(json['known_on'] as String),
  );

  /// USFM ("JHN"), the chapter, the first and the last verse.
  final String book;
  final int chapter;
  final int first;
  final int last;

  /// "Jean 3:16-17", in the Bible it was taken from.
  final String label;

  /// "Car Dieu a tant aimé le monde…" (the verses one after the other).
  final String text;

  /// "LSG".
  final String version;
  final DateTime added;

  /// The day to see it again (at midnight).
  final DateTime due;

  /// Reviews in a row without « Encore ».
  final int reps;

  /// Days until the next review.
  final int interval;
  final double ease;

  /// The times it was forgotten.
  final int lapses;

  /// The first day it became known.
  final DateTime? knownOn;

  /// "JHN.3.16-17": one verse is kept once.
  String get id => '$book.$chapter.$first${last > first ? '-$last' : ''}';

  /// From 21 days apart, a verse is known.
  static const knownAfter = 21;

  MemoryStage get stage => reps == 0
      ? MemoryStage.fresh
      : interval >= knownAfter
      ? MemoryStage.known
      : MemoryStage.learning;

  bool isDue(DateTime day) => !due.isAfter(day);

  /// What to show first: the gaps for a new verse, the first letters while
  /// it is learnt, nothing once it holds.
  MemoryHint get hint => reps == 0
      ? MemoryHint.gaps
      : reps < 3
      ? MemoryHint.initials
      : MemoryHint.none;

  /// The days until the next review after [grade] (0: again today).
  int intervalAfter(MemoryGrade grade) {
    final good = switch (reps) {
      0 => 1,
      1 => 3,
      _ => (interval * ease).round().clamp(interval + 1, 3650),
    };
    return switch (grade) {
      MemoryGrade.again => 0,
      MemoryGrade.hard =>
        reps == 0 ? 1 : (interval * 1.2).round().clamp(interval + 1, 3650),
      MemoryGrade.good => good,
      MemoryGrade.easy => reps == 0 ? 4 : (good * 1.3).round(),
    };
  }

  /// The verse after a review on [day].
  MemoryVerse reviewed(MemoryGrade grade, DateTime day) {
    final next = intervalAfter(grade);
    final ease =
        (this.ease +
                switch (grade) {
                  MemoryGrade.again => -0.2,
                  MemoryGrade.hard => -0.15,
                  MemoryGrade.good => 0.0,
                  MemoryGrade.easy => 0.15,
                })
            .clamp(1.3, 3.0);
    final again = grade == MemoryGrade.again;
    return MemoryVerse(
      book: book,
      chapter: chapter,
      first: first,
      last: last,
      label: label,
      text: text,
      version: version,
      added: added,
      due: DateTime(day.year, day.month, day.day + next),
      reps: again ? 0 : reps + 1,
      interval: next,
      ease: ease,
      lapses: again ? lapses + 1 : lapses,
      knownOn: knownOn ?? (next >= knownAfter ? day : null),
    );
  }

  Map<String, dynamic> toJson() => {
    'book': book,
    'chapter': chapter,
    'first': first,
    'last': last,
    'label': label,
    'text': text,
    'version': version,
    'added': _day(added),
    'due': _day(due),
    'reps': reps,
    'interval': interval,
    'ease': ease,
    'lapses': lapses,
    if (knownOn != null) 'known_on': _day(knownOn!),
  };

  static String _day(DateTime day) => DateTime.utc(
    day.year,
    day.month,
    day.day,
  ).toIso8601String().substring(0, 10);
}

final _word = RegExp(r"[\p{L}\p{N}]+(?:['’][\p{L}\p{N}]+)*", unicode: true);

/// [text] with some words hidden ("Car Dieu a ____ aimé le ____…"): about one
/// in three of those of 3 letters or more, always the same for a verse
/// ([seed]).
String withGaps(String text, int seed) {
  var index = 0;
  return text.replaceAllMapped(_word, (match) {
    final word = match[0]!;
    index++;
    if (word.length < 3 || (index + seed) % 3 != 0) {
      return word;
    }
    return '_' * word.length.clamp(3, 8);
  });
}

/// The first letter of each word, the punctuation kept ("C D a t a l m…").
String initialsOf(String text) =>
    text.replaceAllMapped(_word, (match) => match[0]!.characters.first);

extension on String {
  Iterable<String> get characters => runes.map(String.fromCharCode);
}
