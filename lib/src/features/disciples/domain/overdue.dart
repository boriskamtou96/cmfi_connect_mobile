import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import '../../members/domain/member.dart';

part 'overdue.freezed.dart';
part 'overdue.g.dart';

/// The disciples who share their reports and haven't filled one for a while
/// (GET /v1/disciples/overdue), the longest without first.
@freezed
abstract class Overdue with _$Overdue {
  const factory Overdue({
    /// The threshold asked: no report for this many days.
    @Default(3) int days,

    /// How many disciples share their reports.
    @Default(0) int sharing,

    /// How many don't: nothing is known about them.
    @Default(0) int notSharing,
    @Default(<OverdueDisciple>[]) List<OverdueDisciple> overdue,
  }) = _Overdue;

  factory Overdue.fromJson(Map<String, dynamic> json) =>
      _$OverdueFromJson(json);
}

/// A late disciple.
@freezed
abstract class OverdueDisciple with _$OverdueDisciple {
  const factory OverdueDisciple({
    required int authorityId,
    required MemberCard member,
    @Default(true) bool isDiscipleMaker,

    /// Their latest report, null when they never filled one.
    @ApiDateConverter() DateTime? lastDay,

    /// The days since [lastDay], null without one.
    int? daysSince,

    /// Whether a reminder can go now: none in the last 24 hours.
    @Default(true) bool canNudge,
  }) = _OverdueDisciple;

  factory OverdueDisciple.fromJson(Map<String, dynamic> json) =>
      _$OverdueDiscipleFromJson(json);
}

/// How a round of reminders ended.
typedef NudgeResult = ({int sent, int skipped});
