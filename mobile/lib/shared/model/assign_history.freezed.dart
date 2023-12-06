// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'assign_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AssignHistory _$AssignHistoryFromJson(Map<String, dynamic> json) {
  return _AssignHistory.fromJson(json);
}

/// @nodoc
class _$AssignHistoryTearOff {
  const _$AssignHistoryTearOff();

  _AssignHistory call(
      {required String createdOn, required User personInCharse}) {
    return _AssignHistory(
      createdOn: createdOn,
      personInCharse: personInCharse,
    );
  }

  AssignHistory fromJson(Map<String, Object?> json) {
    return AssignHistory.fromJson(json);
  }
}

/// @nodoc
const $AssignHistory = _$AssignHistoryTearOff();

/// @nodoc
mixin _$AssignHistory {
  String get createdOn => throw _privateConstructorUsedError;
  User get personInCharse => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignHistoryCopyWith<AssignHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignHistoryCopyWith<$Res> {
  factory $AssignHistoryCopyWith(
          AssignHistory value, $Res Function(AssignHistory) then) =
      _$AssignHistoryCopyWithImpl<$Res>;
  $Res call({String createdOn, User personInCharse});

  $UserCopyWith<$Res> get personInCharse;
}

/// @nodoc
class _$AssignHistoryCopyWithImpl<$Res>
    implements $AssignHistoryCopyWith<$Res> {
  _$AssignHistoryCopyWithImpl(this._value, this._then);

  final AssignHistory _value;
  // ignore: unused_field
  final $Res Function(AssignHistory) _then;

  @override
  $Res call({
    Object? createdOn = freezed,
    Object? personInCharse = freezed,
  }) {
    return _then(_value.copyWith(
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String,
      personInCharse: personInCharse == freezed
          ? _value.personInCharse
          : personInCharse // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  $UserCopyWith<$Res> get personInCharse {
    return $UserCopyWith<$Res>(_value.personInCharse, (value) {
      return _then(_value.copyWith(personInCharse: value));
    });
  }
}

/// @nodoc
abstract class _$AssignHistoryCopyWith<$Res>
    implements $AssignHistoryCopyWith<$Res> {
  factory _$AssignHistoryCopyWith(
          _AssignHistory value, $Res Function(_AssignHistory) then) =
      __$AssignHistoryCopyWithImpl<$Res>;
  @override
  $Res call({String createdOn, User personInCharse});

  @override
  $UserCopyWith<$Res> get personInCharse;
}

/// @nodoc
class __$AssignHistoryCopyWithImpl<$Res>
    extends _$AssignHistoryCopyWithImpl<$Res>
    implements _$AssignHistoryCopyWith<$Res> {
  __$AssignHistoryCopyWithImpl(
      _AssignHistory _value, $Res Function(_AssignHistory) _then)
      : super(_value, (v) => _then(v as _AssignHistory));

  @override
  _AssignHistory get _value => super._value as _AssignHistory;

  @override
  $Res call({
    Object? createdOn = freezed,
    Object? personInCharse = freezed,
  }) {
    return _then(_AssignHistory(
      createdOn: createdOn == freezed
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String,
      personInCharse: personInCharse == freezed
          ? _value.personInCharse
          : personInCharse // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AssignHistory extends _AssignHistory {
  const _$_AssignHistory(
      {required this.createdOn, required this.personInCharse})
      : super._();

  factory _$_AssignHistory.fromJson(Map<String, dynamic> json) =>
      _$$_AssignHistoryFromJson(json);

  @override
  final String createdOn;
  @override
  final User personInCharse;

  @override
  String toString() {
    return 'AssignHistory(createdOn: $createdOn, personInCharse: $personInCharse)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssignHistory &&
            const DeepCollectionEquality().equals(other.createdOn, createdOn) &&
            const DeepCollectionEquality()
                .equals(other.personInCharse, personInCharse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdOn),
      const DeepCollectionEquality().hash(personInCharse));

  @JsonKey(ignore: true)
  @override
  _$AssignHistoryCopyWith<_AssignHistory> get copyWith =>
      __$AssignHistoryCopyWithImpl<_AssignHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssignHistoryToJson(this);
  }
}

abstract class _AssignHistory extends AssignHistory {
  const factory _AssignHistory(
      {required String createdOn,
      required User personInCharse}) = _$_AssignHistory;
  const _AssignHistory._() : super._();

  factory _AssignHistory.fromJson(Map<String, dynamic> json) =
      _$_AssignHistory.fromJson;

  @override
  String get createdOn;
  @override
  User get personInCharse;
  @override
  @JsonKey(ignore: true)
  _$AssignHistoryCopyWith<_AssignHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
