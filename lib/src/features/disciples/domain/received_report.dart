import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import '../../members/domain/member.dart';

part 'received_report.freezed.dart';
part 'received_report.g.dart';

/// A page of reports received, and how many in all.
typedef ReceivedReportsPage = ({List<ReceivedReport> items, int total});

/// A period of reports a disciple sent the user in the app (GET
/// /v1/report-sendings/received): read with their reports
/// ([authorityId]), and answered with a word of encouragement.
@freezed
abstract class ReceivedReport with _$ReceivedReport {
  const factory ReceivedReport({
    required int id,
    required int authorityId,

    /// The disciple.
    required MemberCard member,
    @ApiDateConverter() required DateTime periodFrom,
    @ApiDateConverter() required DateTime periodTo,
    required DateTime sentAt,
    DateTime? readAt,

    /// The user's answer, '' before it.
    @Default('') String reply,
    DateTime? repliedAt,
  }) = _ReceivedReport;

  const ReceivedReport._();

  factory ReceivedReport.fromJson(Map<String, dynamic> json) =>
      _$ReceivedReportFromJson(json);

  bool get unread => readAt == null;
}
