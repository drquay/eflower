// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderResponse _$$_OrderResponseFromJson(Map<String, dynamic> json) =>
    _$_OrderResponse(
      totalPages: json['totalPages'] as int,
      totalItems: json['totalItems'] as int,
      currentPage: json['currentPage'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_OrderResponseToJson(_$_OrderResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'currentPage': instance.currentPage,
      'items': instance.items,
    };
