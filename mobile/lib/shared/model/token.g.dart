// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Token _$$_TokenFromJson(Map<String, dynamic> json) => _$_Token(
      token: json['token'] as String,
      id: json['id'] as String,
      privileges: (json['privileges'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$_TokenToJson(_$_Token instance) => <String, dynamic>{
      'token': instance.token,
      'id': instance.id,
      'privileges': instance.privileges,
      'username': instance.username,
      'avatar': instance.avatar,
    };
