import 'package:json_annotation/json_annotation.dart';

import '../utils/date_extensions.dart';

/// "2026-10-08" <-> DateTime(2026, 10, 8), the format of every report date.
class ApiDateConverter implements JsonConverter<DateTime, String> {
  const ApiDateConverter();

  @override
  DateTime fromJson(String json) => parseApiDate(json);

  @override
  String toJson(DateTime object) => object.toApiDate();
}

/// An instant sent to the API: RFC 3339 in UTC ("2026-11-20T07:00:00.000Z"),
/// which Go parses (a local DateTime would have no offset).
class UtcInstantConverter implements JsonConverter<DateTime, String> {
  const UtcInstantConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => DateTime.fromMicrosecondsSinceEpoch(
    object.microsecondsSinceEpoch,
    isUtc: true,
  ).toIso8601String();
}
