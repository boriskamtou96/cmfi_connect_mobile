import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/session/account.dart';
import '../../events/domain/event.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// Content of GET /v1/profiles/.
@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String firstName,
    @Default('') String lastName,
    required String phoneNumber,
    @Default('') String email,
    DateTime? birthDate,
    String? city,
    String? country,
    String? church,
    String? assembly,

    /// The profile photo (a square image of the media storage), or null.
    EventImage? avatar,

    /// false when the server has no profile for this user yet (it must be created).
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(true)
    bool exists,
  }) = _Profile;

  const Profile._();

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  /// The profile as stored on the server, its empty name and phone filled from
  /// the account used to sign in. [stored] null: no profile on the server yet.
  factory Profile.resolve(Profile? stored, Account? account) {
    String pick(String? value, String? fallback) =>
        (value ?? '').trim().isNotEmpty ? value!.trim() : (fallback ?? '');

    final profile =
        stored ?? const Profile(firstName: '', phoneNumber: '', exists: false);
    return profile.copyWith(
      firstName: pick(profile.firstName, account?.firstName),
      lastName: pick(profile.lastName, account?.lastName),
      phoneNumber: pick(profile.phoneNumber, account?.phoneNumber),
      email: pick(profile.email, account?.email),
    );
  }

  String get fullName =>
      [firstName, lastName].where((part) => part.isNotEmpty).join(' ');

  bool get hasName => firstName.isNotEmpty;

  /// "Boris Kamtou" -> "BK", shown in the avatar.
  String get initials => [firstName, lastName]
      .where((part) => part.isNotEmpty)
      .map((part) => String.fromCharCode(part.runes.first).toUpperCase())
      .join();
}
