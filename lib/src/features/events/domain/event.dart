import 'package:freezed_annotation/freezed_annotation.dart';

import '../../members/domain/member.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// draft: only the admins see it, published: everyone, cancelled: shown with
/// a banner, no registration.
enum EventStatus { draft, published, cancelled }

/// Whether a member can register now (computed by the server).
enum RegistrationState { open, closed, full, ended, cancelled }

/// An image stored by the server (GET /v1/media/KEY): its size and average
/// color come with it, to draw a placeholder of the right shape and tint
/// before it arrives.
@freezed
abstract class EventImage with _$EventImage {
  const factory EventImage({
    required int id,

    /// "/v1/media/3f91….jpg", relative to the API origin.
    required String url,
    @Default(0) int width,
    @Default(0) int height,

    /// "#1F4D3A", or ''.
    @Default('') String color,
  }) = _EventImage;

  const EventImage._();

  factory EventImage.fromJson(Map<String, dynamic> json) =>
      _$EventImageFromJson(json);

  /// Width / height, 4:5 (a portrait poster) when unknown.
  double get aspectRatio => width > 0 && height > 0 ? width / height : 4 / 5;

  /// The average color as 0xFFRRGGBB, null when unknown.
  int? get argb {
    if (color.length != 7 || !color.startsWith('#')) {
      return null;
    }
    final rgb = int.tryParse(color.substring(1), radix: 16);
    return rgb == null ? null : 0xFF000000 | rgb;
  }
}

/// How many came forward, and the user's own place.
@freezed
abstract class RegistrationSummary with _$RegistrationSummary {
  const factory RegistrationSummary({
    @JsonKey(unknownEnumValue: RegistrationState.closed)
    @Default(RegistrationState.closed)
    RegistrationState state,
    @Default(false) bool registered,
    @Default(0) int registrations,
    @Default(0) int people,
  }) = _RegistrationSummary;

  factory RegistrationSummary.fromJson(Map<String, dynamic> json) =>
      _$RegistrationSummaryFromJson(json);
}

/// A hymn sung during a session, opened in the hymn book.
@freezed
abstract class SessionHymn with _$SessionHymn {
  const factory SessionHymn({required String book, required int number}) =
      _SessionHymn;

  factory SessionHymn.fromJson(Map<String, dynamic> json) =>
      _$SessionHymnFromJson(json);
}

/// One moment of the program (worship, teaching, prayer night…).
@freezed
abstract class EventSession with _$EventSession {
  const factory EventSession({
    required int id,
    required DateTime startsAt,
    DateTime? endsAt,
    required String title,
    @Default('') String speaker,
    @Default('') String place,
    @Default('') String description,
    @Default(<SessionHymn>[]) List<SessionHymn> hymns,
  }) = _EventSession;

  factory EventSession.fromJson(Map<String, dynamic> json) =>
      _$EventSessionFromJson(json);
}

/// A piece of news about the event, pinned ones first.
@freezed
abstract class EventPost with _$EventPost {
  const factory EventPost({
    required int id,
    required String body,
    EventImage? image,
    @Default(false) bool pinned,
    required DateTime createdAt,
  }) = _EventPost;

  factory EventPost.fromJson(Map<String, dynamic> json) =>
      _$EventPostFromJson(json);
}

/// A photo of the gallery, added during or after the event.
@freezed
abstract class EventPhoto with _$EventPhoto {
  const factory EventPhoto({
    required int id,
    required EventImage image,
    @Default('') String caption,
  }) = _EventPhoto;

  factory EventPhoto.fromJson(Map<String, dynamic> json) =>
      _$EventPhotoFromJson(json);
}

/// The price of a paid event, per person, paid by mobile money (in whole
/// units: XAF has no cents).
@freezed
abstract class EventPrice with _$EventPrice {
  const factory EventPrice({
    required int amount,
    @Default('XAF') String currency,
  }) = _EventPrice;

  factory EventPrice.fromJson(Map<String, dynamic> json) =>
      _$EventPriceFromJson(json);
}

/// What the user answered when registering.
@freezed
abstract class MyRegistration with _$MyRegistration {
  const factory MyRegistration({
    @Default(1) int people,
    @Default(false) bool needsLodging,
    @Default('') String departureCity,
    DateTime? updatedAt,

    /// Made by a payment: the people can't change, and only the organizers
    /// undo it (with a refund).
    @Default(false) bool paid,
  }) = _MyRegistration;

  factory MyRegistration.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationFromJson(json);
}

/// Another edition of the same yearly event (2025, 2027…).
@freezed
abstract class EventEdition with _$EventEdition {
  const factory EventEdition({
    required int id,
    required String title,
    required DateTime startsAt,
    required DateTime endsAt,
    @Default(CommunityEvent.defaultTimeZone) String timeZone,
    EventImage? poster,
  }) = _EventEdition;

  factory EventEdition.fromJson(Map<String, dynamic> json) =>
      _$EventEditionFromJson(json);
}

/// An event of the whole community (/v1/events). The lists only fill the
/// first fields; GET /v1/events/:id fills everything.
@freezed
abstract class CommunityEvent with _$CommunityEvent {
  const factory CommunityEvent({
    required int id,
    int? seriesId,
    required String title,
    @Default('') String theme,
    required DateTime startsAt,
    required DateTime endsAt,

    /// The clock of the venue: times are shown as announced there.
    @Default(CommunityEvent.defaultTimeZone) String timeZone,
    @Default('') String venue,
    @Default('') String city,
    @Default('') String country,
    EventImage? poster,
    @JsonKey(unknownEnumValue: EventStatus.published)
    @Default(EventStatus.published)
    EventStatus status,
    @Default(RegistrationSummary()) RegistrationSummary registration,

    /// Per person; null for a free event.
    EventPrice? price,

    // ----- the whole event only -----
    @Default('') String themeVerse,
    @Default('') String description,
    @Default('') String address,
    @Default('') String mapsUrl,
    @Default('') String contactName,
    @Default('') String contactPhone,
    @Default(true) bool registrationOpen,
    DateTime? registrationDeadline,
    int? capacity,
    @Default(false) bool asksLodging,
    @Default(false) bool asksDepartureCity,
    @Default('') String feeNote,
    @Default(<EventSession>[]) List<EventSession> sessions,
    @Default(<EventPost>[]) List<EventPost> posts,
    @Default(<EventPhoto>[]) List<EventPhoto> photos,
    MyRegistration? myRegistration,
    @Default(<EventEdition>[]) List<EventEdition> editions,
  }) = _CommunityEvent;

  const CommunityEvent._();

  static const defaultTimeZone = 'Africa/Douala';

  factory CommunityEvent.fromJson(Map<String, dynamic> json) =>
      _$CommunityEventFromJson(json);

  bool isOver(DateTime now) => !endsAt.isAfter(now);

  bool isOn(DateTime now) => !startsAt.isAfter(now) && endsAt.isAfter(now);

  /// Days from [now]'s day to the first day, on the phone's calendar
  /// (0: today, 1: tomorrow).
  int daysUntil(DateTime now) {
    final start = startsAt.toLocal();
    final local = now.toLocal();
    return DateTime.utc(
      start.year,
      start.month,
      start.day,
    ).difference(DateTime.utc(local.year, local.month, local.day)).inDays;
  }

  /// "Yaoundé, Cameroun", or ''.
  String get place =>
      [city, country].where((part) => part.isNotEmpty).join(', ');

  /// Seats left, null without a limit.
  int? get placesLeft => capacity == null
      ? null
      : (capacity! - registration.people).clamp(0, capacity!);
}

/// Who registered, with the totals the organizers need
/// (GET /v1/admin/events/:id/registrations).
@freezed
abstract class EventRegistrations with _$EventRegistrations {
  const factory EventRegistrations({
    @Default(0) int registrations,
    @Default(0) int people,
    @Default(0) int lodging,
    @Default(<CityCount>[]) List<CityCount> cities,
    @Default(<Registrant>[]) List<Registrant> registrants,
  }) = _EventRegistrations;

  factory EventRegistrations.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationsFromJson(json);
}

@freezed
abstract class CityCount with _$CityCount {
  const factory CityCount({required String city, required int people}) =
      _CityCount;

  factory CityCount.fromJson(Map<String, dynamic> json) =>
      _$CityCountFromJson(json);
}

/// A member who registered: their card, phone and answers.
@freezed
abstract class Registrant with _$Registrant {
  const factory Registrant({
    required String username,
    required String firstName,
    @Default('') String lastName,
    @Default('') String church,
    @Default('') String assembly,
    @Default('') String phoneNumber,
    @Default(1) int people,
    @Default(false) bool needsLodging,
    @Default('') String departureCity,
    required DateTime createdAt,
    EventImage? avatar,
  }) = _Registrant;

  const Registrant._();

  factory Registrant.fromJson(Map<String, dynamic> json) =>
      _$RegistrantFromJson(json);

  MemberCard get card => MemberCard(
    username: username,
    firstName: firstName,
    lastName: lastName,
    church: church,
    assembly: assembly,
    avatar: avatar,
  );
}
