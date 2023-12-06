enum Role {
  DISPATCHERS,
  SALE_ADMIN,
  SALE,
  FLORIST,
  ADMIN,
  PROVINCIAL_ORDER_MANAGER,
  SHIPPER,
}
final Map<Role, String> roleDescriptions = {
  Role.DISPATCHERS: 'Nhân viên phân phối đơn cho shipper',
  Role.SALE_ADMIN: 'Nhân viên sale admin',
  Role.SALE: 'Nhân viên sale',
  Role.FLORIST: 'Thợ',
  Role.ADMIN: 'Admin',
  Role.PROVINCIAL_ORDER_MANAGER: 'Nhân viên quản lý đơn tỉnh',
  Role.SHIPPER: 'Người giao hàng',
};
enum Privilege {
  FLORIST_PRIVILEGE,
  SHIPPER_PRIVILEGE,
  ADMINISTRATOR_PRIVILEGE,
}
enum OrderStatus {
  NEW,
  DOING,
  DONE,
  CUSTOMER_SATISFIED,
  CUSTOMER_REJECTED,
  SALE_REJECTED,
  SHIPPING,
  SHIPPED_WITH_PAYMENT,
  SHIPPED_WITH_NONPAYMENT,
  FINISHED,
  ERROR
}
enum ShipperRouteEnum{
  Initial,
  BEGIN,
  END
}
 enum PaymentTypeEnum {
  CASH, BANK_TRANSFER, MOMO, OTHER
}
