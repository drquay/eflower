// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notify_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotifyModel _$NotifyModelFromJson(Map<String, dynamic> json) {
  return _NotifyModel.fromJson(json);
}

/// @nodoc
class _$NotifyModelTearOff {
  const _$NotifyModelTearOff();

  _NotifyModel call(
      {required String type,
      required String name,
      required String message,
      DateTime? dateTime}) {
    return _NotifyModel(
      type: type,
      name: name,
      message: message,
      dateTime: dateTime,
    );
  }

  NotifyModel fromJson(Map<String, Object?> json) {
    return NotifyModel.fromJson(json);
  }
}

/// @nodoc
const $NotifyModel = _$NotifyModelTearOff();

/// @nodoc
mixin _$NotifyModel {
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime? get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotifyModelCopyWith<NotifyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotifyModelCopyWith<$Res> {
  factory $NotifyModelCopyWith(
          NotifyModel value, $Res Function(NotifyModel) then) =
      _$NotifyModelCopyWithImpl<$Res>;
  $Res call({String type, String name, String message, DateTime? dateTime});
}

/// @nodoc
class _$NotifyModelCopyWithImpl<$Res> implements $NotifyModelCopyWith<$Res> {
  _$NotifyModelCopyWithImpl(this._value, this._then);

  final NotifyModel _value;
  // ignore: unused_field
  final $Res Function(NotifyModel) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$NotifyModelCopyWith<$Res>
    implements $NotifyModelCopyWith<$Res> {
  factory _$NotifyModelCopyWith(
          _NotifyModel value, $Res Function(_NotifyModel) then) =
      __$NotifyModelCopyWithImpl<$Res>;
  @override
  $Res call({String type, String name, String message, DateTime? dateTime});
}

/// @nodoc
class __$NotifyModelCopyWithImpl<$Res> extends _$NotifyModelCopyWithImpl<$Res>
    implements _$NotifyModelCopyWith<$Res> {
  __$NotifyModelCopyWithImpl(
      _NotifyModel _value, $Res Function(_NotifyModel) _then)
      : super(_value, (v) => _then(v as _NotifyModel));

  @override
  _NotifyModel get _value => super._value as _NotifyModel;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_NotifyModel(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotifyModel implements _NotifyModel {
  const _$_NotifyModel(
      {required this.type,
      required this.name,
      required this.message,
      this.dateTime});

  factory _$_NotifyModel.fromJson(Map<String, dynamic> json) =>
      _$$_NotifyModelFromJson(json);

  @override
  final String type;
  @override
  final String name;
  @override
  final String message;
  @override
  final DateTime? dateTime;

  @override
  String toString() {
    return 'NotifyModel(type: $type, name: $name, message: $message, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotifyModel &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.dateTime, dateTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(dateTime));

  @JsonKey(ignore: true)
  @override
  _$NotifyModelCopyWith<_NotifyModel> get copyWith =>
      __$NotifyModelCopyWithImpl<_NotifyModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotifyModelToJson(this);
  }
}

abstract class _NotifyModel implements NotifyModel {
  const factory _NotifyModel(
      {required String type,
      required String name,
      required String message,
      DateTime? dateTime}) = _$_NotifyModel;

  factory _NotifyModel.fromJson(Map<String, dynamic> json) =
      _$_NotifyModel.fromJson;

  @override
  String get type;
  @override
  String get name;
  @override
  String get message;
  @override
  DateTime? get dateTime;
  @override
  @JsonKey(ignore: true)
  _$NotifyModelCopyWith<_NotifyModel> get copyWith =>
      throw _privateConstructorUsedError;
}
