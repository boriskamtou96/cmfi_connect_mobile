// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportSummary _$ReportSummaryFromJson(Map<String, dynamic> json) =>
    _ReportSummary(
      from: const ApiDateConverter().fromJson(json['from'] as String),
      to: const ApiDateConverter().fromJson(json['to'] as String),
      daysInRange: (json['days_in_range'] as num).toInt(),
      daysReported: (json['days_reported'] as num).toInt(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => SummaryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SummaryItem>[],
    );

Map<String, dynamic> _$ReportSummaryToJson(_ReportSummary instance) =>
    <String, dynamic>{
      'from': const ApiDateConverter().toJson(instance.from),
      'to': const ApiDateConverter().toJson(instance.to),
      'days_in_range': instance.daysInRange,
      'days_reported': instance.daysReported,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

_SummaryItem _$SummaryItemFromJson(Map<String, dynamic> json) => _SummaryItem(
  activityTypeId: (json['activity_type_id'] as num).toInt(),
  code: json['code'] as String,
  label: json['label'] as String,
  quantityUnit: json['quantity_unit'] as String?,
  tracksQuantity: json['tracks_quantity'] as bool? ?? false,
  tracksDuration: json['tracks_duration'] as bool? ?? false,
  daysCount: (json['days_count'] as num?)?.toInt() ?? 0,
  totalQuantity: (json['total_quantity'] as num?)?.toInt() ?? 0,
  totalMinutes: (json['total_minutes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SummaryItemToJson(_SummaryItem instance) =>
    <String, dynamic>{
      'activity_type_id': instance.activityTypeId,
      'code': instance.code,
      'label': instance.label,
      'quantity_unit': ?instance.quantityUnit,
      'tracks_quantity': instance.tracksQuantity,
      'tracks_duration': instance.tracksDuration,
      'days_count': instance.daysCount,
      'total_quantity': instance.totalQuantity,
      'total_minutes': instance.totalMinutes,
    };
