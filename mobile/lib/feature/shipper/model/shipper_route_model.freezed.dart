// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shipper_route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShipperRouteModel _$ShipperRouteModelFromJson(Map<String, dynamic> json) {
  return _ShipperRouteModel.fromJson(json);
}

/// @nodoc
class _$ShipperRouteModelTearOff {
  const _$ShipperRouteModelTearOff();

  _ShipperRouteModel call(
      {String? beginLatitude,
      String? beginLongitude,
      String? endLatitude,
      String? endLongitude,
      String? type}) {
    return _ShipperRouteModel(
      beginLatitude: beginLatitude,
      beginLongitude: beginLongitude,
      endLatitude: endLatitude,
      endLongitude: endLongitude,
      type: type,
    );
  }

  ShipperRouteModel fromJson(Map<String, Object?> json) {
    return ShipperRouteModel.fromJson(json);
  }
}

/// @nodoc
const $ShipperRouteModel = _$ShipperRouteModelTearOff();

/// @nodoc
mixin _$ShipperRouteModel {
  String? get beginLatitude => throw _privateConstructorUsedError;
  String? get beginLongitude => throw _privateConstructorUsedError;
  String? get endLatitude => throw _privateConstructorUsedError;
  String? get endLongitude => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShipperRouteModelCopyWith<ShipperRouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShipperRouteModelCopyWith<$Res> {
  factory $ShipperRouteModelCopyWith(
          ShipperRouteModel value, $Res Function(ShipperRouteModel) then) =
      _$ShipperRouteModelCopyWithImpl<$Res>;
  $Res call(
      {String? beginLatitude,
      String? beginLongitude,
      String? endLatitude,
      String? endLongitude,
      String? type});
}

/// @nodoc
class _$ShipperRouteModelCopyWithImpl<$Res>
    implements $ShipperRouteModelCopyWith<$Res> {
  _$ShipperRouteModelCopyWithImpl(this._value, this._then);

  final ShipperRouteModel _value;
  // ignore: unused_field
  final $Res Function(ShipperRouteModel) _then;

  @override
  $Res call({
    Object? beginLatitude = freezed,
    Object? beginLongitude = freezed,
    Object? endLatitude = freezed,
    Object? endLongitude = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      beginLatitude: beginLatitude == freezed
          ? _value.beginLatitude
          : beginLatitude // ignore: cast_nullable_to_non_nullable
              as String?,
      beginLongitude: beginLongitude == freezed
          ? _value.beginLongitude
          : beginLongitude // ignore: cast_nullable_to_non_nullable
              as String?,
      endLatitude: endLatitude == freezed
          ? _value.endLatitude
          : endLatitude // ignore: cast_nullable_to_non_nullable
              as String?,
      endLongitude: endLongitude == freezed
          ? _value.endLongitude
          : endLongitude // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ShipperRouteModelCopyWith<$Res>
    implements $ShipperRouteModelCopyWith<$Res> {
  factory _$ShipperRouteModelCopyWith(
          _ShipperRouteModel value, $Res Function(_ShipperRouteModel) then) =
      __$ShipperRouteModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? beginLatitude,
      String? beginLongitude,
      String? endLatitude,
      String? endLongitude,
      String? type});
}

/// @nodoc
class __$ShipperRouteModelCopyWithImpl<$Res>
    extends _$ShipperRouteModelCopyWithImpl<$Res>
    implements _$ShipperRouteModelCopyWith<$Res> {
  __$ShipperRouteModelCopyWithImpl(
      _ShipperRouteModel _value, $Res Function(_ShipperRouteModel) _then)
      : super(_value, (v) => _then(v as _ShipperRouteModel));

  @override
  _ShipperRouteModel get _value => super._value as _ShipperRouteModel;

  @override
  $Res call({
    Object? beginLatitude = freezed,
    Object? beginLongitude = freezed,
    Object? endLatitude = freezed,
    Object? endLongitude = freezed,
    Object? type = freezed,
  }) {
    return _then(_ShipperRouteModel(
      beginLatitude: beginLatitude == freezed
          ? _value.beginLatitude
          : beginLatitude // ignore: cast_nullable_to_non_nullable
              as String?,
      beginLongitude: beginLongitude == freezed
          ? _value.beginLongitude
          : beginLongitude // ignore: cast_nullable_to_non_nullable
              as String?,
      endLatitude: endLatitude == freezed
          ? _value.endLatitude
          : endLatitude // ignore: cast_nullable_to_non_nullable
              as String?,
      endLongitude: endLongitude == freezed
          ? _value.endLongitude
          : endLongitude // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShipperRouteModel extends _ShipperRouteModel {
  const _$_ShipperRouteModel(
      {this.beginLatitude,
      this.beginLongitude,
      this.endLatitude,
      this.endLongitude,
      this.type})
      : super._();

  factory _$_ShipperRouteModel.fromJson(Map<String, dynamic> json) =>
      _$$_ShipperRouteModelFromJson(json);

  @override
  final String? beginLatitude;
  @override
  final String? beginLongitude;
  @override
  final String? endLatitude;
  @override
  final String? endLongitude;
  @override
  final String? type;

  @override
  String toString() {
    return 'ShipperRouteModel(beginLatitude: $beginLatitude, beginLongitude: $beginLongitude, endLatitude: $endLatitude, endLongitude: $endLongitude, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShipperRouteModel &&
            const DeepCollectionEquality()
                .equals(other.beginLatitude, beginLatitude) &&
            const DeepCollectionEquality()
                .equals(other.beginLongitude, beginLongitude) &&
            const DeepCollectionEquality()
                .equals(other.endLatitude, endLatitude) &&
            const DeepCollectionEquality()
                .equals(other.endLongitude, endLongitude) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(beginLatitude),
      const DeepCollectionEquality().hash(beginLongitude),
      const DeepCollectionEquality().hash(endLatitude),
      const DeepCollectionEquality().hash(endLongitude),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$ShipperRouteModelCopyWith<_ShipperRouteModel> get copyWith =>
      __$ShipperRouteModelCopyWithImpl<_ShipperRouteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShipperRouteModelToJson(this);
  }
}

abstract class _ShipperRouteModel extends ShipperRouteModel {
  const factory _ShipperRouteModel(
      {String? beginLatitude,
      String? beginLongitude,
      String? endLatitude,
      String? endLongitude,
      String? type}) = _$_ShipperRouteModel;
  const _ShipperRouteModel._() : super._();

  factory _ShipperRouteModel.fromJson(Map<String, dynamic> json) =
      _$_ShipperRouteModel.fromJson;

  @override
  String? get beginLatitude;
  @override
  String? get beginLongitude;
  @override
  String? get endLatitude;
  @override
  String? get endLongitude;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$ShipperRouteModelCopyWith<_ShipperRouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}
