// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'buyer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Buyer _$BuyerFromJson(Map<String, dynamic> json) {
  return _Buyer.fromJson(json);
}

/// @nodoc
class _$BuyerTearOff {
  const _$BuyerTearOff();

  _Buyer call(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? address,
      String? createdOn}) {
    return _Buyer(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      createdOn: createdOn,
    );
  }

  Buyer fromJson(Map<String, Object?> json) {
    return Buyer.fromJson(json);
  }
}

/// @nodoc
const $Buyer = _$BuyerTearOff();

/// @nodoc
mixin _$Buyer {
  String? get id => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get createdOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuyerCopyWith<Buyer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyerCopyWith<$Res> {
  factory $BuyerCopyWith(Buyer value, $Res Function(Buyer) then) =
      _$BuyerCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? address,
      String? createdOn});
}

/// @nodoc
class _$BuyerCopyWithImpl<$Res> implements $BuyerCopyWith<$Res> {
  _$BuyerCopyWithImpl(this._value, this._then);

  final Buyer _value;
  // ignore: unused_field
  final $Res Function(Buyer) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? address = freezed,
    Object? createdOn = freezed,
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
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$BuyerCopyWith<$Res> implements $BuyerCopyWith<$Res> {
  factory _$BuyerCopyWith(_Buyer value, $Res Function(_Buyer) then) =
      __$BuyerCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? address,
      String? createdOn});
}

/// @nodoc
class __$BuyerCopyWithImpl<$Res> extends _$BuyerCopyWithImpl<$Res>
    implements _$BuyerCopyWith<$Res> {
  __$BuyerCopyWithImpl(_Buyer _value, $Res Function(_Buyer) _then)
      : super(_value, (v) => _then(v as _Buyer));

  @override
  _Buyer get _value => super._value as _Buyer;

  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? address = freezed,
    Object? createdOn = freezed,
  }) {
    return _then(_Buyer(
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
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Buyer extends _Buyer {
  const _$_Buyer(
      {this.id, this.fullName, this.phoneNumber, this.address, this.createdOn})
      : super._();

  factory _$_Buyer.fromJson(Map<String, dynamic> json) =>
      _$$_BuyerFromJson(json);

  @override
  final String? id;
  @override
  final String? fullName;
  @override
  final String? phoneNumber;
  @override
  final String? address;
  @override
  final String? createdOn;

  @override
  String toString() {
    return 'Buyer(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, address: $address, createdOn: $createdOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Buyer &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(createdOn));

  @JsonKey(ignore: true)
  @override
  _$BuyerCopyWith<_Buyer> get copyWith =>
      __$BuyerCopyWithImpl<_Buyer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuyerToJson(this);
  }
}

abstract class _Buyer extends Buyer {
  const factory _Buyer(
      {String? id,
      String? fullName,
      String? phoneNumber,
      String? address,
      String? createdOn}) = _$_Buyer;
  const _Buyer._() : super._();

  factory _Buyer.fromJson(Map<String, dynamic> json) = _$_Buyer.fromJson;

  @override
  String? get id;
  @override
  String? get fullName;
  @override
  String? get phoneNumber;
  @override
  String? get address;
  @override
  String? get createdOn;
  @override
  @JsonKey(ignore: true)
  _$BuyerCopyWith<_Buyer> get copyWith => throw _privateConstructorUsedError;
}
