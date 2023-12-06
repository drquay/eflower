import 'package:flutter_boilerplate/shared/constants/enum.dart';

class OrderStatusUtil {
  static String mappingBtnActionFlorist(String currentStatus) {
    final status =
        OrderStatus.values.firstWhere((e) => e.name == currentStatus);
    switch (status) {
      case OrderStatus.NEW:
        return 'Nhận đơn';
      case OrderStatus.DOING:
        return 'Làm xong';
      case OrderStatus.DONE:
        return 'Đã hoàn thành';
      case OrderStatus.ERROR:
        return 'Hủy đơn';
      case OrderStatus.CUSTOMER_SATISFIED:
        return 'Nhận đơn';
      case OrderStatus.SHIPPED_WITH_NONPAYMENT:
        return 'ổi người giữ tiền';
      case OrderStatus.SHIPPED_WITH_PAYMENT:
        return 'Đổi người giữ tiền';
      case OrderStatus.SHIPPING:
        return 'Giao hàng xong';
      case OrderStatus.CUSTOMER_REJECTED:
        return 'Làm xong';
      case OrderStatus.FINISHED:
        return 'Đã giao xong';
      default:
        return 'Xong ';
    }
  }
}
