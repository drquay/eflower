import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_boilerplate/feature/comment/model/comment_attachment_model.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

List<CommentModel> commentsFromJson(List<dynamic> data) =>
    List<CommentModel>.from(data.map((x) => CommentModel.fromJson(x)));

commentFromJson(Map<String, dynamic> json) => CommentModel.fromJson(json);

@freezed
class CommentModel with _$CommentModel {
  const CommentModel._();

  const factory CommentModel({
    required String id,
    required User createdBy,
    required String content,
    required String createdOn,
    required List<CommentAttachment> attachments,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}
