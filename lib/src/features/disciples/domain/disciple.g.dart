// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Disciple _$DiscipleFromJson(Map<String, dynamic> json) => _Disciple(
  authorityId: (json['authority_id'] as num).toInt(),
  member: MemberCard.fromJson(json['member'] as Map<String, dynamic>),
  sharesRegularity: json['shares_regularity'] as bool? ?? true,
  regularity: json['regularity'] == null
      ? null
      : DiscipleRegularity.fromJson(json['regularity'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DiscipleToJson(_Disciple instance) => <String, dynamic>{
  'authority_id': instance.authorityId,
  'member': instance.member.toJson(),
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
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
