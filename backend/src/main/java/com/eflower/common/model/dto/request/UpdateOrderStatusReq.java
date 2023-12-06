package com.eflower.common.model.dto.request;

import com.eflower.common.model.db.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UpdateOrderStatusReq {

    @NotNull
    private Long version;

    @NotNull
    private OrderStatus status;

    private String toLongitude;
    private String toLatitude;
}
