import 'package:freezed_annotation/freezed_annotation.dart';

part 'buyer.freezed.dart';
part 'buyer.g.dart';

List<Buyer> buyersFromJson(List<dynamic> data) =>
    List<Buyer>.from(data.map((x) => Buyer.fromJson(x)));

Buyer buyerFromJson(Map<String, dynamic> json) => Buyer.fromJson(json);

@freezed
class Buyer with _$Buyer {
  const Buyer._();

  const factory Buyer({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? address,
    String? createdOn
  }) = _Buyer;

  factory Buyer.fromJson(Map<String, dynamic> json) => _$BuyerFromJson(json);
}
