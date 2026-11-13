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
/// its order, and the place reached in it. At the end of the pages read,
/// [hasMorePages] says the list goes on at the server.
@immutable
class PlayQueue {
  const PlayQueue({
    this.items = const [],
    this.index = -1,
    this.query,
    this.page = 1,
    this.total = 0,
  });

  /// [teaching] in its [list]; alone when no list is given or when it is not
  /// in it.
  factory PlayQueue.around(Teaching teaching, TeachingList? list) {
    final index = list?.items.indexWhere((one) => one.id == teaching.id) ?? -1;
    if (list == null || index < 0) {
      return PlayQueue(items: [teaching], index: 0, total: 1);
    }
    return PlayQueue(
      items: list.items,
      index: index,
      query: list.query,
      page: list.page,
      total: list.total ?? list.items.length,
    );
  }

  final List<Teaching> items;
  final int index;
  final TeachingQuery? query;
  final int page;
  final int total;

  Teaching? get current =>
      index >= 0 && index < items.length ? items[index] : null;

  /// What comes after the message heard, in order.
  List<Teaching> get upcoming =>
      index + 1 < items.length ? items.sublist(index + 1) : const [];

  bool get hasNext => index + 1 < items.length;
  bool get hasPrevious => index > 0;

  /// The server has messages after the last one read.
  bool get hasMorePages => query != null && items.length < total;

  PlayQueue at(int index) => PlayQueue(
    items: items,
    index: index,
    query: query,
    page: page,
    total: total,
  );

  /// The queue at [teaching]; null when it does not hold it.
  PlayQueue? pointingAt(Teaching teaching) {
    final index = items.indexWhere((one) => one.id == teaching.id);
    return index < 0 ? null : at(index);
  }

  /// With the next page: what it brings that is new, the place kept.
  PlayQueue extended(List<Teaching> more, {int? total}) => PlayQueue(
    items: [
      ...items,
      ...more.where((one) => items.every((known) => known.id != one.id)),
    ],
    index: index,
    query: query,
    page: page + 1,
    total: total ?? this.total,
  );
}
