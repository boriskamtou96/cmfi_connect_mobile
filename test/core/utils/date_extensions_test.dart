import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toApiDate pads month and day', () {
    expect(DateTime(2026, 10, 8).toApiDate(), '2026-10-08');
    expect(DateTime(2026, 1, 5, 23, 59).toApiDate(), '2026-01-05');
  });

  test('parseApiDate reads a local date', () {
    expect(parseApiDate('2026-10-08'), DateTime(2026, 10, 8));
  });

  test('startOfWeek is the Monday', () {
    // Thursday 8 October 2026
    expect(DateTime(2026, 10, 8, 15).startOfWeek, DateTime(2026, 10, 5));
    // a Monday stays itself, a Sunday goes back 6 days
    expect(DateTime(2026, 10, 5).startOfWeek, DateTime(2026, 10, 5));
    expect(DateTime(2026, 10, 11).startOfWeek, DateTime(2026, 10, 5));
  });

  test('daysUntil lists every day, across a month end', () {
    expect(DateTime(2026, 9, 29).daysUntil(DateTime(2026, 10, 2)), [
      DateTime(2026, 9, 29),
      DateTime(2026, 9, 30),
      DateTime(2026, 10, 1),
      DateTime(2026, 10, 2),
    ]);
  });

  test('toDurationLabel', () {
    expect(45.toDurationLabel(), '45 min');
    expect(120.toDurationLabel(), '2 h');
    expect(135.toDurationLabel(), '2 h 15');
    expect(65.toDurationLabel(), '1 h 05');
  });
}
