package com.eflower.common.model.db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.math.BigDecimal;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "shipper_route_details")
public class ShipperRouteDetail extends BaseEntity {

    @Column(name = "order_id")
    private String orderId;

    @Column(name = "to_longitude")
    private String toLongitude;

    @Column(name = "to_latitude")
    private String toLatitude;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "route_id")
    private ShipperRoute route;
}
