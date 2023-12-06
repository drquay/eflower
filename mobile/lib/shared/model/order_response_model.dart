import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response_model.freezed.dart';

part 'order_response_model.g.dart';

OrderResponse orderResponse(Map<String, dynamic> json) =>
    OrderResponse.fromJson(json);

@freezed
class OrderResponse with _$OrderResponse {
  const OrderResponse._();

  const factory OrderResponse(
      {required int totalPages,
      required int totalItems,
      required int currentPage,
      required List<Order> items}) = _OrderResponse;

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);
}
