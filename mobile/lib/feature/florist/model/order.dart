import 'package:flutter_boilerplate/feature/comment/model/comment_model.dart';
import 'package:flutter_boilerplate/shared/model/assign_history.dart';
import 'package:flutter_boilerplate/shared/model/attachment.dart';
import 'package:flutter_boilerplate/shared/model/buyer.dart';
import 'package:flutter_boilerplate/shared/model/payment_history.dart';
import 'package:flutter_boilerplate/shared/model/product.dart';
import 'package:flutter_boilerplate/shared/model/receiver.dart';
import 'package:flutter_boilerplate/shared/model/supported_sale.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_boilerplate/shared/model/deposit.dart';
part 'order.freezed.dart';
part 'order.g.dart';

List<Order> ordersFromJson(List<dynamic> data) =>
    List<Order>.from(data.map((x) => Order.fromJson(x)));

orderFromJson(Map<String, dynamic> json) => Order.fromJson(json);

@freezed
class Order with _$Order {
  const Order._();

  const factory Order({
    required String id,
    required int version,
    String? createdOn,
    String? createdBy,
    String? code,
    String? urgentContact,
    double? price,
    Deposit? deposit,
    required String source,
    required String status,
    required String deliveryDateTime,
    required Buyer buyer,
    required List<CommentModel> comments,
    required List<PaymentHistory> paymentHistories,
    required List<AssignHistory> assignmentHistories,
    Product? product,
    Receiver? receiver,
    User? assignedAccount,
    String? customerMessage,
    String? noteForShipper,
    String? noteForFlorist,
    List<Attachment>? attachments,
    required SupportedSale supportedSale,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
