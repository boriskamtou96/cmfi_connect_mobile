import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import 'event.dart';

part 'event_draft.freezed.dart';
part 'event_draft.g.dart';

/// What an admin sends to create or change an event
/// (POST /v1/admin/events, PUT /v1/admin/events/:id: every field is replaced).
@freezed
abstract class EventDraft with _$EventDraft {
  const factory EventDraft({
    required String title,
    @Default('') String theme,
    @Default('') String themeVerse,
    @Default('') String description,
    @UtcInstantConverter() required DateTime startsAt,
    @UtcInstantConverter() required DateTime endsAt,
    @Default(CommunityEvent.defaultTimeZone) String timeZone,
    @Default('') String venue,
    @Default('') String address,
    @Default('') String city,
    @Default('') String country,
    @Default('') String mapsUrl,
    @Default('') String contactName,
    @Default('') String contactPhone,
    int? posterId,
    @Default(true) bool registrationOpen,
    @UtcInstantConverter() DateTime? registrationDeadline,
    int? capacity,
    @Default(false) bool asksLodging,
    @Default(false) bool asksDepartureCity,
    @Default('') String feeNote,

    /// Per person, in whole XAF; null for a free event.
    int? priceAmount,
    @Default('XAF') String priceCurrency,
    @Default(EventStatus.draft) EventStatus status,
  }) = _EventDraft;

  factory EventDraft.fromJson(Map<String, dynamic> json) =>
      _$EventDraftFromJson(json);

  /// The event as it is, to change a few fields.
  factory EventDraft.of(CommunityEvent event) => EventDraft(
    title: event.title,
    theme: event.theme,
    themeVerse: event.themeVerse,
    description: event.description,
    startsAt: event.startsAt,
    endsAt: event.endsAt,
    timeZone: event.timeZone,
    venue: event.venue,
    address: event.address,
    city: event.city,
    country: event.country,
    mapsUrl: event.mapsUrl,
    contactName: event.contactName,
    contactPhone: event.contactPhone,
    posterId: event.poster?.id,
    registrationOpen: event.registrationOpen,
    registrationDeadline: event.registrationDeadline,
    capacity: event.capacity,
    asksLodging: event.asksLodging,
    asksDepartureCity: event.asksDepartureCity,
    feeNote: event.feeNote,
    priceAmount: event.price?.amount,
    priceCurrency: event.price?.currency ?? 'XAF',
    status: event.status,
  );
}

/// One moment of the program, as an admin writes it.
@freezed
abstract class SessionDraft with _$SessionDraft {
  const factory SessionDraft({
    @UtcInstantConverter() required DateTime startsAt,
    @UtcInstantConverter() DateTime? endsAt,
    required String title,
    @Default('') String speaker,
    @Default('') String place,
    @Default('') String description,
    @Default(<SessionHymn>[]) List<SessionHymn> hymns,
  }) = _SessionDraft;

  factory SessionDraft.fromJson(Map<String, dynamic> json) =>
      _$SessionDraftFromJson(json);

  factory SessionDraft.of(EventSession session) => SessionDraft(
    startsAt: session.startsAt,
    endsAt: session.endsAt,
    title: session.title,
    speaker: session.speaker,
    place: session.place,
    description: session.description,
    hymns: session.hymns,
  );
}
