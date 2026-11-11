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
  book: json['book'] == null
      ? null
      : EntryBook.fromJson(json['book'] as Map<String, dynamic>),
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
      'book': ?instance.book?.toJson(),
    };

_EntryBook _$EntryBookFromJson(Map<String, dynamic> json) => _EntryBook(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  author: json['author'] as String? ?? '',
  totalPages: (json['total_pages'] as num).toInt(),
  coverUrl: json['cover_url'] as String? ?? '',
  pageReached: (json['page_reached'] as num?)?.toInt(),
);

Map<String, dynamic> _$EntryBookToJson(_EntryBook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'total_pages': instance.totalPages,
      'cover_url': instance.coverUrl,
      'page_reached': ?instance.pageReached,
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
