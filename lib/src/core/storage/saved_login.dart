import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_login.g.dart';

/// The number signed in with last, kept after signing out so it doesn't
/// have to be typed again; and, once the member turned it on, the password
/// for signing in with Face ID / the fingerprint. In the Keychain /
/// Keystore; the app reads the password only after the biometric check.
class SavedLoginStorage {
  const SavedLoginStorage(this._storage);

  static const _phoneKey = 'login_phone';
  static const _passwordKey = 'login_password';

  final FlutterSecureStorage _storage;

  Future<String?> phone() => _storage.read(key: _phoneKey);

  Future<void> savePhone(String phone) =>
      _storage.write(key: _phoneKey, value: phone);

  Future<String?> password() => _storage.read(key: _passwordKey);

  Future<void> savePassword(String password) =>
      _storage.write(key: _passwordKey, value: password);

  Future<void> deletePassword() => _storage.delete(key: _passwordKey);

  Future<void> forget() async {
    await _storage.delete(key: _phoneKey);
    await _storage.delete(key: _passwordKey);
  }
}

@Riverpod(keepAlive: true)
SavedLoginStorage savedLoginStorage(Ref ref) =>
    const SavedLoginStorage(FlutterSecureStorage());
