import 'package:freezed_annotation/freezed_annotation.dart';

import '../../events/domain/event.dart';
import '../../members/domain/member.dart';

part 'authority.freezed.dart';
part 'authority.g.dart';

/// Where a member asked by pseudo stands: they accept or decline. A person
/// typed by hand is accepted at once.
enum AuthorityStatus { pending, accepted, declined }

/// A person who accompanies the user spiritually (/v1/authorities).
/// At most one of them is the user's disciple maker.
@freezed
abstract class Authority with _$Authority {
  const factory Authority({
    required int id,
    required String firstName,
    String? lastName,

    /// For a member found by pseudo: only once they accepted.
    String? phoneNumber,
    String? email,
    @Default(false) bool isDiscipleMaker,

    /// A member of the app, found by pseudo (null: typed by hand).
    String? username,
    String? church,
    String? assembly,
    @JsonKey(unknownEnumValue: AuthorityStatus.accepted)
    @Default(AuthorityStatus.accepted)
    AuthorityStatus status,

    /// The profile photo of a member found by pseudo, or null.
    EventImage? avatar,

    /// A disciple maker found by pseudo sees the user's regularity (days
    /// filled in, streak, % of goals; never the reports), unless turned off.
    @Default(true) bool sharesRegularity,
  }) = _Authority;

  const Authority._();

  factory Authority.fromJson(Map<String, dynamic> json) =>
      _$AuthorityFromJson(json);

  String get fullName =>
      [firstName, lastName ?? ''].where((part) => part.isNotEmpty).join(' ');

  String get initials => [firstName, lastName ?? '']
      .where((part) => part.isNotEmpty)
      .map((part) => String.fromCharCode(part.runes.first).toUpperCase())
      .join();
}

/// A member who asks the user to accompany them (GET /v1/authorities/requests).
@freezed
abstract class AuthorityRequest with _$AuthorityRequest {
  const factory AuthorityRequest({
    required int id,
    required MemberCard from,
    @Default(false) bool isDiscipleMaker,
  }) = _AuthorityRequest;

  factory AuthorityRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorityRequestFromJson(json);
}
