package com.eflower.common.model.db;

public enum OrderStatus {
    NEW,
    DOING,
    DONE,
    CUSTOMER_SATISFIED, CUSTOMER_REJECTED, SALE_REJECTED,
    SHIPPING,
    SHIPPED_WITH_PAYMENT, SHIPPED_WITH_NONPAYMENT,
    FINISHED,
    ERROR
}
