import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';

part 'in_app_sending.freezed.dart';
part 'in_app_sending.g.dart';

/// A period of the report sent in the app to an authority who is a member
/// ([authorityId], POST /v1/report-sendings), and their answer once they
/// gave one.
@freezed
abstract class InAppSending with _$InAppSending {
  const factory InAppSending({
    required int id,
    required int authorityId,
    @ApiDateConverter() required DateTime periodFrom,
    @ApiDateConverter() required DateTime periodTo,
    required DateTime sentAt,
    DateTime? readAt,

    /// '' before an answer.
    @Default('') String reply,
    DateTime? repliedAt,
  }) = _InAppSending;

  factory InAppSending.fromJson(Map<String, dynamic> json) =>
      _$InAppSendingFromJson(json);
}
