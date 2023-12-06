import 'package:flutter_boilerplate/shared/model/attachment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit.freezed.dart';
part 'deposit.g.dart';

List<Deposit> depositsFromJson(List<dynamic> data) =>
    List<Deposit>.from(data.map((x) => Deposit.fromJson(x)));

Deposit depositFromJson(Map<String, dynamic> json) => Deposit.fromJson(json);

@freezed
class Deposit with _$Deposit {
  const Deposit._();

  const factory Deposit({
    String? id,
    double? amount,
    List<Attachment>? attachments,
    String? moneyKeeperId,
    String? paymentReason,
    String? note,
    String? type,
    String? createdOn
  }) = _Deposit;

  factory Deposit.fromJson(Map<String, dynamic> json) =>
      _$DepositFromJson(json);
}
