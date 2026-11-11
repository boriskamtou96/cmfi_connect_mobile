import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/social_sign_in.dart';
import '../storage/account_storage.dart';
import '../storage/token_storage.dart';
import 'account.dart';

part 'session.g.dart';

enum SessionStatus { authenticated, unauthenticated }

/// Whether a user is signed in. The router guard and the 401 handling rely on it.
@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  Future<SessionStatus> build() async {
    final token = await ref.watch(tokenStorageProvider).read();
    return token == null
        ? SessionStatus.unauthenticated
        : SessionStatus.authenticated;
  }

  Future<void> signIn(String accessToken, {required Account account}) async {
    await ref.read(tokenStorageProvider).write(accessToken);
    await ref.read(accountStorageProvider).write(account);
    state = const AsyncData(SessionStatus.authenticated);
  }

  /// After it, App opens the login screen; [accountDeleted]: the welcome
  /// screen, there is no account to sign in to any more.
  Future<void> signOut({bool accountDeleted = false}) async {
    _accountDeleted = accountDeleted;
    await ref.read(tokenStorageProvider).delete();
    await ref.read(accountStorageProvider).delete();
    // the next one may choose another Google or Apple account
    await ref.read(socialSignInProvider).signOut();
    state = const AsyncData(SessionStatus.unauthenticated);
  }

  /// Whether the last sign-out came with the account's deletion.
  bool get accountDeleted => _accountDeleted;
  var _accountDeleted = false;
}

/// The signed-in account saved at login. null when signed out, or when the
/// session was opened by a version of the app that didn't save it yet.
@riverpod
Future<Account?> signedInAccount(Ref ref) async {
  final status = await ref.watch(sessionProvider.future);
  if (status == SessionStatus.unauthenticated) {
    return null;
  }
  return ref.watch(accountStorageProvider).read();
}
