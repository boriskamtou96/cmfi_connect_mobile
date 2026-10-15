// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_marks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BibleMark _$BibleMarkFromJson(Map<String, dynamic> json) => _BibleMark(
  key: json['key'] as String,
  text: json['text'] as String,
  version: json['version'] as String,
  at: DateTime.parse(json['at'] as String),
  color: (json['color'] as num?)?.toInt(),
  bookmarked: json['bookmarked'] as bool? ?? false,
);

Map<String, dynamic> _$BibleMarkToJson(_BibleMark instance) =>
    <String, dynamic>{
      'key': instance.key,
      'text': instance.text,
      'version': instance.version,
      'at': instance.at.toIso8601String(),
      'color': ?instance.color,
      'bookmarked': instance.bookmarked,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The highlights and favourite verses, kept on the phone (by verse key).

@ProviderFor(BibleMarks)
final bibleMarksProvider = BibleMarksProvider._();

/// The highlights and favourite verses, kept on the phone (by verse key).
final class BibleMarksProvider
    extends $NotifierProvider<BibleMarks, Map<String, BibleMark>> {
  /// The highlights and favourite verses, kept on the phone (by verse key).
  BibleMarksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleMarksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleMarksHash();

  @$internal
  @override
  BibleMarks create() => BibleMarks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, BibleMark> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, BibleMark>>(value),
    );
  }
}

String _$bibleMarksHash() => r'52a3a156be4a1259734fbc88fe40614fd9bccf08';

/// The highlights and favourite verses, kept on the phone (by verse key).

abstract class _$BibleMarks extends $Notifier<Map<String, BibleMark>> {
  Map<String, BibleMark> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<String, BibleMark>, Map<String, BibleMark>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, BibleMark>, Map<String, BibleMark>>,
              Map<String, BibleMark>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
