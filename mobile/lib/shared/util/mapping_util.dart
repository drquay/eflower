import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';

class MappingUtil {
  static String mappingAddress(String address) {
    switch (address) {
      case 'HCM':
        return 'Hồ Chí Minh';
      case 'AGENT':
        return 'Đối tác';
      default:
        return 'Đơn Tỉnh';
    }
  }

  static String mappingCurrentStatus(String currentStatus) {
    final status =
    OrderStatus.values.firstWhere((e) => e.name == currentStatus);
    switch (status) {
      case OrderStatus.NEW:
        return 'Đơn mới';
      case OrderStatus.DOING:
        return 'Đang làm';
      case OrderStatus.DONE:
        return 'Đã hoàn thành';
      case OrderStatus.ERROR:
        return 'Đơn lỗi';
      case OrderStatus.CUSTOMER_SATISFIED:
        return 'Khách đồng ý';
      case OrderStatus.SHIPPED_WITH_NONPAYMENT:
        return 'Chưa thu tiền';
      case OrderStatus.SHIPPED_WITH_PAYMENT:
        return 'Đã thu tiền';
      case OrderStatus.SHIPPING:
        return 'Đang giao';
      case OrderStatus.CUSTOMER_REJECTED:
        return 'Khách từ chối';
      case OrderStatus.FINISHED:
        return 'Đã giao xong';
      default:
        return 'Xong ';
    }
  }

  static Color mappingColorByStatus(String currentStatus) {
    final status =
    OrderStatus.values.firstWhere((e) => e.name == currentStatus);
    switch (status) {
      case OrderStatus.NEW:
      case OrderStatus.DOING:
      case OrderStatus.SHIPPING:
        return Colors.blueAccent;
      case OrderStatus.ERROR:
      case OrderStatus.CUSTOMER_REJECTED:
      case OrderStatus.CUSTOMER_REJECTED:
        return Colors.redAccent;
      case OrderStatus.CUSTOMER_SATISFIED:
      case OrderStatus.SHIPPED_WITH_PAYMENT:
      case OrderStatus.DONE:
      case OrderStatus.FINISHED:
        return Colors.green;
      default:
        return Colors.black12;
    }
  }
}