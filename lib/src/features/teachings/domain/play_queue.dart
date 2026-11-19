import 'package:flutter/foundation.dart';

import 'teaching.dart';
import 'teaching_query.dart';

/// The list a message is played from, as its screen shows it: what is on
/// screen, and where it comes from when the server has more of it ([query],
/// the last [page] read, [total] in all).
@immutable
class TeachingList {
  const TeachingList(this.items, {this.query, this.page = 1, this.total});

  final List<Teaching> items;

  /// Null for a list that is whole (the messages kept on the phone).
  final TeachingQuery? query;
  final int page;
  final int? total;
}

/// What is heard and what follows: the list the message was played from, in
/// its order, and the place reached in it. A message sent twice (under its
/// file's name and its own, same length) is heard once: its repeats are left
/// out ([skipped]). At the end of the pages read, [hasMorePages] says the list
/// goes on at the server.
@immutable
class PlayQueue {
  const PlayQueue({
    this.items = const [],
    this.index = -1,
    this.query,
    this.page = 1,
    this.total = 0,
    this.skipped = 0,
  });

  /// [teaching] in its [list], without the repeats; alone when no list is
  /// given or when it is not in it.
  factory PlayQueue.around(Teaching teaching, TeachingList? list) {
    final at = list?.items.indexWhere((one) => one.id == teaching.id) ?? -1;
    if (list == null || at < 0) {
      return PlayQueue(items: [teaching], index: 0, total: 1);
    }
    final kept = <Teaching>[];
    for (final (i, one) in list.items.indexed) {
      // the one heard stays where it is; its copies and the others' go
      final repeat = i == at
          ? false
          : sameMessage(one, teaching) ||
                kept.any((known) => sameMessage(known, one));
      if (!repeat) {
        kept.add(one);
      }
    }
    return PlayQueue(
      items: kept,
      index: kept.indexWhere((one) => one.id == teaching.id),
      query: list.query,
      page: list.page,
      total: list.total ?? list.items.length,
      skipped: list.items.length - kept.length,
    );
  }

  final List<Teaching> items;
  final int index;
  final TeachingQuery? query;
  final int page;

  /// How many the list holds at the server, the repeats included.
  final int total;

  /// The repeats left out of [items].
  final int skipped;

  Teaching? get current =>
      index >= 0 && index < items.length ? items[index] : null;

  /// What comes after the message heard, in order.
  List<Teaching> get upcoming =>
      index + 1 < items.length ? items.sublist(index + 1) : const [];

  bool get hasNext => index + 1 < items.length;
  bool get hasPrevious => index > 0;

  /// The server has messages after the last one read.
  bool get hasMorePages => query != null && items.length + skipped < total;

  PlayQueue at(int index) => PlayQueue(
    items: items,
    index: index,
    query: query,
    page: page,
    total: total,
    skipped: skipped,
  );

  /// The queue at [teaching]; null when it does not hold it.
  PlayQueue? pointingAt(Teaching teaching) {
    final index = items.indexWhere((one) => one.id == teaching.id);
    return index < 0 ? null : at(index);
  }

  /// With the next page: what it brings that is new, the place kept.
  PlayQueue extended(List<Teaching> more, {int? total}) {
    final kept = [...items];
    for (final one in more) {
      if (!kept.any((known) => sameMessage(known, one))) {
        kept.add(one);
      }
    }
    return PlayQueue(
      items: kept,
      index: index,
      query: query,
      page: page + 1,
      total: total ?? this.total,
      skipped: skipped + items.length + more.length - kept.length,
    );
  }
}

/// "Jour 2_3 croisade…", the name of a file.
final _fileName = RegExp(
  r'^\s*jour\s*(\d+)\s*[_.\-]\s*(\d+)\b',
  caseSensitive: false,
);

/// "Jour 2, message 3", the title the admins give it.
final _dayMessage = RegExp(
  r'^\s*jour\s*(\d+)\s*,\s*message\s*(\d+)\s*$',
  caseSensitive: false,
);

/// The same message: the same one, or one sent again under its file's name
/// or its own ("Jour 2_3 …" and "Jour 2, message 3"), of the same length.
bool sameMessage(Teaching a, Teaching b) {
  if (a.id == b.id) {
    return true;
  }
  if (a.durationSeconds <= 0 || a.durationSeconds != b.durationSeconds) {
    return false;
  }
  String key(Teaching one) {
    final match =
        _fileName.firstMatch(one.title) ?? _dayMessage.firstMatch(one.title);
    return match == null
        ? one.title.trim().toLowerCase()
        : 'day ${match[1]} message ${match[2]}';
  }

  return key(a) == key(b);
}
