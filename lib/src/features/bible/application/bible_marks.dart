import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/bible.dart';

part 'bible_marks.freezed.dart';
part 'bible_marks.g.dart';

/// A verse the user highlighted ([color]) or kept ([bookmarked]), or both.
/// [text] is the verse as it was read, to list it without network.
@freezed
abstract class BibleMark with _$BibleMark {
  const factory BibleMark({
    /// The verse, the same in every version ("JHN.3.16").
    required String key,
    required String text,

    /// The version's abbreviation when it was marked ("LSG").
    required String version,
    required DateTime at,

    /// Index in [BibleMarks.colors]; null: not highlighted.
    int? color,
    @Default(false) bool bookmarked,
  }) = _BibleMark;

  const BibleMark._();

  factory BibleMark.fromJson(Map<String, dynamic> json) =>
      _$BibleMarkFromJson(json);

  BibleRef get ref => BibleRef.parse(key)!;
}

/// The highlights and favourite verses, kept on the phone (by verse key).
@Riverpod(keepAlive: true)
class BibleMarks extends _$BibleMarks {
  static const _key = 'bible_marks';

  /// How many highlight colours there are (yellow, green, blue, pink).
  static const colors = 4;

  @override
  Map<String, BibleMark> build() {
    final json = ref.watch(sharedPreferencesProvider).getString(_key);
    if (json == null) {
      return const {};
    }
    try {
      return {
        for (final raw in jsonDecode(json) as List<dynamic>)
          if (BibleMark.fromJson(raw as Map<String, dynamic>) case final mark
              when BibleRef.parse(mark.key) != null)
            mark.key: mark,
      };
    } on Object {
      return const {};
    }
  }

  /// Highlights [verses] with [color] (null: removes the highlight).
  Future<void> highlight(
    List<({BibleRef ref, String text})> verses,
    int? color, {
    required String version,
  }) => _change(verses, version, (mark) => mark.copyWith(color: color));

  /// Adds [verses] to the favourites, or takes them out.
  Future<void> bookmark(
    List<({BibleRef ref, String text})> verses,
    bool bookmarked, {
    required String version,
  }) =>
      _change(verses, version, (mark) => mark.copyWith(bookmarked: bookmarked));

  Future<void> remove(String key) async {
    state = {...state}..remove(key);
    await _save();
  }

  Future<void> _change(
    List<({BibleRef ref, String text})> verses,
    String version,
    BibleMark Function(BibleMark mark) change,
  ) async {
    final next = {...state};
    final now = DateTime.now();
    for (final verse in verses) {
      final key = verse.ref.key;
      final mark = change(
        (next[key] ??
                BibleMark(
                  key: key,
                  text: verse.text,
                  version: version,
                  at: now,
                ))
            .copyWith(text: verse.text, version: version, at: now),
      );
      if (mark.color == null && !mark.bookmarked) {
        next.remove(key);
      } else {
        next[key] = mark;
      }
    }
    state = next;
    await _save();
  }

  Future<void> _save() => ref
      .read(sharedPreferencesProvider)
      .setString(
        _key,
        jsonEncode([for (final mark in state.values) mark.toJson()]),
      );
}
