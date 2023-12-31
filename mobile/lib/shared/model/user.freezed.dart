// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles}) {
    return _User(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      username: username,
      avatar: avatar,
      blocked: blocked,
      roles: roles,
    );
  }

  User fromJson(Map<String, Object?> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String? get id => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  bool? get blocked => throw _privateConstructorUsedError;
  List<String>? get roles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
    Object? blocked = freezed,
    Object? roles = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      blocked: blocked == freezed
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
    Object? blocked = freezed,
    Object? roles = freezed,
  }) {
    return _then(_User(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      blocked: blocked == freezed
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User extends _User {
  const _$_User(
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.username,
      this.avatar,
      this.blocked,
      this.roles})
      : super._();

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String? id;
  @override
  final String? fullName;
  @override
  final String? phoneNumber;
  @override
  final String? username;
  @override
  final String? avatar;
  @override
  final bool? blocked;
  @override
  final List<String>? roles;

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, username: $username, avatar: $avatar, blocked: $blocked, roles: $roles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality().equals(other.blocked, blocked) &&
            const DeepCollectionEquality().equals(other.roles, roles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(avatar),
      const DeepCollectionEquality().hash(blocked),
      const DeepCollectionEquality().hash(roles));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(this);
  }
}

abstract class _User extends User {
  const factory _User(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles}) = _$_User;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String? get id;
  @override
  String? get fullName;
  @override
  String? get phoneNumber;
  @override
  String? get username;
  @override
  String? get avatar;
  @override
  bool? get blocked;
  @override
  List<String>? get roles;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
