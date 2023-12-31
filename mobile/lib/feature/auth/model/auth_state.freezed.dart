// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  Initial initial() {
    return const Initial();
  }

  Loading loading() {
    return const Loading();
  }

  FloristLoggedIn floristLoggedIn() {
    return const FloristLoggedIn();
  }

  ShipperLoggedIn shipperLoggedIn() {
    return const ShipperLoggedIn();
  }

  AdminLoggedIn adminLoggedIn() {
    return const AdminLoggedIn();
  }

  Error error(AppException error) {
    return Error(
      error,
    );
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements AuthState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc

class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements AuthState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $FloristLoggedInCopyWith<$Res> {
  factory $FloristLoggedInCopyWith(
          FloristLoggedIn value, $Res Function(FloristLoggedIn) then) =
      _$FloristLoggedInCopyWithImpl<$Res>;
}

/// @nodoc
class _$FloristLoggedInCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $FloristLoggedInCopyWith<$Res> {
  _$FloristLoggedInCopyWithImpl(
      FloristLoggedIn _value, $Res Function(FloristLoggedIn) _then)
      : super(_value, (v) => _then(v as FloristLoggedIn));

  @override
  FloristLoggedIn get _value => super._value as FloristLoggedIn;
}

/// @nodoc

class _$FloristLoggedIn implements FloristLoggedIn {
  const _$FloristLoggedIn();

  @override
  String toString() {
    return 'AuthState.floristLoggedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FloristLoggedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) {
    return floristLoggedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) {
    return floristLoggedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (floristLoggedIn != null) {
      return floristLoggedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) {
    return floristLoggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) {
    return floristLoggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (floristLoggedIn != null) {
      return floristLoggedIn(this);
    }
    return orElse();
  }
}

abstract class FloristLoggedIn implements AuthState {
  const factory FloristLoggedIn() = _$FloristLoggedIn;
}

/// @nodoc
abstract class $ShipperLoggedInCopyWith<$Res> {
  factory $ShipperLoggedInCopyWith(
          ShipperLoggedIn value, $Res Function(ShipperLoggedIn) then) =
      _$ShipperLoggedInCopyWithImpl<$Res>;
}

/// @nodoc
class _$ShipperLoggedInCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $ShipperLoggedInCopyWith<$Res> {
  _$ShipperLoggedInCopyWithImpl(
      ShipperLoggedIn _value, $Res Function(ShipperLoggedIn) _then)
      : super(_value, (v) => _then(v as ShipperLoggedIn));

  @override
  ShipperLoggedIn get _value => super._value as ShipperLoggedIn;
}

/// @nodoc

class _$ShipperLoggedIn implements ShipperLoggedIn {
  const _$ShipperLoggedIn();

  @override
  String toString() {
    return 'AuthState.shipperLoggedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ShipperLoggedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) {
    return shipperLoggedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) {
    return shipperLoggedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (shipperLoggedIn != null) {
      return shipperLoggedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) {
    return shipperLoggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) {
    return shipperLoggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (shipperLoggedIn != null) {
      return shipperLoggedIn(this);
    }
    return orElse();
  }
}

abstract class ShipperLoggedIn implements AuthState {
  const factory ShipperLoggedIn() = _$ShipperLoggedIn;
}

/// @nodoc
abstract class $AdminLoggedInCopyWith<$Res> {
  factory $AdminLoggedInCopyWith(
          AdminLoggedIn value, $Res Function(AdminLoggedIn) then) =
      _$AdminLoggedInCopyWithImpl<$Res>;
}

/// @nodoc
class _$AdminLoggedInCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AdminLoggedInCopyWith<$Res> {
  _$AdminLoggedInCopyWithImpl(
      AdminLoggedIn _value, $Res Function(AdminLoggedIn) _then)
      : super(_value, (v) => _then(v as AdminLoggedIn));

  @override
  AdminLoggedIn get _value => super._value as AdminLoggedIn;
}

/// @nodoc

class _$AdminLoggedIn implements AdminLoggedIn {
  const _$AdminLoggedIn();

  @override
  String toString() {
    return 'AuthState.adminLoggedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AdminLoggedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) {
    return adminLoggedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) {
    return adminLoggedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (adminLoggedIn != null) {
      return adminLoggedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) {
    return adminLoggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) {
    return adminLoggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (adminLoggedIn != null) {
      return adminLoggedIn(this);
    }
    return orElse();
  }
}

abstract class AdminLoggedIn implements AuthState {
  const factory AdminLoggedIn() = _$AdminLoggedIn;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({AppException error});

  $AppExceptionCopyWith<$Res> get error;
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }

  @override
  $AppExceptionCopyWith<$Res> get error {
    return $AppExceptionCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$Error implements Error {
  const _$Error(this.error);

  @override
  final AppException error;

  @override
  String toString() {
    return 'AuthState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Error &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() floristLoggedIn,
    required TResult Function() shipperLoggedIn,
    required TResult Function() adminLoggedIn,
    required TResult Function(AppException error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? floristLoggedIn,
    TResult Function()? shipperLoggedIn,
    TResult Function()? adminLoggedIn,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(FloristLoggedIn value) floristLoggedIn,
    required TResult Function(ShipperLoggedIn value) shipperLoggedIn,
    required TResult Function(AdminLoggedIn value) adminLoggedIn,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(FloristLoggedIn value)? floristLoggedIn,
    TResult Function(ShipperLoggedIn value)? shipperLoggedIn,
    TResult Function(AdminLoggedIn value)? adminLoggedIn,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements AuthState {
  const factory Error(AppException error) = _$Error;

  AppException get error;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
