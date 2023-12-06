package com.eflower.repository;

import com.eflower.common.model.db.ShipperRoute;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ShipperRouteRepository extends JpaRepository<ShipperRoute, String> {

    @Query("SELECT r FROM ShipperRoute r WHERE shipperId = :shipperId AND endLongitude IS NULL AND endLatitude IS NULL ORDER BY createdOn DESC")
    List<ShipperRoute> findStartingRouteOfShipper(String shipperId);

    @Query("SELECT r FROM ShipperRoute r WHERE createdOn >= :from AND createdOn <= :to")
    List<ShipperRoute> findByFromDateAndToDate(LocalDateTime from, LocalDateTime to);

    @Query("SELECT r FROM ShipperRoute r WHERE createdOn >= :from AND createdOn <= :to AND shipperId = :shipperId")
    List<ShipperRoute> findByFromDateAndToDateAndShipperId(String shipperId, LocalDateTime from, LocalDateTime to);

    @Query(value = "SELECT * FROM shipper_routes WHERE shipper_id = :shipperId ORDER BY created_on DESC LIMIT 1", nativeQuery = true)
    ShipperRoute findByShipperId(String shipperId);

    @Procedure(procedureName = "GET_SHIPPER_ROUTE")
    List<ShipperRoute> find(String shipperId, LocalDateTime fromDate, LocalDateTime toDate, String orderBy, int ascDirection, int page, int size);

    @Procedure(procedureName = "COUNT_SHIPPER_ROUTE")
    Long count(String shipperId, LocalDateTime fromDate, LocalDateTime toDate);
}
