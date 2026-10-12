// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String? ?? '',
  phoneNumber: json['phone_number'] as String,
  email: json['email'] as String? ?? '',
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
  city: json['city'] as String?,
  country: json['country'] as String?,
  church: json['church'] as String?,
  assembly: json['assembly'] as String?,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'birth_date': ?instance.birthDate?.toIso8601String(),
  'city': ?instance.city,
  'country': ?instance.country,
  'church': ?instance.church,
  'assembly': ?instance.assembly,
};
