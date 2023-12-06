import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.loading() = _Loading;
  const factory OrdersState.ordersLoaded(OrderResponse orderResponse) = _Loaded;
  const factory OrdersState.error(AppException error) = _Error;
}
