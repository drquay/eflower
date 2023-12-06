package com.eflower.service;

import com.eflower.common.Utils;
import com.eflower.common.model.common.BadRequestException;
import com.eflower.common.model.common.CONST;
import com.eflower.common.model.db.Account;
import com.eflower.common.model.db.Order;
import com.eflower.common.model.db.OrderComment;
import com.eflower.common.model.dto.request.OrderCommentReq;
import com.eflower.common.model.dto.response.OrderCommentRes;
import com.eflower.repository.AccountRepository;
import com.eflower.repository.OrderCommentRepository;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class OrderCommentService {

    @Autowired
    private OrderCommentRepository orderCommentRepository;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private AccountService accountService;

    @Transactional
    public String update(Order order, String id, OrderCommentReq req) {
        final OrderComment entity = orderCommentRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (StringUtils.isEmpty(req.getContent()) && CollectionUtils.isEmpty(req.getAttachmentIds())) {
            throw new BadRequestException();
        }
        if (isCommentBelongOrder(order, entity) && Utils.isEntityBelongCurrentUser(entity)) {
            BeanUtils.copyProperties(req, entity);
            if (CollectionUtils.isNotEmpty(req.getAttachmentIds())) {
                attachmentService.deleteAttachmentsByParentId(id);
                attachmentService.addAttachmentsIntoParentId(id, req.getAttachmentIds());
            }
            return orderCommentRepository.save(entity).getId();
        }
        return "";
    }

    @Transactional
    public boolean delete(Order order, String id) {
        final OrderComment entity = orderCommentRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (isCommentBelongOrder(order, entity) && Utils.isEntityBelongCurrentUser(entity)) {
            orderCommentRepository.deleteById(id);
            return attachmentService.deleteAttachmentsByParentId(id);
        }
        return false;
    }

    @Transactional
    public OrderComment create(Order order, OrderCommentReq req) {
        if (StringUtils.isEmpty(req.getContent()) && CollectionUtils.isEmpty(req.getAttachmentIds())) {
            throw new BadRequestException();
        }
        final OrderComment comment = new OrderComment();
        comment.setContent(req.getContent());
        comment.setOrder(order);
        comment.setNew(Boolean.TRUE);
        final OrderComment entity = orderCommentRepository.save(comment);
        if (CollectionUtils.isNotEmpty(req.getAttachmentIds())) {
            attachmentService.addAttachmentsIntoParentId(entity.getId(), req.getAttachmentIds());
        }
        return entity;
    }

    public Set<OrderCommentRes> findByOrderId(String orderId) {
        return orderCommentRepository.findByOrderId(orderId)
                .stream().map(this::mapping).collect(Collectors.toSet());
    }

    private boolean isCommentBelongOrder(Order order, OrderComment entity) {
        final Optional<OrderComment> comment = orderCommentRepository.findByOrderId(order.getId())
                .stream().filter(itm -> itm.getId().equals(entity.getId()))
                .findAny();
        return Utils.isEntityBelongOrder(comment, entity);
    }

    private OrderCommentRes mapping(OrderComment entity) {
        final OrderCommentRes dto = new OrderCommentRes();
        BeanUtils.copyProperties(entity, dto);
        dto.setAttachments(attachmentService.getAttachmentsByParentId(entity.getId()));
        dto.setCreatedBy(accountService.findByUsername(entity.getCreatedBy()));
        return dto;
    }
}
