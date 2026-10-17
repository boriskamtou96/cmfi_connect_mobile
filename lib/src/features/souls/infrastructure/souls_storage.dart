import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'souls_storage.g.dart';

/// The souls of each account, in the Keychain (iPhone) / the encrypted
/// Keystore (Android): names and phones of other people, so never in the
/// plain preferences, never sent. One entry per account: someone else
/// signing in on the phone doesn't see them.
abstract class SoulsStorage {
  Future<String?> read(int accountId);
  Future<void> write(int accountId, String json);
}

class SecureSoulsStorage implements SoulsStorage {
  const SecureSoulsStorage(this._storage);

  final FlutterSecureStorage _storage;

  static String _key(int accountId) => 'souls_$accountId';

  @override
  Future<String?> read(int accountId) => _storage.read(key: _key(accountId));

  @override
  Future<void> write(int accountId, String json) =>
      _storage.write(key: _key(accountId), value: json);
}

@Riverpod(keepAlive: true)
SoulsStorage soulsStorage(Ref ref) =>
    const SecureSoulsStorage(FlutterSecureStorage());
