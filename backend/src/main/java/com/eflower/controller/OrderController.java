package com.eflower.controller;

import com.eflower.common.model.db.OrderStatus;
import com.eflower.common.model.dto.NotifyDto;
import com.eflower.common.model.dto.request.*;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.common.model.dto.response.OrderRes;
import com.eflower.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.socket.TextMessage;

import javax.validation.Valid;
import javax.validation.constraints.*;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@Validated
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private SocketHandler socketHandler;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private OrderService orderService;

    @PostMapping
    public ResponseEntity<?> create(@Valid @RequestBody CreateOrderReq order) throws IOException {

        // Call service.
        var response = orderService.create(order);

        // Send notify.
        var notify = new NotifyDto();
        notify.setType("message");
        notify.setName("headerComponent");
        notify.setMessage("Tạo mới đơn hàng.");
        this.socketHandler.sendNotify(new TextMessage(objectMapper.writeValueAsString(notify)));

        // return.
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(response)));
    }

    @GetMapping
    public ResponseEntity<?> find(@Valid @Min(0) @RequestParam(defaultValue = "0") int page,
                                  @Valid @Min(0) @Max(1000) @RequestParam(defaultValue = "50") int size,
                                  @RequestParam(name = "receiverPhoneNumber", required = false) Optional<String> phoneOfReceiver,
                                  @RequestParam(name = "buyerPhoneNumber", required = false) Optional<String> phoneOfBuyer,
                                  @RequestParam(name = "status", required = false) Optional<OrderStatus> status,
                                  @RequestParam(name = "code", required = false) Optional<String> code,
                                  @RequestParam(name = "sortBy", required = false, defaultValue = "createdOn") OrderBy orderBy,
                                  @RequestParam(name = "ascDirection", required = false, defaultValue = "0") int ascDirection) {

        return ResponseEntity.ok(new BaseResponseEntity(orderService.find(phoneOfReceiver, phoneOfBuyer, status, code, orderBy, ascDirection, page, size)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(new BaseResponseEntity(orderService.findById(id)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(orderService.delete(id) ? ResponseEntity.ok().build() : ResponseEntity.internalServerError().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                    @Valid @RequestBody UpdateOrderReq order) throws IOException {

        // Call service.
        var response = orderService.update(id, order);

        // Send notify.
        var notify = new NotifyDto();
        notify.setType("message");
        notify.setName("headerComponent");
        notify.setMessage("Cập nhật đơn hàng: " + order.getCode());
        this.socketHandler.sendNotify(new TextMessage(objectMapper.writeValueAsString(notify)));

        // return.
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(response)));
    }

    @PutMapping("/{id}/statuses")
    public ResponseEntity<?> updateOrderStatus(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                               @Valid @RequestBody UpdateOrderStatusReq req) throws IOException {
        OrderRes orderRes = orderService.updateOrderStatus(id, req);
        var notify = new NotifyDto();
        notify.setType("message");
        notify.setName("headerComponent");
        notify.setMessage("Cập nhật đơn hàng: " + orderRes.getCode());
        this.socketHandler.sendNotify(new TextMessage(objectMapper.writeValueAsString(notify)));
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(orderRes.getId())));
    }

    @PutMapping("/{id}/re-assigned")
    public ResponseEntity<?> reAssignedOrderTo(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                               @Valid @NotBlank @Size(min = 36, max = 36) @RequestParam String accountId) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(orderService.reAssigned(id, accountId))));
    }

    @PostMapping("/{id}/images")
    public ResponseEntity<?> addImagesToOrder(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                              @Valid @RequestBody @NotEmpty List<String> imageIds) {
        return orderService.addImagesToOrder(id, imageIds) ?
                ResponseEntity.accepted().build() :
                ResponseEntity.internalServerError().build();
    }

    @PostMapping("/{id}/comments")
    public ResponseEntity<?> addComment(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                        @Valid @RequestBody OrderCommentReq comment) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(orderService.addCommentToOrder(id, comment))));
    }

    @PutMapping("/{id}/comments/{commentId}")
    public ResponseEntity<?> updateComment(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                           @Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String commentId,
                                           @Valid @RequestBody OrderCommentReq comment) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(orderService.updateComment(id, commentId, comment))));
    }

    @DeleteMapping("/{id}/comments/{commentId}")
    public ResponseEntity<?> deleteComment(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                           @Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String commentId) {
        return ResponseEntity.ok(orderService.deleteComment(id, commentId) ? ResponseEntity.ok().build() : ResponseEntity.internalServerError().build());
    }

    @PostMapping("/{id}/payments")
    public ResponseEntity<?> addPaymentHistory(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                               @Valid @RequestBody OrderPaymentReq payment) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(orderService.addPaymentToOrder(id, payment))));
    }

    @PutMapping("/{id}/payments/{paymentId}")
    public ResponseEntity<?> updatePaymentHistory(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                                  @Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String paymentId,
                                                  @Valid @RequestBody OrderPaymentReq payment) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(orderService.updatePayment(id, paymentId, payment))));
    }

    @DeleteMapping("/{id}/payments/{paymentId}")
    public ResponseEntity<?> deletePayment(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                           @Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String paymentId) {
        return ResponseEntity.ok(orderService.deletePayment(id, paymentId) ? ResponseEntity.ok().build() : ResponseEntity.internalServerError().build());
    }
}
