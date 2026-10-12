import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/session/account.dart';
import '../../../core/session/session.dart';
import '../../../core/storage/account_storage.dart';
import '../infrastructure/members_api.dart';

part 'my_account.g.dart';

/// The signed-in account as the server has it now (pseudo, role), kept on the
/// phone. Without network, the copy saved at the last sign-in or refresh.
@Riverpod(keepAlive: true)
class MyAccount extends _$MyAccount {
  @override
  Future<Account?> build() async {
    final status = await ref.watch(sessionProvider.future);
    if (status == SessionStatus.unauthenticated) {
      return null;
    }
    final storage = ref.watch(accountStorageProvider);
    try {
      final account = await ref.watch(membersApiProvider).me();
      // signed out meanwhile: nothing is written back on the phone
      if (ref.mounted) {
        await storage.write(account);
      }
      return account;
    } on AppException {
      return storage.read();
    }
  }

  /// Throws AppException (USERNAME_TAKEN...) when the server refuses it.
  Future<void> changeUsername(String username) async {
    final account = await ref.read(membersApiProvider).updateUsername(username);
    await ref.read(accountStorageProvider).write(account);
    state = AsyncData(account);
  }

  /// Deletes the account on the server, then signs out: App goes back to the
  /// welcome screen and forgets what the phone kept. Throws an AppException
  /// (INVALID_CREDENTIALS, LAST_SUPERADMIN…), the account stays then.
  Future<void> deleteAccount(String password) async {
    final session = ref.read(sessionProvider.notifier);
    await ref.read(membersApiProvider).deleteAccount(password: password);
    await session.signOut();
  }
}
