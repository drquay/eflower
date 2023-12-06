import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

UserResponse userResponseFromJson(Map<String, dynamic> json) =>
    UserResponse.fromJson(json);

@freezed
class UserResponse with _$UserResponse {

  const factory UserResponse(
      {required int totalItems,
      required int totalPages,
      required List<User> items,
      required int currentPage}) = _UserResponse;
  const UserResponse._();

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
