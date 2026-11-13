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
}
