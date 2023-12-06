package com.eflower.common.model.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ShipperRouteReq {

    @NotNull
    private RouteType type;

    @NotNull
    private String toLongitude;

    @NotNull
    private String toLatitude;

    private Float numberOfKm;
}
