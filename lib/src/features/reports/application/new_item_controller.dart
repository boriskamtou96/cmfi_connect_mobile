import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/activity_type.dart';
import '../infrastructure/activities_api.dart';
import 'reports_providers.dart';

part 'new_item_controller.g.dart';

/// Creates a personal report item.
@riverpod
class NewItemController extends _$NewItemController {
  @override
  FutureOr<void> build() {}

  /// The created item, or null on error (the error is in [state]).
  Future<ActivityType?> submit({
    required String code,
    required String label,
    required bool tracksQuantity,
    required String unit,
    required bool tracksDuration,
  }) async {
    state = const AsyncLoading();
    ActivityType? created;

    final result = await AsyncValue.guard(() async {
      created = await ref
          .read(activitiesApiProvider)
          .create(
            code: code.trim().toUpperCase(),
            label: label.trim(),
            tracksQuantity: tracksQuantity,
            quantityUnit: unit.trim(),
            tracksDuration: tracksDuration,
          );
      // the days being filled in now list the new item
      ref.invalidate(activitiesProvider);
    });

    if (ref.mounted) {
      state = result;
    }
    return result.hasError ? null : created;
  }
}
