// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'gps_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GpsModelTearOff {
  const _$GpsModelTearOff();

  _GpsModel call(
      {required double latitude,
      required double longitude,
      double? numberOfKm}) {
    return _GpsModel(
      latitude: latitude,
      longitude: longitude,
      numberOfKm: numberOfKm,
    );
  }
}

/// @nodoc
const $GpsModel = _$GpsModelTearOff();

/// @nodoc
mixin _$GpsModel {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double? get numberOfKm => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GpsModelCopyWith<GpsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpsModelCopyWith<$Res> {
  factory $GpsModelCopyWith(GpsModel value, $Res Function(GpsModel) then) =
      _$GpsModelCopyWithImpl<$Res>;
  $Res call({double latitude, double longitude, double? numberOfKm});
}

/// @nodoc
class _$GpsModelCopyWithImpl<$Res> implements $GpsModelCopyWith<$Res> {
  _$GpsModelCopyWithImpl(this._value, this._then);

  final GpsModel _value;
  // ignore: unused_field
  final $Res Function(GpsModel) _then;

  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? numberOfKm = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfKm: numberOfKm == freezed
          ? _value.numberOfKm
          : numberOfKm // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$GpsModelCopyWith<$Res> implements $GpsModelCopyWith<$Res> {
  factory _$GpsModelCopyWith(_GpsModel value, $Res Function(_GpsModel) then) =
      __$GpsModelCopyWithImpl<$Res>;
  @override
  $Res call({double latitude, double longitude, double? numberOfKm});
}

/// @nodoc
class __$GpsModelCopyWithImpl<$Res> extends _$GpsModelCopyWithImpl<$Res>
    implements _$GpsModelCopyWith<$Res> {
  __$GpsModelCopyWithImpl(_GpsModel _value, $Res Function(_GpsModel) _then)
      : super(_value, (v) => _then(v as _GpsModel));

  @override
  _GpsModel get _value => super._value as _GpsModel;

  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? numberOfKm = freezed,
  }) {
    return _then(_GpsModel(
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfKm: numberOfKm == freezed
          ? _value.numberOfKm
          : numberOfKm // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_GpsModel extends _GpsModel {
  const _$_GpsModel(
      {required this.latitude, required this.longitude, this.numberOfKm})
      : super._();

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? numberOfKm;

  @override
  String toString() {
    return 'GpsModel(latitude: $latitude, longitude: $longitude, numberOfKm: $numberOfKm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GpsModel &&
            const DeepCollectionEquality().equals(other.latitude, latitude) &&
            const DeepCollectionEquality().equals(other.longitude, longitude) &&
            const DeepCollectionEquality()
                .equals(other.numberOfKm, numberOfKm));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(latitude),
      const DeepCollectionEquality().hash(longitude),
      const DeepCollectionEquality().hash(numberOfKm));

  @JsonKey(ignore: true)
  @override
  _$GpsModelCopyWith<_GpsModel> get copyWith =>
      __$GpsModelCopyWithImpl<_GpsModel>(this, _$identity);
}

abstract class _GpsModel extends GpsModel {
  const factory _GpsModel(
      {required double latitude,
      required double longitude,
      double? numberOfKm}) = _$_GpsModel;
  const _GpsModel._() : super._();

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double? get numberOfKm;
  @override
  @JsonKey(ignore: true)
  _$GpsModelCopyWith<_GpsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
