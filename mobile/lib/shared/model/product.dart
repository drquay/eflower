import 'package:flutter_boilerplate/shared/model/attachment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

List<Product> productsFromJson(List<dynamic> data) =>
    List<Product>.from(data.map((x) => Product.fromJson(x)));

Product productFromJson(Map<String, dynamic> json) => Product.fromJson(json);

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    String? id,
    String? code,
    String? name,
    String? description,
    List<Attachment>? images,
    double? price,
    String? referenceUrl,
    String? createdOn
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
