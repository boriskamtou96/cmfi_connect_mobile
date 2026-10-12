// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportEntry _$ReportEntryFromJson(Map<String, dynamic> json) => _ReportEntry(
  activityTypeId: (json['activity_type_id'] as num).toInt(),
  code: json['code'] as String,
  label: json['label'] as String,
  tracksQuantity: json['tracks_quantity'] as bool? ?? false,
  quantityUnit: json['quantity_unit'] as String?,
  tracksDuration: json['tracks_duration'] as bool? ?? false,
  quantity: (json['quantity'] as num?)?.toInt(),
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReportEntryToJson(_ReportEntry instance) =>
    <String, dynamic>{
      'activity_type_id': instance.activityTypeId,
      'code': instance.code,
      'label': instance.label,
      'tracks_quantity': instance.tracksQuantity,
      'quantity_unit': ?instance.quantityUnit,
      'tracks_duration': instance.tracksDuration,
      'quantity': ?instance.quantity,
      'duration_minutes': ?instance.durationMinutes,
    };

_DailyReport _$DailyReportFromJson(Map<String, dynamic> json) => _DailyReport(
  date: const ApiDateConverter().fromJson(json['date'] as String),
  note: json['note'] as String?,
  submitted: json['submitted'] as bool? ?? false,
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => ReportEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReportEntry>[],
);

Map<String, dynamic> _$DailyReportToJson(_DailyReport instance) =>
    <String, dynamic>{
      'date': const ApiDateConverter().toJson(instance.date),
      'note': ?instance.note,
      'submitted': instance.submitted,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };
