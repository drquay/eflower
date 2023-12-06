package com.eflower.repository;

import com.eflower.common.model.db.OrderComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderCommentRepository extends JpaRepository<OrderComment, String> {

    @Query("SELECT ass FROM OrderComment ass INNER JOIN ass.order ord WHERE ord.id = :orderId")
    List<OrderComment> findByOrderId(String orderId);
}
