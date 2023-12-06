package com.eflower.common.model.dto.response;

import com.eflower.common.model.db.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OrderStatusStatisticRes {

    private OrderStatus status;
    private Long numberOfOrder;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OrderStatusStatisticRes)) return false;
        OrderStatusStatisticRes that = (OrderStatusStatisticRes) o;
        return status == that.status;
    }

    @Override
    public int hashCode() {
        return status.hashCode();
    }
}
