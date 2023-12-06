package com.eflower.repository;

import com.eflower.common.model.db.Order;
import com.eflower.common.model.db.OrderSource;
import com.eflower.common.model.dto.response.OrderStatusStatisticRes;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

// https://www.baeldung.com/spring-data-jpa-null-parameters
@Repository
public interface OrderRepository extends JpaRepository<Order, String> {

    Optional<Order> findByCode(String code);

    @Procedure(procedureName = "GET_ORDERS_FOR_SHIPPERS")
    List<Order> find4Shipper(String accountId, String code, String phoneOfBuyer, String phoneOfReceiver, String orderBy, int ascDirection, int page, int size);

    @Procedure(procedureName = "COUNT_ORDERS_FOR_SHIPPERS")
    Long count4Shipper(String accountId, String code, String phoneOfBuyer, String phoneOfReceiver);

    @Procedure(procedureName = "GET_ORDERS_FOR_SALE_OR_FLORIST")
    List<Order> find4FloristOrSale(String status, String code, String phoneOfBuyer, String phoneOfReceiver, String orderBy, int ascDirection, int page, int size);

    @Procedure(procedureName = "COUNT_ORDERS_FOR_SALE_OR_FLORIST")
    Long count4FloristOrSale(String status, String code, String phoneOfBuyer, String phoneOfReceiver);


    @Procedure(procedureName = "GET_ORDERS_FOR_PROVINCIAL")
    List<Order> find4ProvincialOrderManager(String status, String code, String phoneOfBuyer, String phoneOfReceiver, String orderBy, int ascDirection, int page, int size);

    @Procedure(procedureName = "COUNT_ORDERS_FOR_PROVINCIAL")
    Long count4ProvincialOrderManager(String status, String code, String phoneOfBuyer, String phoneOfReceiver);

    @Procedure(procedureName = "GET_ORDERS_FOR_DISPATCHERS")
    List<Order> find4Dispatcher(String status, String code, String phoneOfBuyer, String phoneOfReceiver, String orderBy, int ascDirection, int page, int size);

    @Procedure(procedureName = "COUNT_ORDERS_FOR_DISPATCHERS")
    Long count4Dispatcher(String status, String code, String phoneOfBuyer, String phoneOfReceiver);

    @Procedure(procedureName = "GET_ORDERS_FOR_ADMIN_OR_SALE_ADMIN")
    List<Order> find4AdminAndSaleAdmin(String status, String code, String phoneOfBuyer, String phoneOfReceiver, String orderBy, int ascDirection, int page, int size);

    @Procedure(procedureName = "COUNT_ORDERS_FOR_ADMIN_OR_SALE_ADMIN")
    Long count4AdminAndSaleAdmin(String status, String code, String phoneOfBuyer, String phoneOfReceiver);


    @Query(value = "SELECT new com.eflower.common.model.dto.response.OrderStatusStatisticRes(status, count(id)) FROM Order GROUP BY status")
    List<OrderStatusStatisticRes> getOrderStatusStatistic();

    @Query(value = "SELECT new com.eflower.common.model.dto.response.OrderStatusStatisticRes(status, count(id)) FROM Order ord WHERE ord.source IN (:sources) GROUP BY status")
    List<OrderStatusStatisticRes> getOrderStatusStatistic(List<OrderSource> sources);

    @Procedure(procedureName = "PROFIT_REPORT_FUNCTION")
    List<List<String>> getProfitReport(String accountId, LocalDateTime fromDate, LocalDateTime toDate);
}
