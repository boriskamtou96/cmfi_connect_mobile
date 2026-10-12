import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import '../../members/domain/member.dart';

part 'prayer.freezed.dart';
part 'prayer.g.dart';

// ----- prayer topics of the community -----

enum PrayerTopicCategory { church, nations, sick, event, fasting, other }

/// The PDF a topic was made from ("/v1/media/….pdf", relative to the API).
@freezed
abstract class PrayerDocument with _$PrayerDocument {
  const factory PrayerDocument({
    required String url,
    @Default('') String name,
    @Default(0) int sizeBytes,
  }) = _PrayerDocument;

  factory PrayerDocument.fromJson(Map<String, dynamic> json) =>
      _$PrayerDocumentFromJson(json);
}

/// A prayer topic published by the admins, for a period: numbered points.
@freezed
abstract class PrayerTopic with _$PrayerTopic {
  const factory PrayerTopic({
    required int id,
    required String title,
    @JsonKey(unknownEnumValue: PrayerTopicCategory.other)
    @Default(PrayerTopicCategory.church)
    PrayerTopicCategory category,
    @Default('') String verse,
    @ApiDateConverter() required DateTime startsOn,

    /// null: no end.
    @ApiDateConverter() DateTime? endsOn,
    int? eventId,
    PrayerDocument? document,
    @Default(<String>[]) List<String> points,

    /// How many members pray for it (never who).
    @Default(0) int people,

    /// The points (1, 2…) the user prayed for today.
    @Default(<int>[]) List<int> prayedToday,
  }) = _PrayerTopic;

  const PrayerTopic._();

  factory PrayerTopic.fromJson(Map<String, dynamic> json) =>
      _$PrayerTopicFromJson(json);

  bool get allPrayed =>
      points.isNotEmpty && prayedToday.length >= points.length;
}

// ----- the user's own lists -----

/// The lists the retreats pray for, in the order of the app.
enum PrayerList { unbelievers, believers, backsliders, coworkers }

@freezed
abstract class PrayerPerson with _$PrayerPerson {
  const factory PrayerPerson({
    required int id,
    required PrayerList list,
    required String name,
    @Default('') String note,

    /// The last day a retreat prayed for them: the others come first.
    @ApiDateConverter() DateTime? lastPrayedOn,

    /// Believed in the Lord, came back, or the prayer was answered.
    @ApiDateConverter() DateTime? answeredOn,
  }) = _PrayerPerson;

  const PrayerPerson._();

  factory PrayerPerson.fromJson(Map<String, dynamic> json) =>
      _$PrayerPersonFromJson(json);

  bool get answered => answeredOn != null;
}

// ----- the 15-minute retreats -----

/// The four retreats of the day, in their order.
enum RetreatMoment { morning, noon, evening, night }

/// A retreat made: the user prayed [minutes] at [moment] of [day].
@freezed
abstract class RetreatRecord with _$RetreatRecord {
  const factory RetreatRecord({
    @ApiDateConverter() required DateTime day,
    required RetreatMoment moment,
    @Default(15) int minutes,
  }) = _RetreatRecord;

  factory RetreatRecord.fromJson(Map<String, dynamic> json) =>
      _$RetreatRecordFromJson(json);
}

// ----- importunity topics -----

enum ImportunityStatus { open, closed }

/// invited: waits for an answer; joined: prays and counts.
enum ImportunityMemberStatus { invited, joined }

/// A topic presented to the Lord without tiring ("Lord, save Paul"): its
/// participants count their proclamations together until [goal]. Each one
/// sees the total and their own count, never the count of the others.
@freezed
abstract class Importunity with _$Importunity {
  const factory Importunity({
    required int id,
    required String title,
    @Default('') String description,

    /// null: the proclamations are only counted.
    int? goal,
    @Default(0) int total,
    DateTime? reachedAt,
    @JsonKey(unknownEnumValue: ImportunityStatus.open)
    @Default(ImportunityStatus.open)
    ImportunityStatus status,
    required MemberCard owner,
    @Default(false) bool isOwner,
    @JsonKey(unknownEnumValue: ImportunityMemberStatus.joined)
    @Default(ImportunityMemberStatus.joined)
    ImportunityMemberStatus myStatus,
    @Default(0) int myCount,
    MemberCard? invitedBy,

    /// How many joined, and how many invitations wait for an answer.
    @Default(0) int participants,
    @Default(0) int invited,

    /// Who prays (names only), in the detail.
    @Default(<MemberCard>[]) List<MemberCard> members,
  }) = _Importunity;

  const Importunity._();

  factory Importunity.fromJson(Map<String, dynamic> json) =>
      _$ImportunityFromJson(json);

  bool get reached => reachedAt != null;
  bool get isOpen => status == ImportunityStatus.open;
  bool get isInvitation => myStatus == ImportunityMemberStatus.invited;

  /// 0 to 1, null without a goal.
  double? get progress =>
      goal == null ? null : (total / goal!).clamp(0, 1).toDouble();
}

/// Whom "invite my spiritual family" reaches: the user's disciple maker (FD)
/// and their other disciples.
@freezed
abstract class PrayerFamily with _$PrayerFamily {
  const factory PrayerFamily({
    /// null: no disciple maker linked in the app.
    MemberCard? discipleMaker,
    @Default(0) int members,
  }) = _PrayerFamily;

  factory PrayerFamily.fromJson(Map<String, dynamic> json) =>
      _$PrayerFamilyFromJson(json);
}
