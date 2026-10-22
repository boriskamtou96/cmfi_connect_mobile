// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  purpose: json['purpose'] as String? ?? 'event',
  status:
      $enumDecodeNullable(
        _$PaymentStatusEnumMap,
        json['status'],
        unknownValue: PaymentStatus.pending,
      ) ??
      PaymentStatus.pending,
  failureCode: json['failure_code'] as String? ?? '',
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String? ?? 'XAF',
  provider: json['provider'] as String? ?? '',
  eventId: (json['event_id'] as num?)?.toInt(),
  people: (json['people'] as num?)?.toInt() ?? 1,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'purpose': instance.purpose,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'failure_code': instance.failureCode,
  'amount': instance.amount,
  'currency': instance.currency,
  'provider': instance.provider,
  'event_id': ?instance.eventId,
  'people': instance.people,
  'created_at': ?instance.createdAt?.toIso8601String(),
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunding: 'refunding',
  PaymentStatus.refunded: 'refunded',
};

_MobileMoneyOperator _$MobileMoneyOperatorFromJson(Map<String, dynamic> json) =>
    _MobileMoneyOperator(
      provider: json['provider'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String? ?? '',
      minAmount: json['min_amount'] as String? ?? '',
      maxAmount: json['max_amount'] as String? ?? '',
      status: json['status'] as String? ?? 'OPERATIONAL',
    );

Map<String, dynamic> _$MobileMoneyOperatorToJson(
  _MobileMoneyOperator instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'name': instance.name,
  'logo': instance.logo,
  'min_amount': instance.minAmount,
  'max_amount': instance.maxAmount,
  'status': instance.status,
};

_MobileMoneyCountry _$MobileMoneyCountryFromJson(Map<String, dynamic> json) =>
    _MobileMoneyCountry(
      country: json['country'] as String,
      names:
          (json['names'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      prefix: json['prefix'] as String? ?? '',
      operators:
          (json['providers'] as List<dynamic>?)
              ?.map(
                (e) => MobileMoneyOperator.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <MobileMoneyOperator>[],
    );

Map<String, dynamic> _$MobileMoneyCountryToJson(_MobileMoneyCountry instance) =>
    <String, dynamic>{
      'country': instance.country,
      'names': instance.names,
      'prefix': instance.prefix,
      'providers': instance.operators.map((e) => e.toJson()).toList(),
    };

_OperatorGuess _$OperatorGuessFromJson(Map<String, dynamic> json) =>
    _OperatorGuess(
      country: json['country'] as String,
      provider: json['provider'] as String,
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$OperatorGuessToJson(_OperatorGuess instance) =>
    <String, dynamic>{
      'country': instance.country,
      'provider': instance.provider,
      'phone_number': instance.phoneNumber,
    };
