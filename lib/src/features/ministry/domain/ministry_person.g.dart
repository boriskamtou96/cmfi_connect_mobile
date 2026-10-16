// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministry_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MinistryPerson _$MinistryPersonFromJson(Map<String, dynamic> json) =>
    _MinistryPerson(
      id: (json['id'] as num).toInt(),
      kind: $enumDecode(
        _$MinistryPersonKindEnumMap,
        json['kind'],
        unknownValue: MinistryPersonKind.missionary,
      ),
      name: json['name'] as String,
      photo: json['photo'] == null
          ? null
          : EventImage.fromJson(json['photo'] as Map<String, dynamic>),
      countryCode: json['country_code'] as String? ?? '',
      role: json['role'] as String? ?? '',
      sinceYear: (json['since_year'] as num?)?.toInt(),
      years: json['years'] as String? ?? '',
      story: json['story'] as String? ?? '',
      position: (json['position'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MinistryPersonToJson(_MinistryPerson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$MinistryPersonKindEnumMap[instance.kind]!,
      'name': instance.name,
      'photo': ?instance.photo?.toJson(),
      'country_code': instance.countryCode,
      'role': instance.role,
      'since_year': ?instance.sinceYear,
      'years': instance.years,
      'story': instance.story,
      'position': instance.position,
    };

const _$MinistryPersonKindEnumMap = {
  MinistryPersonKind.missionary: 'missionary',
  MinistryPersonKind.hero: 'hero',
};
