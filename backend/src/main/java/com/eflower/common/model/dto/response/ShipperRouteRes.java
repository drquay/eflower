package com.eflower.common.model.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ShipperRouteRes {
    private String id;
    private String shipperId;
    private Float numberOfKm;
    private String beginLongitude;
    private String beginLatitude;
    private String endLongitude;
    private String endLatitude;
    private LocalDateTime createdOn;
    private List<ShipperRouteDetailRes> details;
}
