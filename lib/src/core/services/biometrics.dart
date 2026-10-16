import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'biometrics.g.dart';

/// What the phone recognises: a face (Face ID) or a fingerprint (Touch ID,
/// Android's sensor).
enum BiometricKind { face, fingerprint }

/// Face ID, Touch ID, the fingerprint of Android (local_auth). Behind a
/// provider: tests use a fake.
abstract class Biometrics {
  /// null when the phone has none set up.
  Future<BiometricKind?> kind();

  /// The system's prompt with [reason]; true once recognised.
  Future<bool> authenticate(String reason);
}

class DeviceBiometrics implements Biometrics {
  DeviceBiometrics();

  final _auth = LocalAuthentication();

  @override
  Future<BiometricKind?> kind() async {
    try {
      if (!await _auth.isDeviceSupported() || !await _auth.canCheckBiometrics) {
        return null;
      }
      final types = await _auth.getAvailableBiometrics();
      if (types.contains(BiometricType.face)) {
        return BiometricKind.face;
      }
      return types.isEmpty ? null : BiometricKind.fingerprint;
    } on Exception {
      return null;
    }
  }

  @override
  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
      );
    } on Exception {
      // cancelled, locked out after too many tries, not set up
      return false;
    }
  }
}

class NoBiometrics implements Biometrics {
  const NoBiometrics();

  @override
  Future<BiometricKind?> kind() async => null;

  @override
  Future<bool> authenticate(String reason) async => false;
}

@Riverpod(keepAlive: true)
Biometrics biometrics(Ref ref) =>
    kIsWeb ? const NoBiometrics() : DeviceBiometrics();

/// What this phone recognises, null without biometrics.
@riverpod
Future<BiometricKind?> biometricKind(Ref ref) =>
    ref.watch(biometricsProvider).kind();
