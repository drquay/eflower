import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

List<User> usersFromJson(List<dynamic> data) =>
    List<User>.from(data.map((x) => User.fromJson(x)));

User userFromJson(Map<String, dynamic> json) => User.fromJson(json);

@freezed
class User with _$User {
  const User._();

  const factory User({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? username,
    String? avatar,
    bool? blocked,
    List<String>? roles,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
