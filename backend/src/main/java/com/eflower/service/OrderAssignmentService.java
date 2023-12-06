package com.eflower.service;

import com.eflower.common.model.db.Order;
import com.eflower.common.model.db.OrderAssignmentHistory;
import com.eflower.common.model.dto.response.AccountRes;
import com.eflower.common.model.dto.response.OrderAssignmentHistoryRes;
import com.eflower.repository.OrderAssignmentRepository;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Service
public class OrderAssignmentService {

    @Autowired
    private OrderAssignmentRepository orderAssignmentRepository;
    @Autowired
    private AccountService accountService;

    public String create(Order order, String accountId) {
        final OrderAssignmentHistory assignmentHistory = new OrderAssignmentHistory();
        assignmentHistory.setOrder(order);
        assignmentHistory.setPersonInCharse(accountId);
        return orderAssignmentRepository.save(assignmentHistory).getId();
    }

    public Set<OrderAssignmentHistoryRes> findByOrderId(String orderId) {
        return orderAssignmentRepository.findByOrderId(orderId)
                .stream().map(this::mapping).collect(Collectors.toSet());
    }

    private OrderAssignmentHistoryRes mapping(OrderAssignmentHistory entity) {
        final OrderAssignmentHistoryRes dto = new OrderAssignmentHistoryRes();
        BeanUtils.copyProperties(entity, dto);
        if (StringUtils.isNoneEmpty(entity.getPersonInCharse())) {
            final AccountRes acc = accountService.findById(entity.getPersonInCharse());
            dto.setPersonInCharse(acc);
        }
        return dto;
    }
}
