// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Account _$AccountFromJson(Map<String, dynamic> json) => _Account(
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String? ?? '',
  phoneNumber: json['phone_number'] as String,
  email: json['email'] as String? ?? '',
  id: (json['id'] as num?)?.toInt() ?? 0,
  username: json['username'] as String? ?? '',
  role: json['role'] as String? ?? 'user',
);

Map<String, dynamic> _$AccountToJson(_Account instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'id': instance.id,
  'username': instance.username,
  'role': instance.role,
};
