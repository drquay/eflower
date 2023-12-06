package com.eflower.common.model.dto.response;

import com.eflower.common.model.db.OrderSource;
import com.eflower.common.model.db.OrderStatus;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OrderRes {

    private Long version;
    private String id;
    private String code;
    private BigDecimal price;
    private OrderSource source;
    private OrderStatus status;
    private String customerMessage;
    private String noteForShipper;
    private String noteForFlorist;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime createdOn;
    private String createdBy;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime deliveryDateTime;

    private OrderPaymentHistoryRes deposit;
    private CustomerRes buyer;
    private CustomerRes receiver;
    private ProductRes product;
    private AccountRes supportedSale;
    private Set<AttachmentRes> attachments;
    private Set<OrderPaymentHistoryRes> paymentHistories;
    private Set<OrderAssignmentHistoryRes> assignmentHistories;
    private Set<OrderCommentRes> comments;
}
