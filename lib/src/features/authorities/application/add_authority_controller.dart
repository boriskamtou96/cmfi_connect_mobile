import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/authority.dart';
import 'authorities_controller.dart';

part 'add_authority_controller.g.dart';

/// State of the "new authority" form: AsyncLoading while sending, AsyncError(AppException).
@riverpod
class AddAuthorityController extends _$AddAuthorityController {
  @override
  FutureOr<void> build() {}

  /// The added person, or null on error (the error is in [state]).
  Future<Authority?> submit({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required bool isDiscipleMaker,
  }) async {
    state = const AsyncLoading();
    Authority? created;

    final result = await AsyncValue.guard(() async {
      created = await ref
          .read(authoritiesControllerProvider.notifier)
          .add(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            email: email,
            isDiscipleMaker: isDiscipleMaker,
          );
    });

    if (ref.mounted) {
      state = result;
    }
    return result.hasError ? null : created;
  }

  /// Asks a member found by pseudo. Null on error (the error is in [state]).
  Future<Authority?> submitMember({
    required String username,
    required bool isDiscipleMaker,
  }) async {
    state = const AsyncLoading();
    Authority? created;
    final result = await AsyncValue.guard(() async {
      created = await ref
          .read(authoritiesControllerProvider.notifier)
          .addMember(username: username, isDiscipleMaker: isDiscipleMaker);
    });
    if (ref.mounted) {
      state = result;
    }
    return result.hasError ? null : created;
  }
}
