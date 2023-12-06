import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

List<Attachment> attachmentsFromJson(List<dynamic> data) =>
    List<Attachment>.from(data.map((x) => Attachment.fromJson(x)));

Attachment attachmentFromJson(Map<String, dynamic> json) =>
    Attachment.fromJson(json);

@freezed
class Attachment with _$Attachment {
  const Attachment._();

  const factory Attachment({
    String? id,
    String? img,
    String? name,
    required String url,
    String? thumbnail,
    User? uploadedBy,
    required String createdOn
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
