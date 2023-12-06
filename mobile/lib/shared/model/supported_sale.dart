import 'package:freezed_annotation/freezed_annotation.dart';

part 'supported_sale.freezed.dart';
part 'supported_sale.g.dart';

List<SupportedSale> supportedSalesFromJson(List<dynamic> data) =>
    List<SupportedSale>.from(data.map((x) => SupportedSale.fromJson(x)));

SupportedSale supportedSaleFromJson(Map<String, dynamic> json) => SupportedSale.fromJson(json);

@freezed
class SupportedSale with _$SupportedSale {
  const SupportedSale._();

  const factory SupportedSale({
    required String id,
    String? fullName,
    String? phoneNumber,
    String? username,
    String? avatar,
    bool? blocked,
    List<String>? roles,
  }) = _SupportedSale;

  factory SupportedSale.fromJson(Map<String, dynamic> json) => _$SupportedSaleFromJson(json);
}
