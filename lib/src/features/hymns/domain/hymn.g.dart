// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HymnPart _$HymnPartFromJson(Map<String, dynamic> json) => _HymnPart(
  kind: $enumDecode(
    _$HymnPartKindEnumMap,
    json['kind'],
    unknownValue: HymnPartKind.verse,
  ),
  label: json['label'] as String?,
  repeat: (json['repeat'] as num?)?.toInt() ?? 0,
  lines: (json['lines'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$HymnPartToJson(_HymnPart instance) => <String, dynamic>{
  'kind': _$HymnPartKindEnumMap[instance.kind]!,
  'label': ?instance.label,
  'repeat': instance.repeat,
  'lines': instance.lines,
};

const _$HymnPartKindEnumMap = {
  HymnPartKind.verse: 'verse',
  HymnPartKind.chorus: 'chorus',
};

_Hymn _$HymnFromJson(Map<String, dynamic> json) => _Hymn(
  number: (json['number'] as num).toInt(),
  title: json['title'] as String,
  author: json['author'] as String?,
  firstLine: json['first_line'] as String? ?? '',
  parts: (json['parts'] as List<dynamic>)
      .map((e) => HymnPart.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HymnToJson(_Hymn instance) => <String, dynamic>{
  'number': instance.number,
  'title': instance.title,
  'author': ?instance.author,
  'first_line': instance.firstLine,
  'parts': instance.parts.map((e) => e.toJson()).toList(),
};

_HymnBook _$HymnBookFromJson(Map<String, dynamic> json) => _HymnBook(
  code: json['code'] as String,
  title: json['title'] as String,
  language: json['language'] as String? ?? 'fr',
  hymnCount: (json['hymn_count'] as num?)?.toInt() ?? 0,
  version: json['version'] as String,
  hymns:
      (json['hymns'] as List<dynamic>?)
          ?.map((e) => Hymn.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Hymn>[],
);

Map<String, dynamic> _$HymnBookToJson(_HymnBook instance) => <String, dynamic>{
  'code': instance.code,
  'title': instance.title,
  'language': instance.language,
  'hymn_count': instance.hymnCount,
  'version': instance.version,
  'hymns': instance.hymns.map((e) => e.toJson()).toList(),
};

_HymnBookSummary _$HymnBookSummaryFromJson(Map<String, dynamic> json) =>
    _HymnBookSummary(
      code: json['code'] as String,
      title: json['title'] as String,
      language: json['language'] as String? ?? 'fr',
      hymnCount: (json['hymn_count'] as num?)?.toInt() ?? 0,
      version: json['version'] as String,
    );

Map<String, dynamic> _$HymnBookSummaryToJson(_HymnBookSummary instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'language': instance.language,
      'hymn_count': instance.hymnCount,
      'version': instance.version,
    };
