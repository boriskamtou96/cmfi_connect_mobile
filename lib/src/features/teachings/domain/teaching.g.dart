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

_Teaching _$TeachingFromJson(Map<String, dynamic> json) => _Teaching(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  speaker: json['speaker'] as String? ?? '',
  description: json['description'] as String? ?? '',
  category: json['category'] as String? ?? '',
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
  'recorded_on': ?instance.recordedOn,
  'audio': instance.audio.toJson(),
  'duration_seconds': instance.durationSeconds,
  'cover': ?instance.cover?.toJson(),
};

_TeachingCategory _$TeachingCategoryFromJson(Map<String, dynamic> json) =>
    _TeachingCategory(
      name: json['name'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeachingCategoryToJson(_TeachingCategory instance) =>
    <String, dynamic>{'name': instance.name, 'count': instance.count};
