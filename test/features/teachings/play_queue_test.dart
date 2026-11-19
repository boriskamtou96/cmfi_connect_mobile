import 'package:cmfi_connect/src/features/teachings/domain/play_queue.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching_query.dart';
import 'package:flutter_test/flutter_test.dart';

Teaching _message(int id) => Teaching(
  id: id,
  title: 'Message $id',
  audio: TeachingAudio(id: 100 + id, url: '/v1/media/$id.mp3'),
);

void main() {
  final list = [for (var id = 1; id <= 4; id++) _message(id)];

  test('a message played from a list has the rest of it after it', () {
    final queue = PlayQueue.around(list[1], TeachingList(list));

    expect(queue.current, list[1]);
    expect(queue.upcoming, [list[2], list[3]]);
    expect(queue.hasNext, isTrue);
    expect(queue.hasPrevious, isTrue);
    expect(queue.hasMorePages, isFalse);
  });

  test('alone, or out of the list given, it is the whole queue', () {
    for (final queue in [
      PlayQueue.around(list[0], null),
      PlayQueue.around(_message(9), TeachingList(list)),
    ]) {
      expect(queue.items, hasLength(1));
      expect(queue.index, 0);
      expect(queue.hasNext, isFalse);
      expect(queue.hasPrevious, isFalse);
      expect(queue.upcoming, isEmpty);
    }
  });

  test('the last of a page knows the list goes on', () {
    const query = TeachingQuery(category: 'camps');
    final queue = PlayQueue.around(
      list[3],
      TeachingList(list, query: query, total: 6),
    );

    expect(queue.hasNext, isFalse);
    expect(queue.hasMorePages, isTrue);

    // the next page: what is new only, the place kept
    final longer = queue.extended([list[3], _message(5), _message(6)]);
    expect(longer.items.map((one) => one.id), [1, 2, 3, 4, 5, 6]);
    expect(longer.current, list[3]);
    expect(longer.page, 2);
    expect(longer.hasNext, isTrue);
    expect(longer.hasMorePages, isFalse);
  });

  test('moves to a place, or to a message it holds', () {
    final queue = PlayQueue.around(list[0], TeachingList(list));

    expect(queue.at(2).current, list[2]);
    expect(queue.pointingAt(list[3])?.index, 3);
    expect(queue.pointingAt(_message(9)), isNull);
    expect(const PlayQueue().current, isNull);
  });

  group('a message sent twice is heard once', () {
    // as on the server: the day uploaded under its files' names, then again
    // under its own titles, the same lengths
    Teaching sent(int id, String title, int seconds) => Teaching(
      id: id,
      title: title,
      durationSeconds: seconds,
      audio: TeachingAudio(id: 100 + id, url: '/v1/media/$id.mp3'),
    );
    final day2 = [
      sent(14, 'Jour 2_1 croisade de prière et de jeûne 2026', 2056),
      sent(22, 'Jour 2, message 1', 2056),
      sent(18, 'Jour 2_3 croisade de prière et de jeûne 2026', 494),
      sent(23, 'Jour 2, message 2', 437),
      sent(24, 'Jour 2, message 3', 494),
      sent(16, 'Jour 2_3 croisade de prière et de jeûne 2026', 494),
      // the same name, another length: another message
      sent(30, 'Jour 2, message 1', 600),
    ];

    test('its copies leave the queue, the one heard stays', () {
      final queue = PlayQueue.around(day2[4], TeachingList(day2));

      expect(queue.current?.id, 24);
      expect([for (final one in queue.items) one.id], [14, 23, 24, 30]);
      expect(queue.upcoming.map((one) => one.id), [30]);
      expect(queue.skipped, 3);
    });

    test('the next page brings no copy, and the end is known', () {
      const query = TeachingQuery(category: 'croisades');
      final queue = PlayQueue.around(
        day2[0],
        TeachingList(day2.sublist(0, 3), query: query, total: 7),
      );
      expect(queue.items.map((one) => one.id), [14, 18]);
      expect(queue.hasMorePages, isTrue);

      final whole = queue.extended(day2.sublist(3), total: 7);
      expect(whole.items.map((one) => one.id), [14, 18, 23, 30]);
      expect(whole.hasMorePages, isFalse);
    });
  });
}
