import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';

part 'comment_attachment_model.freezed.dart';
part 'comment_attachment_model.g.dart';

List<CommentAttachment> commentAttachmentsFromJson(List<dynamic> data) =>
    List<CommentAttachment>.from(data.map((x) => CommentAttachment.fromJson(x)));

commentAttachmentFromJson(Map<String, dynamic> json) => CommentAttachment.fromJson(json);

@freezed
class CommentAttachment with _$CommentAttachment {
  const CommentAttachment._();

  const factory CommentAttachment({
    required String id,
    String? img,
    String? name,
    required String url,
    User? uploadedBy
  }) = _CommentAttachment;

  factory CommentAttachment.fromJson(Map<String, dynamic> json) => _$CommentAttachmentFromJson(json);
}
