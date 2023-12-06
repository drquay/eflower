package com.eflower.repository;

import com.eflower.common.model.db.OrderAssignmentHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderAssignmentRepository extends JpaRepository<OrderAssignmentHistory, String> {

    @Query("SELECT ass FROM OrderAssignmentHistory ass INNER JOIN ass.order ord WHERE ord.id = :orderId")
    List<OrderAssignmentHistory> findByOrderId(String orderId);

    List<OrderAssignmentHistory> findByPersonInCharse(String personInCharse);
}
