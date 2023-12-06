// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotifyModel _$$_NotifyModelFromJson(Map<String, dynamic> json) =>
    _$_NotifyModel(
      type: json['type'] as String,
      name: json['name'] as String,
      message: json['message'] as String,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$_NotifyModelToJson(_$_NotifyModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'message': instance.message,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
