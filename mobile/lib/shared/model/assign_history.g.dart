// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssignHistory _$$_AssignHistoryFromJson(Map<String, dynamic> json) =>
    _$_AssignHistory(
      createdOn: json['createdOn'] as String,
      personInCharse:
          User.fromJson(json['personInCharse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AssignHistoryToJson(_$_AssignHistory instance) =>
    <String, dynamic>{
      'createdOn': instance.createdOn,
      'personInCharse': instance.personInCharse,
    };
