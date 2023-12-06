import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_boilerplate/feature/comment/model/comment_model.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';

part 'comment_state.freezed.dart';

@freezed
class CommentsState with _$CommentsState {
  const factory CommentsState.loading() = _Loading;
  const factory CommentsState.ordersLoaded(List<CommentModel> orders) = _Loaded;
  const factory CommentsState.error(AppException error) = _Error;
}
