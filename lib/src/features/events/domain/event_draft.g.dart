// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventDraft _$EventDraftFromJson(Map<String, dynamic> json) => _EventDraft(
  title: json['title'] as String,
  theme: json['theme'] as String? ?? '',
  themeVerse: json['theme_verse'] as String? ?? '',
  description: json['description'] as String? ?? '',
  startsAt: const UtcInstantConverter().fromJson(json['starts_at'] as String),
  endsAt: const UtcInstantConverter().fromJson(json['ends_at'] as String),
  timeZone: json['time_zone'] as String? ?? CommunityEvent.defaultTimeZone,
  venue: json['venue'] as String? ?? '',
  address: json['address'] as String? ?? '',
  city: json['city'] as String? ?? '',
  country: json['country'] as String? ?? '',
  mapsUrl: json['maps_url'] as String? ?? '',
  contactName: json['contact_name'] as String? ?? '',
  contactPhone: json['contact_phone'] as String? ?? '',
  posterId: (json['poster_id'] as num?)?.toInt(),
  registrationOpen: json['registration_open'] as bool? ?? true,
  registrationDeadline: _$JsonConverterFromJson<String, DateTime>(
    json['registration_deadline'],
    const UtcInstantConverter().fromJson,
  ),
  capacity: (json['capacity'] as num?)?.toInt(),
  asksLodging: json['asks_lodging'] as bool? ?? false,
  asksDepartureCity: json['asks_departure_city'] as bool? ?? false,
  feeNote: json['fee_note'] as String? ?? '',
  priceAmount: (json['price_amount'] as num?)?.toInt(),
  priceCurrency: json['price_currency'] as String? ?? 'XAF',
  status:
      $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
      EventStatus.draft,
);

Map<String, dynamic> _$EventDraftToJson(_EventDraft instance) =>
    <String, dynamic>{
      'title': instance.title,
      'theme': instance.theme,
      'theme_verse': instance.themeVerse,
      'description': instance.description,
      'starts_at': const UtcInstantConverter().toJson(instance.startsAt),
      'ends_at': const UtcInstantConverter().toJson(instance.endsAt),
      'time_zone': instance.timeZone,
      'venue': instance.venue,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'maps_url': instance.mapsUrl,
      'contact_name': instance.contactName,
      'contact_phone': instance.contactPhone,
      'poster_id': ?instance.posterId,
      'registration_open': instance.registrationOpen,
      'registration_deadline': ?_$JsonConverterToJson<String, DateTime>(
        instance.registrationDeadline,
        const UtcInstantConverter().toJson,
      ),
      'capacity': ?instance.capacity,
      'asks_lodging': instance.asksLodging,
      'asks_departure_city': instance.asksDepartureCity,
      'fee_note': instance.feeNote,
      'price_amount': ?instance.priceAmount,
      'price_currency': instance.priceCurrency,
      'status': _$EventStatusEnumMap[instance.status]!,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$EventStatusEnumMap = {
  EventStatus.draft: 'draft',
  EventStatus.published: 'published',
  EventStatus.cancelled: 'cancelled',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_SessionDraft _$SessionDraftFromJson(Map<String, dynamic> json) =>
    _SessionDraft(
      startsAt: const UtcInstantConverter().fromJson(
        json['starts_at'] as String,
      ),
      endsAt: _$JsonConverterFromJson<String, DateTime>(
        json['ends_at'],
        const UtcInstantConverter().fromJson,
      ),
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

Map<String, dynamic> _$SessionDraftToJson(_SessionDraft instance) =>
    <String, dynamic>{
      'starts_at': const UtcInstantConverter().toJson(instance.startsAt),
      'ends_at': ?_$JsonConverterToJson<String, DateTime>(
        instance.endsAt,
        const UtcInstantConverter().toJson,
      ),
      'title': instance.title,
      'speaker': instance.speaker,
      'place': instance.place,
      'description': instance.description,
      'hymns': instance.hymns.map((e) => e.toJson()).toList(),
    };
