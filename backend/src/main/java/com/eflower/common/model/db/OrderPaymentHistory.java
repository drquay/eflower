package com.eflower.common.model.db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "order_payment_histories")
public class OrderPaymentHistory extends BaseEntity {

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_reason")
    private PaymentReason paymentReason;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private PaymentType type;

    @Column(name = "amount")
    private BigDecimal amount;

    @Column(name = "money_keeper_id")
    private String moneyKeeperId;

    @Column(name = "note", columnDefinition = "text")
    private String note;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id")
    private Order order;
}
