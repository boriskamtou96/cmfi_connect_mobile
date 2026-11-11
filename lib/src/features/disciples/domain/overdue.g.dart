// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overdue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Overdue _$OverdueFromJson(Map<String, dynamic> json) => _Overdue(
  days: (json['days'] as num?)?.toInt() ?? 3,
  sharing: (json['sharing'] as num?)?.toInt() ?? 0,
  notSharing: (json['not_sharing'] as num?)?.toInt() ?? 0,
  overdue:
      (json['overdue'] as List<dynamic>?)
          ?.map((e) => OverdueDisciple.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OverdueDisciple>[],
);

Map<String, dynamic> _$OverdueToJson(_Overdue instance) => <String, dynamic>{
  'days': instance.days,
  'sharing': instance.sharing,
  'not_sharing': instance.notSharing,
  'overdue': instance.overdue.map((e) => e.toJson()).toList(),
};

_OverdueDisciple _$OverdueDiscipleFromJson(Map<String, dynamic> json) =>
    _OverdueDisciple(
      authorityId: (json['authority_id'] as num).toInt(),
      member: MemberCard.fromJson(json['member'] as Map<String, dynamic>),
      isDiscipleMaker: json['is_disciple_maker'] as bool? ?? true,
      lastDay: _$JsonConverterFromJson<String, DateTime>(
        json['last_day'],
        const ApiDateConverter().fromJson,
      ),
      daysSince: (json['days_since'] as num?)?.toInt(),
      canNudge: json['can_nudge'] as bool? ?? true,
    );

Map<String, dynamic> _$OverdueDiscipleToJson(_OverdueDisciple instance) =>
    <String, dynamic>{
      'authority_id': instance.authorityId,
      'member': instance.member.toJson(),
      'is_disciple_maker': instance.isDiscipleMaker,
      'last_day': ?_$JsonConverterToJson<String, DateTime>(
        instance.lastDay,
        const ApiDateConverter().toJson,
      ),
      'days_since': ?instance.daysSince,
      'can_nudge': instance.canNudge,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
