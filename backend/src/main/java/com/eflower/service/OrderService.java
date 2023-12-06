package com.eflower.service;

import com.eflower.common.Utils;
import com.eflower.common.model.common.BadRequestException;
import com.eflower.common.model.common.CONST;
import com.eflower.common.model.common.ConflictRequestException;
import com.eflower.common.model.db.Account;
import com.eflower.common.model.db.Attachment;
import com.eflower.common.model.db.Order;
import com.eflower.common.model.db.OrderAssignmentHistory;
import com.eflower.common.model.db.OrderComment;
import com.eflower.common.model.db.OrderPaymentHistory;
import com.eflower.common.model.db.OrderStatus;
import com.eflower.common.model.dto.request.CreateOrderReq;
import com.eflower.common.model.dto.request.OrderBy;
import com.eflower.common.model.dto.request.OrderCommentReq;
import com.eflower.common.model.dto.request.OrderPaymentReq;
import com.eflower.common.model.dto.request.UpdateOrderReq;
import com.eflower.common.model.dto.request.UpdateOrderStatusReq;
import com.eflower.common.model.dto.response.OrderRes;
import com.eflower.common.model.dto.response.PagingRes;
import com.eflower.repository.AccountRepository;
import com.eflower.repository.AttachmentRepository;
import com.eflower.repository.OrderAssignmentRepository;
import com.eflower.repository.OrderRepository;
import com.eflower.repository.ShipperRouteDetailRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
public class OrderService {

    @Value("${orderCodePrefix}")
    private String orderCodePrefix;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private AttachmentRepository attachmentRepository;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private ProductService productService;
    @Autowired
    private OrderCommentService orderCommentService;
    @Autowired
    private OrderPaymentService orderPaymentService;
    @Autowired
    private OrderAssignmentService orderAssignmentService;
    @Autowired
    private OrderAssignmentRepository orderAssignmentRepository;
    @Autowired
    private ShipperRouteService shipperRouteService;
    @Autowired
    private ShipperRouteDetailRepository routeDetailRepository;

    @Transactional
    public PagingRes<OrderRes> find(Optional<String> phoneOfReceiver,
                                    Optional<String> phoneOfBuyer,
                                    Optional<OrderStatus> status,
                                    Optional<String> code,
                                    OrderBy orderBy, int ascDirection, int page, int size) {
        try {
            List<Order> orders;
            Long totalItems;
            if (Utils.isFlorist()) {
                orders = orderRepository.find4FloristOrSale(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null), orderBy.getDbColumn(), ascDirection, page, size);
                totalItems = orderRepository.count4FloristOrSale(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null));
            } else if (Utils.isProvincialOrderManager()) {
                orders = orderRepository.find4ProvincialOrderManager(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null), orderBy.getDbColumn(), ascDirection, page, size);
                totalItems = orderRepository.count4ProvincialOrderManager(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null));
            } else if (Utils.isShipper()) {
                final String shipperId = Utils.getAccountId();
                orders = orderRepository.find4Shipper(shipperId, code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null), orderBy.getDbColumn(), ascDirection, page, size);
                totalItems = orderRepository.count4Shipper(shipperId, code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null));
            } else if (Utils.isDispatchers()) {
                orders = orderRepository.find4Dispatcher(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null), orderBy.getDbColumn(), ascDirection, page, size);
                totalItems = orderRepository.count4Dispatcher(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null));
            } else {
                orders = orderRepository.find4AdminAndSaleAdmin(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null), orderBy.getDbColumn(), ascDirection, page, size);
                totalItems = orderRepository.count4AdminAndSaleAdmin(status.map(OrderStatus::name).orElse(null), code.orElse(null), phoneOfBuyer.orElse(null), phoneOfReceiver.orElse(null));
            }
            final List<OrderRes> content = new HashSet<>(orders).stream().map(this::mapping).collect(Collectors.toList());
            final long totalPages = totalItems % size == 0 ? (totalItems / size) : (totalItems / size + 1);
            return new PagingRes<>(totalItems, (int) totalPages, content, page + 1);
        } catch (Exception e) {
            log.error("Error during retrieving Order", e);
            return new PagingRes<>(0, 0, Collections.emptyList(), page + 1);
        }
    }

    public OrderRes findById(String id) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        return mapping(entity);
    }

    @Transactional
    public String create(CreateOrderReq order) {
        final Order entity = new Order();
        BeanUtils.copyProperties(order, entity);
        entity.setCode(this.generatorOrderCode());
        entity.setStatus(OrderStatus.NEW);
        Set<Attachment> attachments = new HashSet<>();
        if (order.getAttachmentIds() != null) {
            attachments = order.getAttachmentIds().stream()
                    .map(itm -> attachmentRepository.findById(itm).orElseThrow(CONST.RESOURCE_NOT_FOUND))
                    .collect(Collectors.toSet());
        }
        final Order newOrder = orderRepository.save(entity);
        for (Attachment itm : attachments) {
            itm.setParentId(newOrder.getId());
            attachmentRepository.save(itm);
        }
        if (order.getDeposit() != null &&
                order.getDeposit().getAmount() != null &&
                order.getDeposit().getAmount().compareTo(BigDecimal.ZERO) > 0) {
            orderPaymentService.create(newOrder, order.getDeposit(), true);
        }
        if (StringUtils.isNoneEmpty(order.getSupportedSaleId())) {
            orderAssignmentService.create(newOrder, order.getSupportedSaleId());
        }
        return newOrder.getId();
    }

    @Transactional
    public boolean delete(String id) {
        try {
            final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
            attachmentRepository.deleteByParentId(id);
            routeDetailRepository.deleteByOrderId(id);
            orderRepository.delete(entity);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Transactional
    public String update(String id, UpdateOrderReq order) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (!Objects.equals(entity.getVersion(), order.getVersion())) {
            throw new ConflictRequestException();
        }
        BeanUtils.copyProperties(order, entity);
        if (order.getDeposit() != null && StringUtils.isNoneEmpty(order.getDeposit().getId())) {
            orderPaymentService.update(entity, order.getDeposit().getId(), order.getDeposit());
        }
        return orderRepository.save(entity).getId();
    }

    @Transactional
    public OrderRes updateOrderStatus(String id, UpdateOrderStatusReq req) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (!Objects.equals(entity.getVersion(), req.getVersion())) {
            throw new ConflictRequestException();
        }
        final OrderStatus newStatus = req.getStatus();
        entity.setStatus(newStatus);
        final String orderId = orderRepository.save(entity).getId();
        addShipperRoute(newStatus, orderId, req.getToLongitude(), req.getToLatitude());
        reassignedToFloristIfOrderWasRejected(newStatus, entity);
        return mapping(entity);
    }

    @Transactional
    public String reAssigned(String id, String accountId) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        final Account account = accountRepository.findById(accountId).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        orderAssignmentService.create(entity, account.getId());
        return orderRepository.save(entity).getId();
    }

    @Transactional
    public Boolean addImagesToOrder(String id, List<String> imageIds) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        return attachmentService.addAttachmentsIntoParentId(entity.getId(), new HashSet<>(imageIds));
    }

    @Transactional
    public String addPaymentToOrder(String id, OrderPaymentReq payment) {
        final Order order = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        final OrderPaymentHistory paymentHistory = new OrderPaymentHistory();
        paymentHistory.setNew(Boolean.TRUE);
        final Set<OrderPaymentHistory> paymentHistories = order.getPaymentHistories();
        final OrderPaymentHistory entity = orderPaymentService.create(order, payment, false);
        paymentHistories.add(entity);
        orderRepository.save(order);
        return entity.getId();
    }

    @Transactional
    public String updatePayment(String id, String paymentId, OrderPaymentReq req) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        return orderPaymentService.update(entity, paymentId, req);
    }

    @Transactional
    public boolean deletePayment(String id, String paymentId) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        return orderPaymentService.delete(entity, paymentId);
    }

    @Transactional
    public String addCommentToOrder(String id, OrderCommentReq req) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (StringUtils.isEmpty(req.getContent()) && CollectionUtils.isEmpty(req.getAttachmentIds())) {
            throw new BadRequestException();
        }
        final Set<OrderComment> comments = entity.getComments();
        final OrderComment comment = orderCommentService.create(entity, req);
        comments.add(comment);
        orderRepository.save(entity);
        return comment.getId();
    }

    @Transactional
    public String updateComment(String id, String commentId, OrderCommentReq req) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        return orderCommentService.update(entity, commentId, req);
    }

    @Transactional
    public boolean deleteComment(String id, String commentId) {
        final Order entity = orderRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        return orderCommentService.delete(entity, commentId);
    }

    public OrderRes mapping(Order entity) {
        final String id = entity.getId();
        final OrderRes order = new OrderRes();
        BeanUtils.copyProperties(entity, order);
        if (StringUtils.isNoneEmpty(entity.getBuyerId())) {
            order.setBuyer(customerService.findById(entity.getBuyerId()));
        }
        if (StringUtils.isNoneEmpty(entity.getReceiverId())) {
            order.setReceiver(customerService.findById(entity.getReceiverId()));
        }
        if (StringUtils.isNoneEmpty(entity.getProductId())) {
            order.setProduct(productService.findById(entity.getProductId()));
        }
        if (StringUtils.isNoneEmpty(entity.getSupportedSaleId())) {
            order.setSupportedSale(accountService.findById(entity.getSupportedSaleId()));
        }
        order.setDeposit(orderPaymentService.findDepositByOrderId(id));
        order.setAttachments(attachmentService.getAttachmentsByParentId(order.getId()));
        order.setAssignmentHistories(orderAssignmentService.findByOrderId(id));
        order.setComments(orderCommentService.findByOrderId(id));
        order.setPaymentHistories(orderPaymentService.findByOrderId(id));
        return order;
    }

    private String addShipperRoute(OrderStatus newStatus, String orderId,
                                   String toLongitude, String toLatitude) {
        if (Utils.isShipper() && (newStatus == OrderStatus.SHIPPED_WITH_PAYMENT || newStatus == OrderStatus.SHIPPED_WITH_NONPAYMENT)) {
            return shipperRouteService.addRouteDetailShipping(orderId, toLongitude, toLatitude);
        }
        return "";
    }

    private String reassignedToFloristIfOrderWasRejected(OrderStatus newStatus, Order order) {
        if (newStatus == OrderStatus.CUSTOMER_REJECTED) {
            final String floristId = orderAssignmentRepository.findByOrderId(order.getId()).stream()
                    .filter(itm -> accountService.findById(itm.getPersonInCharse()).getRoles().contains("FLORIST"))
                    .map(OrderAssignmentHistory::getPersonInCharse)
                    .findAny().orElse("");
            final OrderAssignmentHistory assignmentHistory = new OrderAssignmentHistory();
            assignmentHistory.setOrder(order);
            assignmentHistory.setPersonInCharse(floristId);
            return orderAssignmentRepository.save(assignmentHistory).getId();
        }
        return "";
    }

    private String generatorOrderCode() {
        Optional<Order> existed;
        String code;
        do {
            code = orderCodePrefix + RandomStringUtils.randomAlphanumeric(6);
            existed = orderRepository.findByCode(code.toUpperCase());
        } while (existed.isPresent());
        return code.toUpperCase();
    }
}
