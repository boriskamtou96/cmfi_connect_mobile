import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

/// Who is signed in, as given by POST /v1/users/login ("user").
/// Kept on the phone so the app knows the user's name even when the profile is incomplete.
@freezed
abstract class Account with _$Account {
  const factory Account({
    required String firstName,
    @Default('') String lastName,
    required String phoneNumber,
    @Default('') String email,
    @Default(0) int id,

    /// The pseudo others find the user by ("" for a session older than pseudos).
    @Default('') String username,

    /// user, admin or superadmin.
    @Default('user') String role,

    /// Signed in with a temporary password an admin gave: the app asks for
    /// a new one before anything else.
    @Default(false) bool mustChangePassword,

    /// false for an account made with Google or Apple, until the member
    /// chooses a password.
    @Default(true) bool hasPassword,
  }) = _Account;

  const Account._();

  /// Admins and superadmins manage what everyone shares.
  bool get isAdmin => role == 'admin' || role == 'superadmin';

  bool get isSuperadmin => role == 'superadmin';

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
