import 'package:freezed_annotation/freezed_annotation.dart';

import '../../events/domain/event.dart';

part 'teaching.freezed.dart';
part 'teaching.g.dart';

/// An MP3, or an M4A.
enum AudioFormat { mp3, m4a }

/// The sound of a teaching, kept by the server ("/v1/media/….mp3", or the
/// CDN's address).
@freezed
abstract class TeachingAudio with _$TeachingAudio {
  const factory TeachingAudio({
    required int id,
    required String url,
    @JsonKey(unknownEnumValue: AudioFormat.mp3)
    @Default(AudioFormat.mp3)
    AudioFormat format,
    @Default(0) int sizeBytes,
  }) = _TeachingAudio;

  factory TeachingAudio.fromJson(Map<String, dynamic> json) =>
      _$TeachingAudioFromJson(json);
}

/// The annual edition of a teaching ("Camp des jeunes 2026"), as the
/// teaching carries it.
@freezed
abstract class TeachingEditionBrief with _$TeachingEditionBrief {
  const factory TeachingEditionBrief({
    required int id,
    @Default('') String title,
    @Default('') String theme,
    @Default(0) int year,
  }) = _TeachingEditionBrief;

  factory TeachingEditionBrief.fromJson(Map<String, dynamic> json) =>
      _$TeachingEditionBriefFromJson(json);
}

/// An audio message of the Enseignements (GET /v1/teachings): a preaching or
/// a teaching sent by the admins.
@freezed
abstract class Teaching with _$Teaching {
  const factory Teaching({
    required int id,
    required String title,

    /// "Pr Zacharias Tanee Fomum"; '' when not said.
    @Default('') String speaker,
    @Default('') String description,

    /// "Prédications"…; '' when none. Kept for the apps that don't know
    /// [categoryId] yet.
    @Default('') String category,

    /// The category chosen by the admins; null when none.
    int? categoryId,

    /// "camp-des-jeunes": the category in the addresses of the API.
    @Default('') String categorySlug,

    /// "2026"; null when unknown.
    int? year,

    /// Day 1, 2… of a camp or a crusade; several may share it.
    int? dayNumber,

    /// Their order inside the day.
    @Default(0) int position,

    /// The annual edition ("Camp des jeunes 2026"); null when none.
    TeachingEditionBrief? edition,

    /// The day the message was given ("1994-08-15"), null when unknown.
    String? recordedOn,
    required TeachingAudio audio,

    /// Read by the admin site; 0 when unknown (the player knows it then).
    @Default(0) int durationSeconds,
    EventImage? cover,
  }) = _Teaching;

  const Teaching._();

  factory Teaching.fromJson(Map<String, dynamic> json) =>
      _$TeachingFromJson(json);

  Duration? get duration =>
      durationSeconds > 0 ? Duration(seconds: durationSeconds) : null;

  DateTime? get recordedDay =>
      recordedOn == null ? null : DateTime.tryParse(recordedOn!);
}

/// A category of the published teachings, and how many it holds.
@freezed
abstract class TeachingCategory with _$TeachingCategory {
  const factory TeachingCategory({
    @Default(0) int id,
    required String name,
    @Default('') String slug,
    @Default(0) int count,
  }) = _TeachingCategory;

  factory TeachingCategory.fromJson(Map<String, dynamic> json) =>
      _$TeachingCategoryFromJson(json);
}

/// A speaker, a year, a day or an edition of the filters, and how many
/// messages each holds (GET /v1/teachings/facets).
@freezed
abstract class TeachingSpeakerFacet with _$TeachingSpeakerFacet {
  const factory TeachingSpeakerFacet({
    required String name,
    @Default(0) int count,
  }) = _TeachingSpeakerFacet;

  factory TeachingSpeakerFacet.fromJson(Map<String, dynamic> json) =>
      _$TeachingSpeakerFacetFromJson(json);
}

@freezed
abstract class TeachingYearFacet with _$TeachingYearFacet {
  const factory TeachingYearFacet({required int year, @Default(0) int count}) =
      _TeachingYearFacet;

  factory TeachingYearFacet.fromJson(Map<String, dynamic> json) =>
      _$TeachingYearFacetFromJson(json);
}

@freezed
abstract class TeachingDayFacet with _$TeachingDayFacet {
  const factory TeachingDayFacet({required int day, @Default(0) int count}) =
      _TeachingDayFacet;

  factory TeachingDayFacet.fromJson(Map<String, dynamic> json) =>
      _$TeachingDayFacetFromJson(json);
}

@freezed
abstract class TeachingEditionFacet with _$TeachingEditionFacet {
  const factory TeachingEditionFacet({
    required int id,
    @Default(0) int categoryId,
    @Default('') String categoryName,
    @Default('') String categorySlug,
    @Default(0) int year,
    @Default('') String title,
    @Default(0) int count,
  }) = _TeachingEditionFacet;

  factory TeachingEditionFacet.fromJson(Map<String, dynamic> json) =>
      _$TeachingEditionFacetFromJson(json);
}

/// The values and counts of the filters; [days] only for an edition.
@freezed
abstract class TeachingFacets with _$TeachingFacets {
  const factory TeachingFacets({
    @Default([]) List<TeachingCategory> categories,
    @Default([]) List<TeachingSpeakerFacet> speakers,
    @Default([]) List<TeachingYearFacet> years,
    @Default([]) List<TeachingEditionFacet> editions,
    @Default([]) List<TeachingDayFacet> days,
  }) = _TeachingFacets;

  factory TeachingFacets.fromJson(Map<String, dynamic> json) =>
      _$TeachingFacetsFromJson(json);
}

/// "1:02:05", "52:10": the length of a message.
String formatClock(Duration duration) {
  final seconds = duration.inSeconds.abs();
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = (seconds % 60).toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$s' : '$m:$s';
}
