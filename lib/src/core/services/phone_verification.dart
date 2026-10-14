import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_verification.g.dart';

/// Why a phone could not be verified.
enum PhoneVerificationError {
  invalidNumber,
  invalidCode,

  /// The code (or the session) expired: send a new one.
  expired,
  tooManyRequests,
  network,

  /// No Firebase, or a refusal without a better reason.
  unavailable,
}

class PhoneVerificationException implements Exception {
  const PhoneVerificationException(this.error);

  final PhoneVerificationError error;

  @override
  String toString() => 'PhoneVerificationException($error)';
}

/// Proves the user holds a phone number (a forgotten password): Firebase
/// Authentication sends a code by SMS, and gives an ID token once the code is
/// right. The server checks that token. Behind a provider so tests replace it.
abstract interface class PhoneVerification {
  /// Sends a code by SMS to [phoneNumber] ("+237690000001"). Completes once
  /// the SMS left. Android may read the code by itself: [onAutoVerified]
  /// then gets the token, without typing.
  Future<void> sendCode(
    String phoneNumber, {
    required void Function(String idToken) onAutoVerified,
  });

  /// The Firebase ID token when [code] is the one of the SMS.
  Future<String> confirm(String code);

  /// Forgets the verification (the Firebase session is only for this).
  Future<void> forget();
}

/// Without Firebase (web, desktop, a failed start): nothing can be verified.
class NoPhoneVerification implements PhoneVerification {
  const NoPhoneVerification();

  @override
  Future<void> sendCode(
    String phoneNumber, {
    required void Function(String idToken) onAutoVerified,
  }) async => throw const PhoneVerificationException(
    PhoneVerificationError.unavailable,
  );

  @override
  Future<String> confirm(String code) async =>
      throw const PhoneVerificationException(
        PhoneVerificationError.unavailable,
      );

  @override
  Future<void> forget() async {}
}

class FirebasePhoneVerification implements PhoneVerification {
  FirebasePhoneVerification();

  FirebaseAuth get _auth => FirebaseAuth.instance;
  String? _verificationId;
  // sending again to the same number: Firebase wants the token of the
  // first SMS
  String? _number;
  int? _resendToken;

  @override
  Future<void> sendCode(
    String phoneNumber, {
    required void Function(String idToken) onAutoVerified,
  }) {
    final sent = Completer<void>();
    final resendToken = phoneNumber == _number ? _resendToken : null;
    _number = phoneNumber;

    void fail(Object error) {
      if (!sent.isCompleted) {
        sent.completeError(
          error is FirebaseAuthException
              ? _from(error)
              : const PhoneVerificationException(
                  PhoneVerificationError.unavailable,
                ),
        );
      }
    }

    _auth
        .verifyPhoneNumber(
          phoneNumber: phoneNumber,
          forceResendingToken: resendToken,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (credential) async {
            try {
              onAutoVerified(await _signIn(credential));
            } on PhoneVerificationException {
              // the code can still be typed
            }
            if (!sent.isCompleted) {
              sent.complete();
            }
          },
          verificationFailed: fail,
          codeSent: (verificationId, token) {
            _verificationId = verificationId;
            _resendToken = token;
            if (!sent.isCompleted) {
              sent.complete();
            }
          },
          codeAutoRetrievalTimeout: (verificationId) =>
              _verificationId = verificationId,
        )
        .catchError(fail);
    return sent.future;
  }

  @override
  Future<String> confirm(String code) {
    final verificationId = _verificationId;
    if (verificationId == null) {
      throw const PhoneVerificationException(PhoneVerificationError.expired);
    }
    return _signIn(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      ),
    );
  }

  Future<String> _signIn(AuthCredential credential) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      final token = await result.user?.getIdToken();
      if (token == null) {
        throw const PhoneVerificationException(PhoneVerificationError.expired);
      }
      return token;
    } on FirebaseAuthException catch (error) {
      throw _from(error);
    }
  }

  @override
  Future<void> forget() async {
    _verificationId = null;
    try {
      await _auth.signOut();
    } on Object {
      // nothing kept
    }
  }

  static PhoneVerificationException _from(FirebaseAuthException error) =>
      PhoneVerificationException(switch (error.code) {
        'invalid-phone-number' ||
        'missing-phone-number' => PhoneVerificationError.invalidNumber,
        'invalid-verification-code' ||
        'missing-verification-code' => PhoneVerificationError.invalidCode,
        'session-expired' ||
        'code-expired' ||
        'invalid-verification-id' => PhoneVerificationError.expired,
        'too-many-requests' ||
        'quota-exceeded' => PhoneVerificationError.tooManyRequests,
        'network-request-failed' => PhoneVerificationError.network,
        _ => PhoneVerificationError.unavailable,
      });
}

/// Firebase started in bootstrap.dart (firebase_options.dart), or not.
@Riverpod(keepAlive: true)
PhoneVerification phoneVerification(Ref ref) => Firebase.apps.isEmpty
    ? const NoPhoneVerification()
    : FirebasePhoneVerification();
