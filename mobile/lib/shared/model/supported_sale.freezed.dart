// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'supported_sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SupportedSale _$SupportedSaleFromJson(Map<String, dynamic> json) {
  return _SupportedSale.fromJson(json);
}

/// @nodoc
class _$SupportedSaleTearOff {
  const _$SupportedSaleTearOff();

  _SupportedSale call(
      {required String id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles}) {
    return _SupportedSale(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      username: username,
      avatar: avatar,
      blocked: blocked,
      roles: roles,
    );
  }

  SupportedSale fromJson(Map<String, Object?> json) {
    return SupportedSale.fromJson(json);
  }
}

/// @nodoc
const $SupportedSale = _$SupportedSaleTearOff();

/// @nodoc
mixin _$SupportedSale {
  String get id => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  bool? get blocked => throw _privateConstructorUsedError;
  List<String>? get roles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupportedSaleCopyWith<SupportedSale> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportedSaleCopyWith<$Res> {
  factory $SupportedSaleCopyWith(
          SupportedSale value, $Res Function(SupportedSale) then) =
      _$SupportedSaleCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles});
}

/// @nodoc
class _$SupportedSaleCopyWithImpl<$Res>
    implements $SupportedSaleCopyWith<$Res> {
  _$SupportedSaleCopyWithImpl(this._value, this._then);

  final SupportedSale _value;
  // ignore: unused_field
  final $Res Function(SupportedSale) _then;

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
              as String,
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
abstract class _$SupportedSaleCopyWith<$Res>
    implements $SupportedSaleCopyWith<$Res> {
  factory _$SupportedSaleCopyWith(
          _SupportedSale value, $Res Function(_SupportedSale) then) =
      __$SupportedSaleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles});
}

/// @nodoc
class __$SupportedSaleCopyWithImpl<$Res>
    extends _$SupportedSaleCopyWithImpl<$Res>
    implements _$SupportedSaleCopyWith<$Res> {
  __$SupportedSaleCopyWithImpl(
      _SupportedSale _value, $Res Function(_SupportedSale) _then)
      : super(_value, (v) => _then(v as _SupportedSale));

  @override
  _SupportedSale get _value => super._value as _SupportedSale;

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
    return _then(_SupportedSale(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_SupportedSale extends _SupportedSale {
  const _$_SupportedSale(
      {required this.id,
      this.fullName,
      this.phoneNumber,
      this.username,
      this.avatar,
      this.blocked,
      this.roles})
      : super._();

  factory _$_SupportedSale.fromJson(Map<String, dynamic> json) =>
      _$$_SupportedSaleFromJson(json);

  @override
  final String id;
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
    return 'SupportedSale(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, username: $username, avatar: $avatar, blocked: $blocked, roles: $roles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SupportedSale &&
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
  _$SupportedSaleCopyWith<_SupportedSale> get copyWith =>
      __$SupportedSaleCopyWithImpl<_SupportedSale>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupportedSaleToJson(this);
  }
}

abstract class _SupportedSale extends SupportedSale {
  const factory _SupportedSale(
      {required String id,
      String? fullName,
      String? phoneNumber,
      String? username,
      String? avatar,
      bool? blocked,
      List<String>? roles}) = _$_SupportedSale;
  const _SupportedSale._() : super._();

  factory _SupportedSale.fromJson(Map<String, dynamic> json) =
      _$_SupportedSale.fromJson;

  @override
  String get id;
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
  _$SupportedSaleCopyWith<_SupportedSale> get copyWith =>
      throw _privateConstructorUsedError;
}
