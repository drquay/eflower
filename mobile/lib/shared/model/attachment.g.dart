// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attachment _$$_AttachmentFromJson(Map<String, dynamic> json) =>
    _$_Attachment(
      id: json['id'] as String?,
      img: json['img'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String?,
      uploadedBy: json['uploadedBy'] == null
          ? null
          : User.fromJson(json['uploadedBy'] as Map<String, dynamic>),
      createdOn: json['createdOn'] as String,
    );

Map<String, dynamic> _$$_AttachmentToJson(_$_Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'name': instance.name,
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'uploadedBy': instance.uploadedBy,
      'createdOn': instance.createdOn,
    };
