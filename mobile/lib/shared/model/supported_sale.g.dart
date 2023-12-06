// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SupportedSale _$$_SupportedSaleFromJson(Map<String, dynamic> json) =>
    _$_SupportedSale(
      id: json['id'] as String,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      blocked: json['blocked'] as bool?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_SupportedSaleToJson(_$_SupportedSale instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'avatar': instance.avatar,
      'blocked': instance.blocked,
      'roles': instance.roles,
    };
