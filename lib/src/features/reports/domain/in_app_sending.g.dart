// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_sending.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InAppSending _$InAppSendingFromJson(Map<String, dynamic> json) =>
    _InAppSending(
      id: (json['id'] as num).toInt(),
      authorityId: (json['authority_id'] as num).toInt(),
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

Map<String, dynamic> _$InAppSendingToJson(_InAppSending instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authority_id': instance.authorityId,
      'period_from': const ApiDateConverter().toJson(instance.periodFrom),
      'period_to': const ApiDateConverter().toJson(instance.periodTo),
      'sent_at': instance.sentAt.toIso8601String(),
      'read_at': ?instance.readAt?.toIso8601String(),
      'reply': instance.reply,
      'replied_at': ?instance.repliedAt?.toIso8601String(),
    };
