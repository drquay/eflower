package com.eflower.repository;

import com.eflower.common.model.db.ShipperRouteDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipperRouteDetailRepository extends JpaRepository<ShipperRouteDetail, String> {

    @Modifying(clearAutomatically = true)
    @Query(value = "DELETE FROM ShipperRouteDetail WHERE orderId = :orderId")
    void deleteByOrderId(String orderId);
}
