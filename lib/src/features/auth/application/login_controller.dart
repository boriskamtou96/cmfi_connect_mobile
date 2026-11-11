import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/session/account.dart';
import '../../../core/session/session.dart';
import '../infrastructure/auth_api.dart';

part 'login_controller.g.dart';

/// State of the login form: AsyncData (idle or done), AsyncLoading, AsyncError(AppException).
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  /// The account once signed in (null on failure): the screen then opens the
  /// app, or asks for a new password after a temporary one.
  /// [phoneNumber] is international ("+237690000001").
  Future<Account?> submit({
    required String phoneNumber,
    required String password,
  }) async {
    state = const AsyncLoading();

    Account? account;
    final result = await AsyncValue.guard(() async {
      final response = await ref
          .read(authApiProvider)
          .login(phoneNumber: phoneNumber, password: password);
      await ref
          .read(sessionProvider.notifier)
          .signIn(response.accessToken, account: response.account);
      account = response.account;
    });

    if (ref.mounted) {
      state = result;
    }
    return result.hasError ? null : account;
  }
}
