package com.eflower.repository;

import com.eflower.common.model.db.OrderPaymentHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderPaymentRepository extends JpaRepository<OrderPaymentHistory, String> {

    @Query("SELECT ass FROM OrderPaymentHistory ass INNER JOIN ass.order ord WHERE ord.id = :orderId")
    List<OrderPaymentHistory> findByOrderId(String orderId);
}
