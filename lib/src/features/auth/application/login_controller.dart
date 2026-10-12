import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/session/session.dart';
import '../../../core/utils/phone.dart';
import '../infrastructure/auth_api.dart';

part 'login_controller.g.dart';

/// State of the login form: AsyncData (idle or done), AsyncLoading, AsyncError(AppException).
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  /// True once signed in: the screen then opens the app.
  Future<bool> submit({
    required String phoneNumber,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final response = await ref
          .read(authApiProvider)
          .login(
            phoneNumber: toInternationalPhone(phoneNumber),
            password: password,
          );
      await ref
          .read(sessionProvider.notifier)
          .signIn(response.accessToken, account: response.account);
    });

    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}
