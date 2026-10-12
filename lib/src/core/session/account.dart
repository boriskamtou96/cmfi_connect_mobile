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
  }) = _Account;

  const Account._();

  /// Admins and superadmins manage what everyone shares.
  bool get isAdmin => role == 'admin' || role == 'superadmin';

  bool get isSuperadmin => role == 'superadmin';

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
