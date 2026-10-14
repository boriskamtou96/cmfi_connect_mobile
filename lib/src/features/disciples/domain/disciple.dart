import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import '../../members/domain/member.dart';

part 'disciple.freezed.dart';
part 'disciple.g.dart';

/// A member who chose the user as disciple maker, and whose link the user
/// accepted (GET /v1/disciples).
@freezed
abstract class Disciple with _$Disciple {
  const factory Disciple({
    required int authorityId,
    required MemberCard member,

    /// Set by the disciple (on by default); off, [regularity] is null.
    @Default(true) bool sharesRegularity,
    DiscipleRegularity? regularity,
  }) = _Disciple;

  factory Disciple.fromJson(Map<String, dynamic> json) =>
      _$DiscipleFromJson(json);
}

/// How regular a disciple is, never what their reports say: the days filled
/// among the last 30, the streak, and the mean of their goals.
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
  }) = _DiscipleRegularity;

  factory DiscipleRegularity.fromJson(Map<String, dynamic> json) =>
      _$DiscipleRegularityFromJson(json);
}
