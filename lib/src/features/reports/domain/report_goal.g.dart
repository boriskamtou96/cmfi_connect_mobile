// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportGoal _$ReportGoalFromJson(Map<String, dynamic> json) => _ReportGoal(
  quantity: (json['quantity'] as num?)?.toInt(),
  minutes: (json['minutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReportGoalToJson(_ReportGoal instance) =>
    <String, dynamic>{
      'quantity': ?instance.quantity,
      'minutes': ?instance.minutes,
    };
