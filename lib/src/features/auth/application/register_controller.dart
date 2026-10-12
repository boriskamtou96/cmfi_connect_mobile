import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/session/session.dart';
import '../../../core/utils/phone.dart';
import '../../members/domain/member.dart';
import '../infrastructure/auth_api.dart';

part 'register_controller.g.dart';

/// Step 1 of the sign-up: creates the account, then signs in with it
/// (the API gives no token on register).
@riverpod
class RegisterController extends _$RegisterController {
  /// The account exists: a retry (e.g. after a network error on login) only signs in.
  bool _registered = false;

  @override
  FutureOr<void> build() {}

  /// True once the account exists and the user is signed in.
  Future<bool> submit({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String username,
    String? email,
  }) async {
    state = const AsyncLoading();

    final phone = toInternationalPhone(phoneNumber);
    final result = await AsyncValue.guard(() async {
      final api = ref.read(authApiProvider);
      if (!_registered) {
        await api.register(
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          phoneNumber: phone,
          password: password,
          username: UsernameRules.normalize(username),
          email: email?.trim(),
        );
        _registered = true;
      }
      final response = await api.login(phoneNumber: phone, password: password);
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
