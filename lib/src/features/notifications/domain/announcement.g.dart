// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementFile _$AnnouncementFileFromJson(Map<String, dynamic> json) =>
    _AnnouncementFile(
      id: (json['id'] as num).toInt(),
      kind: json['kind'] as String,
      url: json['url'] as String,
      name: json['name'] as String? ?? '',
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
      color: json['color'] as String? ?? '',
      sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AnnouncementFileToJson(_AnnouncementFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'url': instance.url,
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'size_bytes': instance.sizeBytes,
    };

_Announcement _$AnnouncementFromJson(Map<String, dynamic> json) =>
    _Announcement(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => AnnouncementFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AnnouncementFile>[],
      createdAt: DateTime.parse(json['created_at'] as String),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
    );

Map<String, dynamic> _$AnnouncementToJson(_Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
      'read_at': ?instance.readAt?.toIso8601String(),
    };
