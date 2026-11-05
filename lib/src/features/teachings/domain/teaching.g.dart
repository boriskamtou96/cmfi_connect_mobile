// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeachingAudio _$TeachingAudioFromJson(Map<String, dynamic> json) =>
    _TeachingAudio(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      format:
          $enumDecodeNullable(
            _$AudioFormatEnumMap,
            json['format'],
            unknownValue: AudioFormat.mp3,
          ) ??
          AudioFormat.mp3,
      sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeachingAudioToJson(_TeachingAudio instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'format': _$AudioFormatEnumMap[instance.format]!,
      'size_bytes': instance.sizeBytes,
    };

const _$AudioFormatEnumMap = {AudioFormat.mp3: 'mp3', AudioFormat.m4a: 'm4a'};

_TeachingEditionBrief _$TeachingEditionBriefFromJson(
  Map<String, dynamic> json,
) => _TeachingEditionBrief(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  theme: json['theme'] as String? ?? '',
  year: (json['year'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TeachingEditionBriefToJson(
  _TeachingEditionBrief instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'theme': instance.theme,
  'year': instance.year,
};

_Teaching _$TeachingFromJson(Map<String, dynamic> json) => _Teaching(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  speaker: json['speaker'] as String? ?? '',
  description: json['description'] as String? ?? '',
  category: json['category'] as String? ?? '',
  categoryId: (json['category_id'] as num?)?.toInt(),
  categorySlug: json['category_slug'] as String? ?? '',
  year: (json['year'] as num?)?.toInt(),
  dayNumber: (json['day_number'] as num?)?.toInt(),
  position: (json['position'] as num?)?.toInt() ?? 0,
  edition: json['edition'] == null
      ? null
      : TeachingEditionBrief.fromJson(json['edition'] as Map<String, dynamic>),
  recordedOn: json['recorded_on'] as String?,
  audio: TeachingAudio.fromJson(json['audio'] as Map<String, dynamic>),
  durationSeconds: (json['duration_seconds'] as num?)?.toInt() ?? 0,
  cover: json['cover'] == null
      ? null
      : EventImage.fromJson(json['cover'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TeachingToJson(_Teaching instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'speaker': instance.speaker,
  'description': instance.description,
  'category': instance.category,
  'category_id': ?instance.categoryId,
  'category_slug': instance.categorySlug,
  'year': ?instance.year,
  'day_number': ?instance.dayNumber,
  'position': instance.position,
  'edition': ?instance.edition?.toJson(),
  'recorded_on': ?instance.recordedOn,
  'audio': instance.audio.toJson(),
  'duration_seconds': instance.durationSeconds,
  'cover': ?instance.cover?.toJson(),
};

_TeachingCategory _$TeachingCategoryFromJson(Map<String, dynamic> json) =>
    _TeachingCategory(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String,
      slug: json['slug'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeachingCategoryToJson(_TeachingCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'count': instance.count,
    };

_TeachingSpeakerFacet _$TeachingSpeakerFacetFromJson(
  Map<String, dynamic> json,
) => _TeachingSpeakerFacet(
  name: json['name'] as String,
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TeachingSpeakerFacetToJson(
  _TeachingSpeakerFacet instance,
) => <String, dynamic>{'name': instance.name, 'count': instance.count};

_TeachingYearFacet _$TeachingYearFacetFromJson(Map<String, dynamic> json) =>
    _TeachingYearFacet(
      year: (json['year'] as num).toInt(),
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeachingYearFacetToJson(_TeachingYearFacet instance) =>
    <String, dynamic>{'year': instance.year, 'count': instance.count};

_TeachingDayFacet _$TeachingDayFacetFromJson(Map<String, dynamic> json) =>
    _TeachingDayFacet(
      day: (json['day'] as num).toInt(),
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeachingDayFacetToJson(_TeachingDayFacet instance) =>
    <String, dynamic>{'day': instance.day, 'count': instance.count};

_TeachingEditionFacet _$TeachingEditionFacetFromJson(
  Map<String, dynamic> json,
) => _TeachingEditionFacet(
  id: (json['id'] as num).toInt(),
  categoryId: (json['category_id'] as num?)?.toInt() ?? 0,
  categoryName: json['category_name'] as String? ?? '',
  categorySlug: json['category_slug'] as String? ?? '',
  year: (json['year'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TeachingEditionFacetToJson(
  _TeachingEditionFacet instance,
) => <String, dynamic>{
  'id': instance.id,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'category_slug': instance.categorySlug,
  'year': instance.year,
  'title': instance.title,
  'count': instance.count,
};

_TeachingFacets _$TeachingFacetsFromJson(
  Map<String, dynamic> json,
) => _TeachingFacets(
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => TeachingCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  speakers:
      (json['speakers'] as List<dynamic>?)
          ?.map((e) => TeachingSpeakerFacet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  years:
      (json['years'] as List<dynamic>?)
          ?.map((e) => TeachingYearFacet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  editions:
      (json['editions'] as List<dynamic>?)
          ?.map((e) => TeachingEditionFacet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  days:
      (json['days'] as List<dynamic>?)
          ?.map((e) => TeachingDayFacet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TeachingFacetsToJson(_TeachingFacets instance) =>
    <String, dynamic>{
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'speakers': instance.speakers.map((e) => e.toJson()).toList(),
      'years': instance.years.map((e) => e.toJson()).toList(),
      'editions': instance.editions.map((e) => e.toJson()).toList(),
      'days': instance.days.map((e) => e.toJson()).toList(),
    };
