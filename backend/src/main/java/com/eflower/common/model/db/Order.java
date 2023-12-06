package com.eflower.common.model.db;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "orders")
public class Order extends BaseEntity {

    @Column(name = "code")
    private String code;

    @Column(name = "product_id")
    private String productId;

    @Column(name = "price")
    private BigDecimal price;

    @Enumerated(EnumType.STRING)
    @Column(name = "source")
    private OrderSource source;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private OrderStatus status;

    @Column(name = "delivery_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime deliveryDateTime;

    @Column(name = "customer_message")
    private String customerMessage;

    @Column(name = "note_for_shipper")
    private String noteForShipper;

    @Column(name = "note_for_florist")
    private String noteForFlorist;

    @Column(name = "buyer_id")
    private String buyerId;

    @Column(name = "receiver_id")
    private String receiverId;

    @Column(name = "supported_sale_id")
    private String supportedSaleId;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private Set<OrderAssignmentHistory> assignmentHistories;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private Set<OrderPaymentHistory> paymentHistories;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private Set<OrderComment> comments;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Order)) return false;
        final Order order = (Order) o;
        return id.equals(order.id);
    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }
}
