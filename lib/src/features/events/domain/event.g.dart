// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventImage _$EventImageFromJson(Map<String, dynamic> json) => _EventImage(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  width: (json['width'] as num?)?.toInt() ?? 0,
  height: (json['height'] as num?)?.toInt() ?? 0,
  color: json['color'] as String? ?? '',
);

Map<String, dynamic> _$EventImageToJson(_EventImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
    };

_RegistrationSummary _$RegistrationSummaryFromJson(Map<String, dynamic> json) =>
    _RegistrationSummary(
      state:
          $enumDecodeNullable(
            _$RegistrationStateEnumMap,
            json['state'],
            unknownValue: RegistrationState.closed,
          ) ??
          RegistrationState.closed,
      registered: json['registered'] as bool? ?? false,
      registrations: (json['registrations'] as num?)?.toInt() ?? 0,
      people: (json['people'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RegistrationSummaryToJson(
  _RegistrationSummary instance,
) => <String, dynamic>{
  'state': _$RegistrationStateEnumMap[instance.state]!,
  'registered': instance.registered,
  'registrations': instance.registrations,
  'people': instance.people,
};

const _$RegistrationStateEnumMap = {
  RegistrationState.open: 'open',
  RegistrationState.closed: 'closed',
  RegistrationState.full: 'full',
  RegistrationState.ended: 'ended',
  RegistrationState.cancelled: 'cancelled',
};

_SessionHymn _$SessionHymnFromJson(Map<String, dynamic> json) => _SessionHymn(
  book: json['book'] as String,
  number: (json['number'] as num).toInt(),
);

Map<String, dynamic> _$SessionHymnToJson(_SessionHymn instance) =>
    <String, dynamic>{'book': instance.book, 'number': instance.number};

_EventSession _$EventSessionFromJson(Map<String, dynamic> json) =>
    _EventSession(
      id: (json['id'] as num).toInt(),
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
      title: json['title'] as String,
      speaker: json['speaker'] as String? ?? '',
      place: json['place'] as String? ?? '',
      description: json['description'] as String? ?? '',
      hymns:
          (json['hymns'] as List<dynamic>?)
              ?.map((e) => SessionHymn.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SessionHymn>[],
    );

Map<String, dynamic> _$EventSessionToJson(_EventSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': ?instance.endsAt?.toIso8601String(),
      'title': instance.title,
      'speaker': instance.speaker,
      'place': instance.place,
      'description': instance.description,
      'hymns': instance.hymns.map((e) => e.toJson()).toList(),
    };

_EventPost _$EventPostFromJson(Map<String, dynamic> json) => _EventPost(
  id: (json['id'] as num).toInt(),
  body: json['body'] as String,
  image: json['image'] == null
      ? null
      : EventImage.fromJson(json['image'] as Map<String, dynamic>),
  pinned: json['pinned'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$EventPostToJson(_EventPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'image': ?instance.image?.toJson(),
      'pinned': instance.pinned,
      'created_at': instance.createdAt.toIso8601String(),
    };

_EventPhoto _$EventPhotoFromJson(Map<String, dynamic> json) => _EventPhoto(
  id: (json['id'] as num).toInt(),
  image: EventImage.fromJson(json['image'] as Map<String, dynamic>),
  caption: json['caption'] as String? ?? '',
);

Map<String, dynamic> _$EventPhotoToJson(_EventPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image.toJson(),
      'caption': instance.caption,
    };

_MyRegistration _$MyRegistrationFromJson(Map<String, dynamic> json) =>
    _MyRegistration(
      people: (json['people'] as num?)?.toInt() ?? 1,
      needsLodging: json['needs_lodging'] as bool? ?? false,
      departureCity: json['departure_city'] as String? ?? '',
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MyRegistrationToJson(_MyRegistration instance) =>
    <String, dynamic>{
      'people': instance.people,
      'needs_lodging': instance.needsLodging,
      'departure_city': instance.departureCity,
      'updated_at': ?instance.updatedAt?.toIso8601String(),
    };

_EventEdition _$EventEditionFromJson(Map<String, dynamic> json) =>
    _EventEdition(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
      timeZone: json['time_zone'] as String? ?? CommunityEvent.defaultTimeZone,
      poster: json['poster'] == null
          ? null
          : EventImage.fromJson(json['poster'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventEditionToJson(_EventEdition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
      'time_zone': instance.timeZone,
      'poster': ?instance.poster?.toJson(),
    };

_CommunityEvent _$CommunityEventFromJson(Map<String, dynamic> json) =>
    _CommunityEvent(
      id: (json['id'] as num).toInt(),
      seriesId: (json['series_id'] as num?)?.toInt(),
      title: json['title'] as String,
      theme: json['theme'] as String? ?? '',
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
      timeZone: json['time_zone'] as String? ?? CommunityEvent.defaultTimeZone,
      venue: json['venue'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      poster: json['poster'] == null
          ? null
          : EventImage.fromJson(json['poster'] as Map<String, dynamic>),
      status:
          $enumDecodeNullable(
            _$EventStatusEnumMap,
            json['status'],
            unknownValue: EventStatus.published,
          ) ??
          EventStatus.published,
      registration: json['registration'] == null
          ? const RegistrationSummary()
          : RegistrationSummary.fromJson(
              json['registration'] as Map<String, dynamic>,
            ),
      themeVerse: json['theme_verse'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      mapsUrl: json['maps_url'] as String? ?? '',
      contactName: json['contact_name'] as String? ?? '',
      contactPhone: json['contact_phone'] as String? ?? '',
      registrationOpen: json['registration_open'] as bool? ?? true,
      registrationDeadline: json['registration_deadline'] == null
          ? null
          : DateTime.parse(json['registration_deadline'] as String),
      capacity: (json['capacity'] as num?)?.toInt(),
      asksLodging: json['asks_lodging'] as bool? ?? false,
      asksDepartureCity: json['asks_departure_city'] as bool? ?? false,
      feeNote: json['fee_note'] as String? ?? '',
      sessions:
          (json['sessions'] as List<dynamic>?)
              ?.map((e) => EventSession.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EventSession>[],
      posts:
          (json['posts'] as List<dynamic>?)
              ?.map((e) => EventPost.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EventPost>[],
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => EventPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EventPhoto>[],
      myRegistration: json['my_registration'] == null
          ? null
          : MyRegistration.fromJson(
              json['my_registration'] as Map<String, dynamic>,
            ),
      editions:
          (json['editions'] as List<dynamic>?)
              ?.map((e) => EventEdition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EventEdition>[],
    );

Map<String, dynamic> _$CommunityEventToJson(
  _CommunityEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'series_id': ?instance.seriesId,
  'title': instance.title,
  'theme': instance.theme,
  'starts_at': instance.startsAt.toIso8601String(),
  'ends_at': instance.endsAt.toIso8601String(),
  'time_zone': instance.timeZone,
  'venue': instance.venue,
  'city': instance.city,
  'country': instance.country,
  'poster': ?instance.poster?.toJson(),
  'status': _$EventStatusEnumMap[instance.status]!,
  'registration': instance.registration.toJson(),
  'theme_verse': instance.themeVerse,
  'description': instance.description,
  'address': instance.address,
  'maps_url': instance.mapsUrl,
  'contact_name': instance.contactName,
  'contact_phone': instance.contactPhone,
  'registration_open': instance.registrationOpen,
  'registration_deadline': ?instance.registrationDeadline?.toIso8601String(),
  'capacity': ?instance.capacity,
  'asks_lodging': instance.asksLodging,
  'asks_departure_city': instance.asksDepartureCity,
  'fee_note': instance.feeNote,
  'sessions': instance.sessions.map((e) => e.toJson()).toList(),
  'posts': instance.posts.map((e) => e.toJson()).toList(),
  'photos': instance.photos.map((e) => e.toJson()).toList(),
  'my_registration': ?instance.myRegistration?.toJson(),
  'editions': instance.editions.map((e) => e.toJson()).toList(),
};

const _$EventStatusEnumMap = {
  EventStatus.draft: 'draft',
  EventStatus.published: 'published',
  EventStatus.cancelled: 'cancelled',
};

_EventRegistrations _$EventRegistrationsFromJson(Map<String, dynamic> json) =>
    _EventRegistrations(
      registrations: (json['registrations'] as num?)?.toInt() ?? 0,
      people: (json['people'] as num?)?.toInt() ?? 0,
      lodging: (json['lodging'] as num?)?.toInt() ?? 0,
      cities:
          (json['cities'] as List<dynamic>?)
              ?.map((e) => CityCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CityCount>[],
      registrants:
          (json['registrants'] as List<dynamic>?)
              ?.map((e) => Registrant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Registrant>[],
    );

Map<String, dynamic> _$EventRegistrationsToJson(_EventRegistrations instance) =>
    <String, dynamic>{
      'registrations': instance.registrations,
      'people': instance.people,
      'lodging': instance.lodging,
      'cities': instance.cities.map((e) => e.toJson()).toList(),
      'registrants': instance.registrants.map((e) => e.toJson()).toList(),
    };

_CityCount _$CityCountFromJson(Map<String, dynamic> json) => _CityCount(
  city: json['city'] as String,
  people: (json['people'] as num).toInt(),
);

Map<String, dynamic> _$CityCountToJson(_CityCount instance) =>
    <String, dynamic>{'city': instance.city, 'people': instance.people};

_Registrant _$RegistrantFromJson(Map<String, dynamic> json) => _Registrant(
  username: json['username'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String? ?? '',
  church: json['church'] as String? ?? '',
  assembly: json['assembly'] as String? ?? '',
  phoneNumber: json['phone_number'] as String? ?? '',
  people: (json['people'] as num?)?.toInt() ?? 1,
  needsLodging: json['needs_lodging'] as bool? ?? false,
  departureCity: json['departure_city'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
  avatar: json['avatar'] == null
      ? null
      : EventImage.fromJson(json['avatar'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegistrantToJson(_Registrant instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'church': instance.church,
      'assembly': instance.assembly,
      'phone_number': instance.phoneNumber,
      'people': instance.people,
      'needs_lodging': instance.needsLodging,
      'departure_city': instance.departureCity,
      'created_at': instance.createdAt.toIso8601String(),
      'avatar': ?instance.avatar?.toJson(),
    };
