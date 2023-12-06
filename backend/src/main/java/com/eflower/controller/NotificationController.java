package com.eflower.controller;

import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.Size;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/notifications")
@Validated
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @PreAuthorize("hasAnyAuthority('PRI_SHIPPER')")
    @PostMapping("/shipper-stopping")
    public ResponseEntity<?> shipperStopping() {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(notificationService.createShipperStoppedNotification())));
    }

    @PreAuthorize("hasAnyAuthority('PRI_SHIPPER')")
    @PostMapping("/shipper-shutdown-app")
    public ResponseEntity<?> shipperShutdownApp() {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(notificationService.createShipperShutdownAppNotification())));
    }

    @PreAuthorize("hasAnyAuthority('PRI_FLORIST')")
    @PostMapping("/florist-received-order")
    public ResponseEntity<?> floristReceivedOrder(@Valid @Size(min = 36, max = 36) @RequestParam String orderId) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(notificationService.createFloristReceivedOrderNotification(orderId))));
    }
}
