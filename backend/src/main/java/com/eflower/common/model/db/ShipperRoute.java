package com.eflower.common.model.db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "shipper_routes")
public class ShipperRoute extends BaseEntity {

    @Column(name = "shipper_id", nullable = false)
    private String shipperId;

    @Column(name = "number_of_km")
    private Float numberOfKm;

    @Column(name = "begin_longitude")
    private String beginLongitude;

    @Column(name = "begin_latitude")
    private String beginLatitude;

    @Column(name = "end_longitude")
    private String endLongitude;

    @Column(name = "end_latitude")
    private String endLatitude;

    @OneToMany(mappedBy = "route", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<ShipperRouteDetail> details;
}
