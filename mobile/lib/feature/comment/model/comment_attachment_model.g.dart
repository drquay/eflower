// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentAttachment _$$_CommentAttachmentFromJson(Map<String, dynamic> json) =>
    _$_CommentAttachment(
      id: json['id'] as String,
      img: json['img'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String,
      uploadedBy: json['uploadedBy'] == null
          ? null
          : User.fromJson(json['uploadedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CommentAttachmentToJson(
        _$_CommentAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'name': instance.name,
      'url': instance.url,
      'uploadedBy': instance.uploadedBy,
    };
