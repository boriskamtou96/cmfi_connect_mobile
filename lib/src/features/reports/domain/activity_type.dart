import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_type.freezed.dart';
part 'activity_type.g.dart';

/// A report item (LB, PS, ...): standard for everyone, or personal to the user.
@freezed
abstract class ActivityType with _$ActivityType {
  const factory ActivityType({
    required int id,
    required String code,
    required String label,
    @Default(false) bool tracksQuantity,
    String? quantityUnit,
    @Default(false) bool tracksDuration,
    @Default(0) int position,
    @Default(false) bool isStandard,
  }) = _ActivityType;

  factory ActivityType.fromJson(Map<String, dynamic> json) =>
      _$ActivityTypeFromJson(json);
}
