// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibraryFile _$LibraryFileFromJson(Map<String, dynamic> json) => _LibraryFile(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  name: json['name'] as String? ?? '',
  kind:
      $enumDecodeNullable(
        _$DocumentKindEnumMap,
        json['kind'],
        unknownValue: DocumentKind.pdf,
      ) ??
      DocumentKind.pdf,
  sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LibraryFileToJson(_LibraryFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'kind': _$DocumentKindEnumMap[instance.kind]!,
      'size_bytes': instance.sizeBytes,
    };

const _$DocumentKindEnumMap = {
  DocumentKind.pdf: 'pdf',
  DocumentKind.word: 'word',
};

_LibraryDocument _$LibraryDocumentFromJson(Map<String, dynamic> json) =>
    _LibraryDocument(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      file: LibraryFile.fromJson(json['file'] as Map<String, dynamic>),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$LibraryDocumentToJson(_LibraryDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'file': instance.file.toJson(),
      'published_at': ?instance.publishedAt?.toIso8601String(),
    };

_DocumentCategory _$DocumentCategoryFromJson(Map<String, dynamic> json) =>
    _DocumentCategory(
      name: json['name'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DocumentCategoryToJson(_DocumentCategory instance) =>
    <String, dynamic>{'name': instance.name, 'count': instance.count};
