import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'one_order_state.freezed.dart';

@freezed
class OneOrderState with _$OneOrderState {
  const factory OneOrderState.loading() = _Loading;
  const factory OneOrderState.orderLoaded(Order order) = _Loaded;
  const factory OneOrderState.error(AppException error) = _Error;
}
