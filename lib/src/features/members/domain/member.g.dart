// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberCard _$MemberCardFromJson(Map<String, dynamic> json) => _MemberCard(
  username: json['username'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String? ?? '',
  church: json['church'] as String? ?? '',
  assembly: json['assembly'] as String? ?? '',
  avatar: json['avatar'] == null
      ? null
      : EventImage.fromJson(json['avatar'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MemberCardToJson(_MemberCard instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'church': instance.church,
      'assembly': instance.assembly,
      'avatar': ?instance.avatar?.toJson(),
    };

_UsernameCheck _$UsernameCheckFromJson(Map<String, dynamic> json) =>
    _UsernameCheck(
      username: json['username'] as String? ?? '',
      available: json['available'] as bool? ?? false,
      problem: $enumDecodeNullable(
        _$UsernameProblemEnumMap,
        json['problem'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      suggestions:
          (json['suggestions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$UsernameCheckToJson(_UsernameCheck instance) =>
    <String, dynamic>{
      'username': instance.username,
      'available': instance.available,
      'problem': ?_$UsernameProblemEnumMap[instance.problem],
      'suggestions': instance.suggestions,
    };

const _$UsernameProblemEnumMap = {
  UsernameProblem.invalid: 'invalid',
  UsernameProblem.reserved: 'reserved',
  UsernameProblem.taken: 'taken',
};
