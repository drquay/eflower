package com.eflower.service;

import com.eflower.common.Utils;
import com.eflower.common.model.common.CONST;
import com.eflower.common.model.db.Order;
import com.eflower.common.model.db.OrderPaymentHistory;
import com.eflower.common.model.db.PaymentReason;
import com.eflower.common.model.dto.request.OrderPaymentReq;
import com.eflower.common.model.dto.response.OrderPaymentHistoryRes;
import com.eflower.repository.OrderPaymentRepository;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class OrderPaymentService {

    @Autowired
    private OrderPaymentRepository orderPaymentRepository;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private AccountService accountService;

    @Transactional
    public String update(Order order, String id, OrderPaymentReq req) {
        final OrderPaymentHistory entity = orderPaymentRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (isCommentBelongOrder(order, entity) && Utils.isEntityBelongCurrentUser(entity)) {
            BeanUtils.copyProperties(req, entity);
            entity.setNew(Boolean.FALSE);
            if (CollectionUtils.isNotEmpty(req.getAttachmentIds())) {
                attachmentService.deleteAttachmentsByParentId(id);
                attachmentService.addAttachmentsIntoParentId(id, req.getAttachmentIds());
            }
            return orderPaymentRepository.save(entity).getId();
        }
        return "";
    }

    @Transactional
    public boolean delete(Order order, String id) {
        final OrderPaymentHistory entity = orderPaymentRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (isCommentBelongOrder(order, entity) && Utils.isEntityBelongCurrentUser(entity)) {
            orderPaymentRepository.deleteById(id);
            return attachmentService.deleteAttachmentsByParentId(id);
        }
        return false;
    }

    @Transactional
    public OrderPaymentHistory create(Order order, OrderPaymentReq req, boolean isDeposit) {
        OrderPaymentHistory entity = new OrderPaymentHistory();
        BeanUtils.copyProperties(req, entity);
        entity.setNew(Boolean.TRUE);
        entity.setPaymentReason(isDeposit ? PaymentReason.DEPOSIT : PaymentReason.OTHER);
        entity.setOrder(order);
        entity = orderPaymentRepository.save(entity);
        if (CollectionUtils.isNotEmpty(req.getAttachmentIds())) {
            attachmentService.addAttachmentsIntoParentId(entity.getId(), req.getAttachmentIds());
        }
        return entity;
    }

    public Set<OrderPaymentHistoryRes> findByOrderId(String orderId) {
        return orderPaymentRepository.findByOrderId(orderId)
                .stream().map(this::mapping).collect(Collectors.toSet());
    }

    public OrderPaymentHistoryRes findDepositByOrderId(String orderId) {
        final Optional<OrderPaymentHistoryRes> res = findByOrderId(orderId).stream().filter(itm -> PaymentReason.DEPOSIT == itm.getPaymentReason()).findFirst();
        return res.orElse(OrderPaymentHistoryRes.builder().amount(BigDecimal.ZERO).paymentReason(PaymentReason.DEPOSIT).build());
    }

    private OrderPaymentHistoryRes mapping(OrderPaymentHistory entity) {
        final OrderPaymentHistoryRes dto = new OrderPaymentHistoryRes();
        BeanUtils.copyProperties(entity, dto);
        dto.setAttachments(attachmentService.getAttachmentsByParentId(entity.getId()));
        dto.setMoneyKeeper(accountService.findById(entity.getMoneyKeeperId()));
        return dto;
    }

    private boolean isCommentBelongOrder(Order order, OrderPaymentHistory entity) {
        final Optional<OrderPaymentHistory> existedEntity = orderPaymentRepository.findByOrderId(order.getId())
                .stream().filter(itm -> itm.getId().equals(entity.getId()))
                .findAny();
        return Utils.isEntityBelongOrder(existedEntity, entity);
    }
}
