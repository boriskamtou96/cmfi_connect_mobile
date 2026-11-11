import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'social_sign_in.g.dart';

/// The accounts a member signs in with besides their number.
enum SocialProvider {
  google,
  apple;

  /// As the stores spell it ("Google", "Apple").
  String get label => switch (this) {
    google => 'Google',
    apple => 'Apple',
  };
}

/// What Google or Apple says of the member, for the profile they complete.
@immutable
class SocialAccount {
  const SocialAccount({
    required this.idToken,
    required this.provider,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  /// The Firebase ID token the server checks (valid one hour).
  final String idToken;
  final SocialProvider provider;
  final String firstName;
  final String lastName;
  final String email;
}

class SocialSignInException implements Exception {
  const SocialSignInException({this.unavailable = false});

  /// No Firebase, or the provider isn't set up: not worth trying again.
  final bool unavailable;

  @override
  String toString() => 'SocialSignInException(unavailable: $unavailable)';
}

/// Signs in with Google or Apple through Firebase Authentication, which gives
/// the ID token the server checks. Behind a provider so tests replace it.
abstract interface class SocialSignIn {
  /// Whether [provider] is offered on this phone (Apple: on an iPhone).
  bool offers(SocialProvider provider);

  /// The account chosen, null when the member closed the window. Throws
  /// [SocialSignInException].
  Future<SocialAccount?> signIn(SocialProvider provider);

  /// A fresh token of the Google or Apple account signed in on this phone
  /// (to delete an account without password), null without one.
  Future<String?> currentToken();

  /// Forgets the Google or Apple account on this phone (sign-out).
  Future<void> signOut();
}

/// Without Firebase (tests, a failed start): no button is offered.
class NoSocialSignIn implements SocialSignIn {
  const NoSocialSignIn();

  @override
  bool offers(SocialProvider provider) => false;

  @override
  Future<SocialAccount?> signIn(SocialProvider provider) async =>
      throw const SocialSignInException(unavailable: true);

  @override
  Future<String?> currentToken() async => null;

  @override
  Future<void> signOut() async {}
}

class FirebaseSocialSignIn implements SocialSignIn {
  FirebaseSocialSignIn();

  FirebaseAuth get _auth => FirebaseAuth.instance;

  @override
  bool offers(SocialProvider provider) => switch (provider) {
    SocialProvider.google => true,
    // required by the App Store next to Google; not offered on Android
    SocialProvider.apple => defaultTargetPlatform == TargetPlatform.iOS,
  };

  @override
  Future<SocialAccount?> signIn(SocialProvider provider) async {
    try {
      final result = await _auth.signInWithProvider(switch (provider) {
        SocialProvider.google =>
          GoogleAuthProvider()..setCustomParameters({
            // the account to use, every time (several on one phone)
            'prompt': 'select_account',
          }),
        SocialProvider.apple =>
          AppleAuthProvider()
            ..addScope('email')
            ..addScope('name'),
      });
      final user = result.user;
      final token = await user?.getIdToken();
      if (user == null || token == null) {
        throw const SocialSignInException();
      }
      // Apple gives the name once, in the first sign-in only
      final profile = result.additionalUserInfo?.profile ?? const {};
      final name = (user.displayName ?? '').trim();
      final space = name.indexOf(' ');
      return SocialAccount(
        idToken: token,
        provider: provider,
        firstName:
            _text(profile['given_name']) ??
            (space < 0 ? name : name.substring(0, space)),
        lastName:
            _text(profile['family_name']) ??
            (space < 0 ? '' : name.substring(space + 1).trim()),
        email: user.email ?? '',
      );
    } on FirebaseAuthException catch (error) {
      if (_cancelled.contains(error.code)) {
        return null;
      }
      throw SocialSignInException(
        unavailable:
            error.code == 'operation-not-allowed' ||
            error.code == 'invalid-api-key',
      );
    }
  }

  static const _cancelled = {
    'canceled',
    'cancelled',
    'web-context-canceled',
    'web-context-cancelled',
    'popup-closed-by-user',
    'user-cancelled',
  };

  static String? _text(Object? value) =>
      value is String && value.trim().isNotEmpty ? value.trim() : null;

  @override
  Future<String?> currentToken() async {
    try {
      return await _auth.currentUser?.getIdToken(true);
    } on FirebaseAuthException {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on Object {
      // nothing kept
    }
  }
}

/// Firebase started in bootstrap.dart (firebase_options.dart), or not.
@Riverpod(keepAlive: true)
SocialSignIn socialSignIn(Ref ref) =>
    Firebase.apps.isEmpty ? const NoSocialSignIn() : FirebaseSocialSignIn();
