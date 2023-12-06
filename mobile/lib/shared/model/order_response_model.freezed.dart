// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return _OrderResponse.fromJson(json);
}

/// @nodoc
class _$OrderResponseTearOff {
  const _$OrderResponseTearOff();

  _OrderResponse call(
      {required int totalPages,
      required int totalItems,
      required int currentPage,
      required List<Order> items}) {
    return _OrderResponse(
      totalPages: totalPages,
      totalItems: totalItems,
      currentPage: currentPage,
      items: items,
    );
  }

  OrderResponse fromJson(Map<String, Object?> json) {
    return OrderResponse.fromJson(json);
  }
}

/// @nodoc
const $OrderResponse = _$OrderResponseTearOff();

/// @nodoc
mixin _$OrderResponse {
  int get totalPages => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  List<Order> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderResponseCopyWith<OrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderResponseCopyWith<$Res> {
  factory $OrderResponseCopyWith(
          OrderResponse value, $Res Function(OrderResponse) then) =
      _$OrderResponseCopyWithImpl<$Res>;
  $Res call(
      {int totalPages, int totalItems, int currentPage, List<Order> items});
}

/// @nodoc
class _$OrderResponseCopyWithImpl<$Res>
    implements $OrderResponseCopyWith<$Res> {
  _$OrderResponseCopyWithImpl(this._value, this._then);

  final OrderResponse _value;
  // ignore: unused_field
  final $Res Function(OrderResponse) _then;

  @override
  $Res call({
    Object? totalPages = freezed,
    Object? totalItems = freezed,
    Object? currentPage = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      totalPages: totalPages == freezed
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: totalItems == freezed
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Order>,
    ));
  }
}

/// @nodoc
abstract class _$OrderResponseCopyWith<$Res>
    implements $OrderResponseCopyWith<$Res> {
  factory _$OrderResponseCopyWith(
          _OrderResponse value, $Res Function(_OrderResponse) then) =
      __$OrderResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int totalPages, int totalItems, int currentPage, List<Order> items});
}

/// @nodoc
class __$OrderResponseCopyWithImpl<$Res>
    extends _$OrderResponseCopyWithImpl<$Res>
    implements _$OrderResponseCopyWith<$Res> {
  __$OrderResponseCopyWithImpl(
      _OrderResponse _value, $Res Function(_OrderResponse) _then)
      : super(_value, (v) => _then(v as _OrderResponse));

  @override
  _OrderResponse get _value => super._value as _OrderResponse;

  @override
  $Res call({
    Object? totalPages = freezed,
    Object? totalItems = freezed,
    Object? currentPage = freezed,
    Object? items = freezed,
  }) {
    return _then(_OrderResponse(
      totalPages: totalPages == freezed
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: totalItems == freezed
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Order>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderResponse extends _OrderResponse {
  const _$_OrderResponse(
      {required this.totalPages,
      required this.totalItems,
      required this.currentPage,
      required this.items})
      : super._();

  factory _$_OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$$_OrderResponseFromJson(json);

  @override
  final int totalPages;
  @override
  final int totalItems;
  @override
  final int currentPage;
  @override
  final List<Order> items;

  @override
  String toString() {
    return 'OrderResponse(totalPages: $totalPages, totalItems: $totalItems, currentPage: $currentPage, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderResponse &&
            const DeepCollectionEquality()
                .equals(other.totalPages, totalPages) &&
            const DeepCollectionEquality()
                .equals(other.totalItems, totalItems) &&
            const DeepCollectionEquality()
                .equals(other.currentPage, currentPage) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(totalPages),
      const DeepCollectionEquality().hash(totalItems),
      const DeepCollectionEquality().hash(currentPage),
      const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$OrderResponseCopyWith<_OrderResponse> get copyWith =>
      __$OrderResponseCopyWithImpl<_OrderResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderResponseToJson(this);
  }
}

abstract class _OrderResponse extends OrderResponse {
  const factory _OrderResponse(
      {required int totalPages,
      required int totalItems,
      required int currentPage,
      required List<Order> items}) = _$_OrderResponse;
  const _OrderResponse._() : super._();

  factory _OrderResponse.fromJson(Map<String, dynamic> json) =
      _$_OrderResponse.fromJson;

  @override
  int get totalPages;
  @override
  int get totalItems;
  @override
  int get currentPage;
  @override
  List<Order> get items;
  @override
  @JsonKey(ignore: true)
  _$OrderResponseCopyWith<_OrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
