import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../infrastructure/profile_api.dart';
import 'current_profile.dart';

part 'church_form_controller.g.dart';

/// Saves the profile form: church fields, and the name when it is edited.
@riverpod
class ChurchFormController extends _$ChurchFormController {
  @override
  FutureOr<void> build() {}

  /// True once saved. [firstName] / [lastName] null keep the current name.
  Future<bool> submit({
    String? firstName,
    String? lastName,
    required String country,
    required String city,
    required String church,
    required String assembly,
  }) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final current = await ref.read(currentProfileProvider.future);
      final profile = current.copyWith(
        firstName: firstName?.trim() ?? current.firstName,
        lastName: lastName?.trim() ?? current.lastName,
        country: country.trim(),
        city: city.trim(),
        church: church.trim(),
        assembly: assembly.trim(),
      );
      final api = ref.read(profileApiProvider);
      await (profile.exists ? api.update(profile) : api.create(profile));
      ref.invalidate(currentProfileProvider);
    });

    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}
