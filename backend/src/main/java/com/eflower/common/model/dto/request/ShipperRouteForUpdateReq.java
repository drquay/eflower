package com.eflower.common.model.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ShipperRouteForUpdateReq {

    @NotNull
    private String fromLongitude;

    @NotNull
    private String fromLatitude;

    @NotNull
    private String toLongitude;

    @NotNull
    private String toLatitude;

    @NotNull
    private Float numberOfKm;
}
