// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Authority _$AuthorityFromJson(Map<String, dynamic> json) => _Authority(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String?,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
  isDiscipleMaker: json['is_disciple_maker'] as bool? ?? false,
  username: json['username'] as String?,
  church: json['church'] as String?,
  assembly: json['assembly'] as String?,
  status:
      $enumDecodeNullable(
        _$AuthorityStatusEnumMap,
        json['status'],
        unknownValue: AuthorityStatus.accepted,
      ) ??
      AuthorityStatus.accepted,
  avatar: json['avatar'] == null
      ? null
      : EventImage.fromJson(json['avatar'] as Map<String, dynamic>),
  sharesRegularity: json['shares_regularity'] as bool? ?? true,
);

Map<String, dynamic> _$AuthorityToJson(_Authority instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': ?instance.lastName,
      'phone_number': ?instance.phoneNumber,
      'email': ?instance.email,
      'is_disciple_maker': instance.isDiscipleMaker,
      'username': ?instance.username,
      'church': ?instance.church,
      'assembly': ?instance.assembly,
      'status': _$AuthorityStatusEnumMap[instance.status]!,
      'avatar': ?instance.avatar?.toJson(),
      'shares_regularity': instance.sharesRegularity,
    };

const _$AuthorityStatusEnumMap = {
  AuthorityStatus.pending: 'pending',
  AuthorityStatus.accepted: 'accepted',
  AuthorityStatus.declined: 'declined',
};

_AuthorityRequest _$AuthorityRequestFromJson(Map<String, dynamic> json) =>
    _AuthorityRequest(
      id: (json['id'] as num).toInt(),
      from: MemberCard.fromJson(json['from'] as Map<String, dynamic>),
      isDiscipleMaker: json['is_disciple_maker'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthorityRequestToJson(_AuthorityRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': instance.from.toJson(),
      'is_disciple_maker': instance.isDiscipleMaker,
    };
