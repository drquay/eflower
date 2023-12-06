// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notify_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NotifyStateTearOff {
  const _$NotifyStateTearOff();

  _Empty empty() {
    return const _Empty();
  }

  _Has_Notifications hasNotifications(List<NotifyModel> notifications) {
    return _Has_Notifications(
      notifications,
    );
  }
}

/// @nodoc
const $NotifyState = _$NotifyStateTearOff();

/// @nodoc
mixin _$NotifyState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<NotifyModel> notifications) hasNotifications,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<NotifyModel> notifications)? hasNotifications,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<NotifyModel> notifications)? hasNotifications,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Has_Notifications value) hasNotifications,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Has_Notifications value)? hasNotifications,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Has_Notifications value)? hasNotifications,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotifyStateCopyWith<$Res> {
  factory $NotifyStateCopyWith(
          NotifyState value, $Res Function(NotifyState) then) =
      _$NotifyStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotifyStateCopyWithImpl<$Res> implements $NotifyStateCopyWith<$Res> {
  _$NotifyStateCopyWithImpl(this._value, this._then);

  final NotifyState _value;
  // ignore: unused_field
  final $Res Function(NotifyState) _then;
}

/// @nodoc
abstract class _$EmptyCopyWith<$Res> {
  factory _$EmptyCopyWith(_Empty value, $Res Function(_Empty) then) =
      __$EmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$EmptyCopyWithImpl<$Res> extends _$NotifyStateCopyWithImpl<$Res>
    implements _$EmptyCopyWith<$Res> {
  __$EmptyCopyWithImpl(_Empty _value, $Res Function(_Empty) _then)
      : super(_value, (v) => _then(v as _Empty));

  @override
  _Empty get _value => super._value as _Empty;
}

/// @nodoc

class _$_Empty implements _Empty {
  const _$_Empty();

  @override
  String toString() {
    return 'NotifyState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Empty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<NotifyModel> notifications) hasNotifications,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<NotifyModel> notifications)? hasNotifications,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<NotifyModel> notifications)? hasNotifications,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Has_Notifications value) hasNotifications,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Has_Notifications value)? hasNotifications,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Has_Notifications value)? hasNotifications,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements NotifyState {
  const factory _Empty() = _$_Empty;
}

/// @nodoc
abstract class _$Has_NotificationsCopyWith<$Res> {
  factory _$Has_NotificationsCopyWith(
          _Has_Notifications value, $Res Function(_Has_Notifications) then) =
      __$Has_NotificationsCopyWithImpl<$Res>;
  $Res call({List<NotifyModel> notifications});
}

/// @nodoc
class __$Has_NotificationsCopyWithImpl<$Res>
    extends _$NotifyStateCopyWithImpl<$Res>
    implements _$Has_NotificationsCopyWith<$Res> {
  __$Has_NotificationsCopyWithImpl(
      _Has_Notifications _value, $Res Function(_Has_Notifications) _then)
      : super(_value, (v) => _then(v as _Has_Notifications));

  @override
  _Has_Notifications get _value => super._value as _Has_Notifications;

  @override
  $Res call({
    Object? notifications = freezed,
  }) {
    return _then(_Has_Notifications(
      notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotifyModel>,
    ));
  }
}

/// @nodoc

class _$_Has_Notifications implements _Has_Notifications {
  const _$_Has_Notifications(this.notifications);

  @override
  final List<NotifyModel> notifications;

  @override
  String toString() {
    return 'NotifyState.hasNotifications(notifications: $notifications)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Has_Notifications &&
            const DeepCollectionEquality()
                .equals(other.notifications, notifications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(notifications));

  @JsonKey(ignore: true)
  @override
  _$Has_NotificationsCopyWith<_Has_Notifications> get copyWith =>
      __$Has_NotificationsCopyWithImpl<_Has_Notifications>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<NotifyModel> notifications) hasNotifications,
  }) {
    return hasNotifications(notifications);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<NotifyModel> notifications)? hasNotifications,
  }) {
    return hasNotifications?.call(notifications);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<NotifyModel> notifications)? hasNotifications,
    required TResult orElse(),
  }) {
    if (hasNotifications != null) {
      return hasNotifications(notifications);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Has_Notifications value) hasNotifications,
  }) {
    return hasNotifications(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Has_Notifications value)? hasNotifications,
  }) {
    return hasNotifications?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Has_Notifications value)? hasNotifications,
    required TResult orElse(),
  }) {
    if (hasNotifications != null) {
      return hasNotifications(this);
    }
    return orElse();
  }
}

abstract class _Has_Notifications implements NotifyState {
  const factory _Has_Notifications(List<NotifyModel> notifications) =
      _$_Has_Notifications;

  List<NotifyModel> get notifications;
  @JsonKey(ignore: true)
  _$Has_NotificationsCopyWith<_Has_Notifications> get copyWith =>
      throw _privateConstructorUsedError;
}
