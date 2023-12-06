package com.eflower.controller;

import com.eflower.common.model.db.OrderStatus;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/configurations")
public class ConfigurationController {

    @Autowired
    private RoleService roleService;

    @GetMapping("/roles")
    public ResponseEntity<?> findAllRoles() {
        return ResponseEntity.ok(new BaseResponseEntity(roleService.findAll()));
    }

    @GetMapping("/order-statuses")
    public ResponseEntity<?> findAllOrderStatuses() {
        return ResponseEntity.ok(new BaseResponseEntity(OrderStatus.values()));
    }
}
