// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityType _$ActivityTypeFromJson(Map<String, dynamic> json) =>
    _ActivityType(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      label: json['label'] as String,
      tracksQuantity: json['tracks_quantity'] as bool? ?? false,
      quantityUnit: json['quantity_unit'] as String?,
      tracksDuration: json['tracks_duration'] as bool? ?? false,
      position: (json['position'] as num?)?.toInt() ?? 0,
      isStandard: json['is_standard'] as bool? ?? false,
      goal: json['goal'] == null
          ? null
          : ReportGoal.fromJson(json['goal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityTypeToJson(_ActivityType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'label': instance.label,
      'tracks_quantity': instance.tracksQuantity,
      'quantity_unit': ?instance.quantityUnit,
      'tracks_duration': instance.tracksDuration,
      'position': instance.position,
      'is_standard': instance.isStandard,
      'goal': ?instance.goal?.toJson(),
    };
