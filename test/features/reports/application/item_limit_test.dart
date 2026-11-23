import 'package:cmfi_connect/src/features/reports/application/item_limit.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';

/// [count] personal items, after the sample ones' ids.
List<ActivityType> personalItems(int count) => [
  for (var i = 0; i < count; i++)
    ActivityType(
      id: 200 + i,
      code: 'P$i',
      label: 'Perso $i',
      tracksDuration: true,
    ),
];

void main() {
  final standards = sampleActivities.where((item) => item.isStandard);

  test('the standard items never count', () {
    final quota = ItemQuota.of([...standards], premium: false);

    expect(quota.used, 0);
    expect(quota.locked, isFalse);
  });

  test('only the personal items count against the 5 free ones', () {
    final four = ItemQuota.of([
      ...standards,
      ...personalItems(4),
    ], premium: false);
    final five = ItemQuota.of([
      ...standards,
      ...personalItems(5),
    ], premium: false);

    expect(four.used, 4);
    expect(four.locked, isFalse);
    expect(five.used, 5);
    expect(five.limit, 5);
    expect(five.locked, isTrue);
    expect(five.counted, isTrue);
  });

  test('more than 5 (made before the rule) stay counted and locked', () {
    final quota = ItemQuota.of(personalItems(8), premium: false);

    expect(quota.used, 8);
    expect(quota.locked, isTrue);
  });

  test('Premium has no limit and no counter', () {
    final quota = ItemQuota.of(personalItems(12), premium: true);

    expect(quota.locked, isFalse);
    expect(quota.counted, isFalse);
  });
}
