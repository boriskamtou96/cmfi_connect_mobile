// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Nation _$NationFromJson(Map<String, dynamic> json) => _Nation(
  id: (json['id'] as num).toInt(),
  position: (json['position'] as num).toInt(),
  name: json['name'] as String,
  countryCode: json['country_code'] as String? ?? '',
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  arrivalYear: (json['arrival_year'] as num?)?.toInt(),
);

Map<String, dynamic> _$NationToJson(_Nation instance) => <String, dynamic>{
  'id': instance.id,
  'position': instance.position,
  'name': instance.name,
  'country_code': instance.countryCode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'arrival_year': ?instance.arrivalYear,
};
