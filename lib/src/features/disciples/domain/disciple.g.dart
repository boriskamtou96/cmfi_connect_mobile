// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Disciple _$DiscipleFromJson(Map<String, dynamic> json) => _Disciple(
  authorityId: (json['authority_id'] as num).toInt(),
  member: MemberCard.fromJson(json['member'] as Map<String, dynamic>),
  isDiscipleMaker: json['is_disciple_maker'] as bool? ?? true,
  sharesRegularity: json['shares_regularity'] as bool? ?? true,
  regularity: json['regularity'] == null
      ? null
      : DiscipleRegularity.fromJson(json['regularity'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DiscipleToJson(_Disciple instance) => <String, dynamic>{
  'authority_id': instance.authorityId,
  'member': instance.member.toJson(),
  'is_disciple_maker': instance.isDiscipleMaker,
  'shares_regularity': instance.sharesRegularity,
  'regularity': ?instance.regularity?.toJson(),
};

_DiscipleRegularity _$DiscipleRegularityFromJson(Map<String, dynamic> json) =>
    _DiscipleRegularity(
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      days:
          (json['days'] as List<dynamic>?)
              ?.map((e) => const ApiDateConverter().fromJson(e as String))
              .toList() ??
          const <DateTime>[],
      filledLast30: (json['filled_last30'] as num?)?.toInt() ?? 0,
      lastDay: _$JsonConverterFromJson<String, DateTime>(
        json['last_day'],
        const ApiDateConverter().fromJson,
      ),
      goalPercent: (json['goal_percent'] as num?)?.toInt(),
      itemsPercent: (json['items_percent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DiscipleRegularityToJson(_DiscipleRegularity instance) =>
    <String, dynamic>{
      'streak': instance.streak,
      'days': instance.days.map(const ApiDateConverter().toJson).toList(),
      'filled_last30': instance.filledLast30,
      'last_day': ?_$JsonConverterToJson<String, DateTime>(
        instance.lastDay,
        const ApiDateConverter().toJson,
      ),
      'goal_percent': ?instance.goalPercent,
      'items_percent': ?instance.itemsPercent,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_DiscipleReports _$DiscipleReportsFromJson(Map<String, dynamic> json) =>
    _DiscipleReports(
      authorityId: (json['authority_id'] as num).toInt(),
      member: MemberCard.fromJson(json['member'] as Map<String, dynamic>),
      isDiscipleMaker: json['is_disciple_maker'] as bool? ?? true,
      totalItems: (json['total_items'] as num?)?.toInt() ?? 0,
      days:
          (json['days'] as List<dynamic>?)
              ?.map((e) => DiscipleDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DiscipleDay>[],
    );

Map<String, dynamic> _$DiscipleReportsToJson(_DiscipleReports instance) =>
    <String, dynamic>{
      'authority_id': instance.authorityId,
      'member': instance.member.toJson(),
      'is_disciple_maker': instance.isDiscipleMaker,
      'total_items': instance.totalItems,
      'days': instance.days.map((e) => e.toJson()).toList(),
    };

_DiscipleDay _$DiscipleDayFromJson(Map<String, dynamic> json) => _DiscipleDay(
  date: const ApiDateConverter().fromJson(json['date'] as String),
  goalPercent: (json['goal_percent'] as num?)?.toInt(),
  filled: (json['filled'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
  itemsPercent: (json['items_percent'] as num?)?.toInt() ?? 0,
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => DiscipleEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DiscipleEntry>[],
);

Map<String, dynamic> _$DiscipleDayToJson(_DiscipleDay instance) =>
    <String, dynamic>{
      'date': const ApiDateConverter().toJson(instance.date),
      'goal_percent': ?instance.goalPercent,
      'filled': instance.filled,
      'total': instance.total,
      'items_percent': instance.itemsPercent,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };

_DiscipleEntry _$DiscipleEntryFromJson(Map<String, dynamic> json) =>
    _DiscipleEntry(
      activityTypeId: (json['activity_type_id'] as num).toInt(),
      code: json['code'] as String,
      label: json['label'] as String,
      quantityUnit: json['quantity_unit'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DiscipleEntryToJson(_DiscipleEntry instance) =>
    <String, dynamic>{
      'activity_type_id': instance.activityTypeId,
      'code': instance.code,
      'label': instance.label,
      'quantity_unit': ?instance.quantityUnit,
      'quantity': ?instance.quantity,
      'duration_minutes': ?instance.durationMinutes,
    };
