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

    /// "Prédications"…; '' when none.
    @Default('') String category,

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
    required String name,
    @Default(0) int count,
  }) = _TeachingCategory;

  factory TeachingCategory.fromJson(Map<String, dynamic> json) =>
      _$TeachingCategoryFromJson(json);
}

/// "1:02:05", "52:10": the length of a message.
String formatClock(Duration duration) {
  final seconds = duration.inSeconds.abs();
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = (seconds % 60).toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$s' : '$m:$s';
}
