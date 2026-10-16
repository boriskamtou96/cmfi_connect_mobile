import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/biometrics.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/storage/saved_login.dart';

part 'saved_login.g.dart';

@immutable
class SavedLoginState {
  const SavedLoginState({this.phone, this.biometric = false});

  /// The number signed in with last ("+237690000001").
  final String? phone;

  /// The password is kept for Face ID / the fingerprint.
  final bool biometric;
}

/// The number kept from one sign-in to the next, and the sign-in with Face
/// ID / the fingerprint. Signing out keeps both (it is the point: back in
/// without typing); deleting the account forgets them.
@Riverpod(keepAlive: true)
class SavedLogin extends _$SavedLogin {
  /// Asked once after a sign-in: "Activer Face ID ?".
  static const _askedKey = 'login_biometric_asked';

  SavedLoginStorage get _storage => ref.read(savedLoginStorageProvider);

  @override
  Future<SavedLoginState> build() async {
    final storage = ref.watch(savedLoginStorageProvider);
    return SavedLoginState(
      phone: await storage.phone(),
      biometric: await storage.password() != null,
    );
  }

  /// Signed in with [phone] and [password]: the number stays for next time,
  /// and the password kept for Face ID follows a change.
  Future<void> remember(String phone, String password) async {
    await _storage.savePhone(phone);
    final current = await future;
    if (current.biometric) {
      await _storage.savePassword(password);
    }
    state = AsyncData(
      SavedLoginState(phone: phone, biometric: current.biometric),
    );
  }

  bool alreadyAsked() =>
      ref.read(sharedPreferencesProvider).getBool(_askedKey) ?? false;

  Future<void> markAsked() =>
      ref.read(sharedPreferencesProvider).setBool(_askedKey, true);

  /// Turns it on, once the face or the finger is recognised.
  Future<bool> enable(String password, {required String reason}) async {
    await markAsked();
    if (!await ref.read(biometricsProvider).authenticate(reason)) {
      return false;
    }
    await _storage.savePassword(password);
    final current = await future;
    state = AsyncData(SavedLoginState(phone: current.phone, biometric: true));
    return true;
  }

  Future<void> disable() async {
    await _storage.deletePassword();
    final current = await future;
    state = AsyncData(SavedLoginState(phone: current.phone));
  }

  /// The password kept, once the face or the finger is recognised.
  Future<String?> unlock({required String reason}) async {
    if (!await ref.read(biometricsProvider).authenticate(reason)) {
      return null;
    }
    return _storage.password();
  }

  /// The account is deleted: nothing of it stays on the phone.
  Future<void> forget() async {
    await _storage.forget();
    await ref.read(sharedPreferencesProvider).remove(_askedKey);
    ref.invalidateSelf();
  }
}
