// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrayerDocument _$PrayerDocumentFromJson(Map<String, dynamic> json) =>
    _PrayerDocument(
      url: json['url'] as String,
      name: json['name'] as String? ?? '',
      sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PrayerDocumentToJson(_PrayerDocument instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'size_bytes': instance.sizeBytes,
    };

_PrayerTopic _$PrayerTopicFromJson(Map<String, dynamic> json) => _PrayerTopic(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  category:
      $enumDecodeNullable(
        _$PrayerTopicCategoryEnumMap,
        json['category'],
        unknownValue: PrayerTopicCategory.other,
      ) ??
      PrayerTopicCategory.church,
  verse: json['verse'] as String? ?? '',
  startsOn: const ApiDateConverter().fromJson(json['starts_on'] as String),
  endsOn: _$JsonConverterFromJson<String, DateTime>(
    json['ends_on'],
    const ApiDateConverter().fromJson,
  ),
  eventId: (json['event_id'] as num?)?.toInt(),
  document: json['document'] == null
      ? null
      : PrayerDocument.fromJson(json['document'] as Map<String, dynamic>),
  points:
      (json['points'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  people: (json['people'] as num?)?.toInt() ?? 0,
  prayedToday:
      (json['prayed_today'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
);

Map<String, dynamic> _$PrayerTopicToJson(_PrayerTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': _$PrayerTopicCategoryEnumMap[instance.category]!,
      'verse': instance.verse,
      'starts_on': const ApiDateConverter().toJson(instance.startsOn),
      'ends_on': ?_$JsonConverterToJson<String, DateTime>(
        instance.endsOn,
        const ApiDateConverter().toJson,
      ),
      'event_id': ?instance.eventId,
      'document': ?instance.document?.toJson(),
      'points': instance.points,
      'people': instance.people,
      'prayed_today': instance.prayedToday,
    };

const _$PrayerTopicCategoryEnumMap = {
  PrayerTopicCategory.church: 'church',
  PrayerTopicCategory.nations: 'nations',
  PrayerTopicCategory.sick: 'sick',
  PrayerTopicCategory.event: 'event',
  PrayerTopicCategory.fasting: 'fasting',
  PrayerTopicCategory.other: 'other',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_PrayerPerson _$PrayerPersonFromJson(Map<String, dynamic> json) =>
    _PrayerPerson(
      id: (json['id'] as num).toInt(),
      list: $enumDecode(_$PrayerListEnumMap, json['list']),
      name: json['name'] as String,
      note: json['note'] as String? ?? '',
      lastPrayedOn: _$JsonConverterFromJson<String, DateTime>(
        json['last_prayed_on'],
        const ApiDateConverter().fromJson,
      ),
      answeredOn: _$JsonConverterFromJson<String, DateTime>(
        json['answered_on'],
        const ApiDateConverter().fromJson,
      ),
    );

Map<String, dynamic> _$PrayerPersonToJson(_PrayerPerson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'list': _$PrayerListEnumMap[instance.list]!,
      'name': instance.name,
      'note': instance.note,
      'last_prayed_on': ?_$JsonConverterToJson<String, DateTime>(
        instance.lastPrayedOn,
        const ApiDateConverter().toJson,
      ),
      'answered_on': ?_$JsonConverterToJson<String, DateTime>(
        instance.answeredOn,
        const ApiDateConverter().toJson,
      ),
    };

const _$PrayerListEnumMap = {
  PrayerList.unbelievers: 'unbelievers',
  PrayerList.believers: 'believers',
  PrayerList.backsliders: 'backsliders',
  PrayerList.coworkers: 'coworkers',
};

_RetreatRecord _$RetreatRecordFromJson(Map<String, dynamic> json) =>
    _RetreatRecord(
      day: const ApiDateConverter().fromJson(json['day'] as String),
      moment: $enumDecode(_$RetreatMomentEnumMap, json['moment']),
      minutes: (json['minutes'] as num?)?.toInt() ?? 15,
    );

Map<String, dynamic> _$RetreatRecordToJson(_RetreatRecord instance) =>
    <String, dynamic>{
      'day': const ApiDateConverter().toJson(instance.day),
      'moment': _$RetreatMomentEnumMap[instance.moment]!,
      'minutes': instance.minutes,
    };

const _$RetreatMomentEnumMap = {
  RetreatMoment.morning: 'morning',
  RetreatMoment.noon: 'noon',
  RetreatMoment.evening: 'evening',
  RetreatMoment.night: 'night',
};

_Importunity _$ImportunityFromJson(Map<String, dynamic> json) => _Importunity(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  goal: (json['goal'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt() ?? 0,
  reachedAt: json['reached_at'] == null
      ? null
      : DateTime.parse(json['reached_at'] as String),
  status:
      $enumDecodeNullable(
        _$ImportunityStatusEnumMap,
        json['status'],
        unknownValue: ImportunityStatus.open,
      ) ??
      ImportunityStatus.open,
  owner: MemberCard.fromJson(json['owner'] as Map<String, dynamic>),
  isOwner: json['is_owner'] as bool? ?? false,
  myStatus:
      $enumDecodeNullable(
        _$ImportunityMemberStatusEnumMap,
        json['my_status'],
        unknownValue: ImportunityMemberStatus.joined,
      ) ??
      ImportunityMemberStatus.joined,
  myCount: (json['my_count'] as num?)?.toInt() ?? 0,
  invitedBy: json['invited_by'] == null
      ? null
      : MemberCard.fromJson(json['invited_by'] as Map<String, dynamic>),
  participants: (json['participants'] as num?)?.toInt() ?? 0,
  invited: (json['invited'] as num?)?.toInt() ?? 0,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => MemberCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MemberCard>[],
);

Map<String, dynamic> _$ImportunityToJson(_Importunity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'goal': ?instance.goal,
      'total': instance.total,
      'reached_at': ?instance.reachedAt?.toIso8601String(),
      'status': _$ImportunityStatusEnumMap[instance.status]!,
      'owner': instance.owner.toJson(),
      'is_owner': instance.isOwner,
      'my_status': _$ImportunityMemberStatusEnumMap[instance.myStatus]!,
      'my_count': instance.myCount,
      'invited_by': ?instance.invitedBy?.toJson(),
      'participants': instance.participants,
      'invited': instance.invited,
      'members': instance.members.map((e) => e.toJson()).toList(),
    };

const _$ImportunityStatusEnumMap = {
  ImportunityStatus.open: 'open',
  ImportunityStatus.closed: 'closed',
};

const _$ImportunityMemberStatusEnumMap = {
  ImportunityMemberStatus.invited: 'invited',
  ImportunityMemberStatus.joined: 'joined',
};

_PrayerFamily _$PrayerFamilyFromJson(Map<String, dynamic> json) =>
    _PrayerFamily(
      discipleMaker: json['disciple_maker'] == null
          ? null
          : MemberCard.fromJson(json['disciple_maker'] as Map<String, dynamic>),
      members: (json['members'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PrayerFamilyToJson(_PrayerFamily instance) =>
    <String, dynamic>{
      'disciple_maker': ?instance.discipleMaker?.toJson(),
      'members': instance.members,
    };
