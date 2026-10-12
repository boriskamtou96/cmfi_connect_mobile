import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage.g.dart';

/// The access token lives in the Keychain (iOS) / Keystore (Android), never in shared_preferences.
class TokenStorage {
  const TokenStorage(this._storage);

  static const _key = 'access_token';

  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: _key);

  Future<void> write(String token) => _storage.write(key: _key, value: token);

  Future<void> delete() => _storage.delete(key: _key);
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) =>
    const TokenStorage(FlutterSecureStorage());
