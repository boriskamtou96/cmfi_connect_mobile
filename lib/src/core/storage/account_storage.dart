import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../session/account.dart';

part 'account_storage.g.dart';

/// The signed-in account (name, phone): personal data, so in the Keychain / Keystore too.
class AccountStorage {
  const AccountStorage(this._storage);

  static const _key = 'account';

  final FlutterSecureStorage _storage;

  Future<Account?> read() async {
    final json = await _storage.read(key: _key);
    if (json == null) {
      return null;
    }
    try {
      return Account.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } on Object {
      // written by an older version of the app
      return null;
    }
  }

  Future<void> write(Account account) =>
      _storage.write(key: _key, value: jsonEncode(account.toJson()));

  Future<void> delete() => _storage.delete(key: _key);
}

@Riverpod(keepAlive: true)
AccountStorage accountStorage(Ref ref) =>
    const AccountStorage(FlutterSecureStorage());
