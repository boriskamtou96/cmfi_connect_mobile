import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/reports/application/new_item_controller.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/activities_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/fakes.dart';

void main() {
  test('a taken code leaves the CONFLICT error in the state', () async {
    final container = ProviderContainer(
      overrides: [activitiesApiProvider.overrideWithValue(FakeActivitiesApi())],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(newItemControllerProvider, (_, _) {});
    addTearDown(subscription.close);

    final created = await container
        .read(newItemControllerProvider.notifier)
        .submit(
          code: 'LB',
          label: 'Lecture',
          tracksQuantity: true,
          unit: '',
          tracksDuration: false,
        );

    expect(created, isNull);
    expect(
      container.read(newItemControllerProvider).error,
      isA<ApiException>().having((e) => e.code, 'code', 'CONFLICT'),
    );
  });
}
