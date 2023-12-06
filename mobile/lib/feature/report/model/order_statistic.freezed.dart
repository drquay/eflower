// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_statistic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderStatistic _$OrderStatisticFromJson(Map<String, dynamic> json) {
  return _OrderStatistic.fromJson(json);
}

/// @nodoc
class _$OrderStatisticTearOff {
  const _$OrderStatisticTearOff();

  _OrderStatistic call({required String status, required int numberOfOrder}) {
    return _OrderStatistic(
      status: status,
      numberOfOrder: numberOfOrder,
    );
  }

  OrderStatistic fromJson(Map<String, Object?> json) {
    return OrderStatistic.fromJson(json);
  }
}

/// @nodoc
const $OrderStatistic = _$OrderStatisticTearOff();

/// @nodoc
mixin _$OrderStatistic {
  String get status => throw _privateConstructorUsedError;
  int get numberOfOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatisticCopyWith<OrderStatistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatisticCopyWith<$Res> {
  factory $OrderStatisticCopyWith(
          OrderStatistic value, $Res Function(OrderStatistic) then) =
      _$OrderStatisticCopyWithImpl<$Res>;
  $Res call({String status, int numberOfOrder});
}

/// @nodoc
class _$OrderStatisticCopyWithImpl<$Res>
    implements $OrderStatisticCopyWith<$Res> {
  _$OrderStatisticCopyWithImpl(this._value, this._then);

  final OrderStatistic _value;
  // ignore: unused_field
  final $Res Function(OrderStatistic) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? numberOfOrder = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfOrder: numberOfOrder == freezed
          ? _value.numberOfOrder
          : numberOfOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$OrderStatisticCopyWith<$Res>
    implements $OrderStatisticCopyWith<$Res> {
  factory _$OrderStatisticCopyWith(
          _OrderStatistic value, $Res Function(_OrderStatistic) then) =
      __$OrderStatisticCopyWithImpl<$Res>;
  @override
  $Res call({String status, int numberOfOrder});
}

/// @nodoc
class __$OrderStatisticCopyWithImpl<$Res>
    extends _$OrderStatisticCopyWithImpl<$Res>
    implements _$OrderStatisticCopyWith<$Res> {
  __$OrderStatisticCopyWithImpl(
      _OrderStatistic _value, $Res Function(_OrderStatistic) _then)
      : super(_value, (v) => _then(v as _OrderStatistic));

  @override
  _OrderStatistic get _value => super._value as _OrderStatistic;

  @override
  $Res call({
    Object? status = freezed,
    Object? numberOfOrder = freezed,
  }) {
    return _then(_OrderStatistic(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfOrder: numberOfOrder == freezed
          ? _value.numberOfOrder
          : numberOfOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderStatistic implements _OrderStatistic {
  const _$_OrderStatistic({required this.status, required this.numberOfOrder});

  factory _$_OrderStatistic.fromJson(Map<String, dynamic> json) =>
      _$$_OrderStatisticFromJson(json);

  @override
  final String status;
  @override
  final int numberOfOrder;

  @override
  String toString() {
    return 'OrderStatistic(status: $status, numberOfOrder: $numberOfOrder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderStatistic &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.numberOfOrder, numberOfOrder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(numberOfOrder));

  @JsonKey(ignore: true)
  @override
  _$OrderStatisticCopyWith<_OrderStatistic> get copyWith =>
      __$OrderStatisticCopyWithImpl<_OrderStatistic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderStatisticToJson(this);
  }
}

abstract class _OrderStatistic implements OrderStatistic {
  const factory _OrderStatistic(
      {required String status, required int numberOfOrder}) = _$_OrderStatistic;

  factory _OrderStatistic.fromJson(Map<String, dynamic> json) =
      _$_OrderStatistic.fromJson;

  @override
  String get status;
  @override
  int get numberOfOrder;
  @override
  @JsonKey(ignore: true)
  _$OrderStatisticCopyWith<_OrderStatistic> get copyWith =>
      throw _privateConstructorUsedError;
}
