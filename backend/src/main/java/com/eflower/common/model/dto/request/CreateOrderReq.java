package com.eflower.common.model.dto.request;

import com.eflower.common.model.db.OrderSource;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class CreateOrderReq {

    private String productId;

    @NotNull
    @Min(1)
    private BigDecimal price;

    @NotNull
    private OrderSource source;

    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime deliveryDateTime;

    @NotBlank
    @Size(min = 36, max = 36)
    private String supportedSaleId;

    @NotBlank
    @Size(min = 36, max = 36)
    private String buyerId;

    @NotBlank
    @Size(min = 36, max = 36)
    private String receiverId;

    private String customerMessage;
    private String noteForShipper;
    private String noteForFlorist;
    private Set<String> attachmentIds;

    @Valid
    private OrderPaymentReq deposit;
}
