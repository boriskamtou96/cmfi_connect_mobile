// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceivedReport _$ReceivedReportFromJson(Map<String, dynamic> json) =>
    _ReceivedReport(
      id: (json['id'] as num).toInt(),
      authorityId: (json['authority_id'] as num).toInt(),
      member: MemberCard.fromJson(json['member'] as Map<String, dynamic>),
      periodFrom: const ApiDateConverter().fromJson(
        json['period_from'] as String,
      ),
      periodTo: const ApiDateConverter().fromJson(json['period_to'] as String),
      sentAt: DateTime.parse(json['sent_at'] as String),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
      reply: json['reply'] as String? ?? '',
      repliedAt: json['replied_at'] == null
          ? null
          : DateTime.parse(json['replied_at'] as String),
    );

Map<String, dynamic> _$ReceivedReportToJson(_ReceivedReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authority_id': instance.authorityId,
      'member': instance.member.toJson(),
      'period_from': const ApiDateConverter().toJson(instance.periodFrom),
      'period_to': const ApiDateConverter().toJson(instance.periodTo),
      'sent_at': instance.sentAt.toIso8601String(),
      'read_at': ?instance.readAt?.toIso8601String(),
      'reply': instance.reply,
      'replied_at': ?instance.repliedAt?.toIso8601String(),
    };
