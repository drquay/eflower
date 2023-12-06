import 'package:flutter_boilerplate/shared/model/attachment.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_history.freezed.dart';
part 'payment_history.g.dart';
List<PaymentHistory> paymentHistorysFromJson(List<dynamic> data) =>
    List<PaymentHistory>.from(data.map((x) => PaymentHistory.fromJson(x)));

PaymentHistory paymentHistoryFromJson(Map<String, dynamic> json) => PaymentHistory.fromJson(json);

@freezed
class PaymentHistory with _$PaymentHistory {
  const PaymentHistory._();

  const factory PaymentHistory({
    required String id,
    required String type,
    required double amount,
    required User moneyKeeper,
    required String paymentReason,
    required List<Attachment> attachments,
    String? createdBy,
    String? note,
    String? createdOn,
  }) = _PaymentHistory;

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => _$PaymentHistoryFromJson(json);
}
