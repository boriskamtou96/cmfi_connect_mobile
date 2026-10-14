import 'package:freezed_annotation/freezed_annotation.dart';

import '../../events/domain/event.dart';

part 'member.freezed.dart';
part 'member.g.dart';

/// What a member shows of themselves to the others, found by pseudo
/// (GET /v1/users/by-username/:username): never their phone nor e-mail.
@freezed
abstract class MemberCard with _$MemberCard {
  const factory MemberCard({
    required String username,
    required String firstName,
    @Default('') String lastName,
    @Default('') String church,
    @Default('') String assembly,

    /// Their profile photo (a square image of the media storage), or null.
    EventImage? avatar,
  }) = _MemberCard;

  const MemberCard._();

  factory MemberCard.fromJson(Map<String, dynamic> json) =>
      _$MemberCardFromJson(json);

  String get fullName =>
      [firstName, lastName].where((part) => part.isNotEmpty).join(' ');

  String get initials => [firstName, lastName]
      .where((part) => part.isNotEmpty)
      .map((part) => String.fromCharCode(part.runes.first).toUpperCase())
      .join();

  /// "PSU-Yaoundé · Assemblée de Mvog-Ada", or ''.
  String get place =>
      [church, assembly].where((part) => part.isNotEmpty).join(' · ');
}

/// Why a pseudo can't be used.
enum UsernameProblem { invalid, reserved, taken }

/// Answer of GET /v1/usernames/availability.
@freezed
abstract class UsernameCheck with _$UsernameCheck {
  const factory UsernameCheck({
    @Default('') String username,
    @Default(false) bool available,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    UsernameProblem? problem,
    @Default(<String>[]) List<String> suggestions,
  }) = _UsernameCheck;

  factory UsernameCheck.fromJson(Map<String, dynamic> json) =>
      _$UsernameCheckFromJson(json);
}

/// The rules of the server (internal/usernames), checked before asking it.
abstract final class UsernameRules {
  static const minLength = 3;
  static const maxLength = 30;

  static final _format = RegExp(r'^[a-z0-9][a-z0-9._]{1,28}[a-z0-9]$');
  static final _doubleSign = RegExp(r'[._]{2}');

  /// The stored form: no spaces around, no leading "@", lowercase.
  static String normalize(String username) {
    final trimmed = username.trim();
    return (trimmed.startsWith('@') ? trimmed.substring(1) : trimmed)
        .toLowerCase();
  }

  /// [UsernameProblem.invalid] when the form is wrong; whether it is free or
  /// reserved is for the server to say.
  static UsernameProblem? check(String username) =>
      _format.hasMatch(username) && !_doubleSign.hasMatch(username)
      ? null
      : UsernameProblem.invalid;
}
