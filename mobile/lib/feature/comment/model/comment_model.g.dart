// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentModel _$$_CommentModelFromJson(Map<String, dynamic> json) =>
    _$_CommentModel(
      id: json['id'] as String,
      createdBy: User.fromJson(json['createdBy'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdOn: json['createdOn'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => CommentAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CommentModelToJson(_$_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'content': instance.content,
      'createdOn': instance.createdOn,
      'attachments': instance.attachments,
    };
