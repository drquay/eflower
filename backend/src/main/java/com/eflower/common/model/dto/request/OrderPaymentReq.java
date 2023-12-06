package com.eflower.common.model.dto.request;

import com.eflower.common.model.db.PaymentType;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderPaymentReq {

    private String id;

    @NotNull
    private PaymentType type;

    @Min(0)
    private BigDecimal amount;

    private String note;
    private String moneyKeeperId;
    private Set<String> attachmentIds;
}
