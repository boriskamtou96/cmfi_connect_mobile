import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import '../../members/domain/member.dart';

part 'disciple.freezed.dart';
part 'disciple.g.dart';

/// How many disciples a page holds.
const disciplesPageSize = 20;

/// A page of disciples, and how many match in all.
typedef DisciplesPage = ({List<Disciple> items, int total});

/// A member who chose the user as disciple maker or as another spiritual
/// authority, and whose link the user accepted (GET /v1/disciples). They send
/// the user their reports, never their note.
@freezed
abstract class Disciple with _$Disciple {
  const factory Disciple({
    required int authorityId,
    required MemberCard member,

    /// The user is their disciple maker (else one of their authorities).
    @Default(true) bool isDiscipleMaker,

    /// Set by the disciple (on by default); off, [regularity] is null and
    /// their reports can't be read.
    @Default(true) bool sharesRegularity,
    DiscipleRegularity? regularity,
  }) = _Disciple;

  factory Disciple.fromJson(Map<String, dynamic> json) =>
      _$DiscipleFromJson(json);
}

/// How regular a disciple is over the last 30 days: the days filled, the
/// streak, and the means of their goals and of the items they fill.
@freezed
abstract class DiscipleRegularity with _$DiscipleRegularity {
  const factory DiscipleRegularity({
    /// Days in a row with a report, like the disciple's own streak.
    @Default(0) int streak,

    /// The days with a report among the last 30, the newest first.
    @ApiDateConverter() @Default(<DateTime>[]) List<DateTime> days,
    @Default(0) int filledLast30,

    /// Their latest report this year, or null.
    @ApiDateConverter() DateTime? lastDay,

    /// The mean share of their goals reached over 30 days (0 to 100), null
    /// without goals.
    int? goalPercent,

    /// The mean share of their items filled on the days with a report (0 to
    /// 100), null without report.
    int? itemsPercent,
  }) = _DiscipleRegularity;

  factory DiscipleRegularity.fromJson(Map<String, dynamic> json) =>
      _$DiscipleRegularityFromJson(json);
}

/// The reports a disciple sends the user, newest first
/// (GET /v1/disciples/:id/reports): the items and the percentages of each
/// day, never the note.
@freezed
abstract class DiscipleReports with _$DiscipleReports {
  const factory DiscipleReports({
    required int authorityId,
    required MemberCard member,
    @Default(true) bool isDiscipleMaker,

    /// The items they have now (standard and their own).
    @Default(0) int totalItems,
    @Default(<DiscipleDay>[]) List<DiscipleDay> days,
  }) = _DiscipleReports;

  factory DiscipleReports.fromJson(Map<String, dynamic> json) =>
      _$DiscipleReportsFromJson(json);
}

/// One day of a disciple's report.
@freezed
abstract class DiscipleDay with _$DiscipleDay {
  const factory DiscipleDay({
    @ApiDateConverter() required DateTime date,

    /// The share of the day's goals reached (0 to 100), null without goals.
    int? goalPercent,
    @Default(0) int filled,
    @Default(0) int total,
    @Default(0) int itemsPercent,
    @Default(<DiscipleEntry>[]) List<DiscipleEntry> entries,
  }) = _DiscipleDay;

  factory DiscipleDay.fromJson(Map<String, dynamic> json) =>
      _$DiscipleDayFromJson(json);
}

/// An item filled in that day: a standard one (translated by its [code]) or
/// one of the disciple's own (its [label] as typed).
@freezed
abstract class DiscipleEntry with _$DiscipleEntry {
  const factory DiscipleEntry({
    required int activityTypeId,
    required String code,
    required String label,
    String? quantityUnit,
    int? quantity,
    int? durationMinutes,
  }) = _DiscipleEntry;

  factory DiscipleEntry.fromJson(Map<String, dynamic> json) =>
      _$DiscipleEntryFromJson(json);
}
