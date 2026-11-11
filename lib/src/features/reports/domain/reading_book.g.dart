// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingBook _$ReadingBookFromJson(Map<String, dynamic> json) => _ReadingBook(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  author: json['author'] as String? ?? '',
  totalPages: (json['total_pages'] as num).toInt(),
  coverUrl: json['cover_url'] as String? ?? '',
  status:
      $enumDecodeNullable(
        _$ReadingStatusEnumMap,
        json['status'],
        unknownValue: ReadingStatus.reading,
      ) ??
      ReadingStatus.reading,
  startedOn: const ApiDateConverter().fromJson(json['started_on'] as String),
  finishedOn: _$JsonConverterFromJson<String, DateTime>(
    json['finished_on'],
    const ApiDateConverter().fromJson,
  ),
  pagesRead: (json['pages_read'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ReadingBookToJson(_ReadingBook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'total_pages': instance.totalPages,
      'cover_url': instance.coverUrl,
      'status': _$ReadingStatusEnumMap[instance.status]!,
      'started_on': const ApiDateConverter().toJson(instance.startedOn),
      'finished_on': ?_$JsonConverterToJson<String, DateTime>(
        instance.finishedOn,
        const ApiDateConverter().toJson,
      ),
      'pages_read': instance.pagesRead,
    };

const _$ReadingStatusEnumMap = {
  ReadingStatus.reading: 'reading',
  ReadingStatus.finished: 'finished',
  ReadingStatus.abandoned: 'abandoned',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_BookFound _$BookFoundFromJson(Map<String, dynamic> json) => _BookFound(
  title: json['title'] as String,
  author: json['author'] as String? ?? '',
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
  coverUrl: json['cover_url'] as String? ?? '',
);

Map<String, dynamic> _$BookFoundToJson(_BookFound instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'total_pages': instance.totalPages,
      'cover_url': instance.coverUrl,
    };

_ReadingStats _$ReadingStatsFromJson(Map<String, dynamic> json) =>
    _ReadingStats(
      year: (json['year'] as num).toInt(),
      months:
          (json['months'] as List<dynamic>?)
              ?.map((e) => ReadingMonth.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadingMonth>[],
      booksFinished: (json['books_finished'] as num?)?.toInt() ?? 0,
      pages: (json['pages'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReadingStatsToJson(_ReadingStats instance) =>
    <String, dynamic>{
      'year': instance.year,
      'months': instance.months.map((e) => e.toJson()).toList(),
      'books_finished': instance.booksFinished,
      'pages': instance.pages,
    };

_ReadingMonth _$ReadingMonthFromJson(Map<String, dynamic> json) =>
    _ReadingMonth(
      month: json['month'] as String,
      books: (json['books'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReadingMonthToJson(_ReadingMonth instance) =>
    <String, dynamic>{'month': instance.month, 'books': instance.books};
