package com.eflower.controller;

import com.eflower.common.model.dto.request.CustomerOrderBy;
import com.eflower.common.model.dto.request.CustomerReq;
import com.eflower.common.model.dto.request.OrderBy;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Optional;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/customers")
@Validated
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @PostMapping
    public ResponseEntity<?> create(@Valid @RequestBody CustomerReq customer) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(customerService.create(customer))));
    }

    @GetMapping
    public ResponseEntity<?> find(
            @Valid @Min(0) @RequestParam(defaultValue = "0") int page,
            @Valid @Min(0) @Max(1000) @RequestParam(defaultValue = "50") int size,
            @RequestParam(name = "name", required = false) Optional<String> name,
            @RequestParam(name = "phone", required = false) Optional<String> phone,
            @RequestParam(name = "address", required = false) Optional<String> address,
            @RequestParam(name = "sortBy", required = false, defaultValue = "createdOn") CustomerOrderBy orderBy,
            @RequestParam(name = "ascDirection", required = false, defaultValue = "0") int ascDirection) {
        return ResponseEntity.ok(new BaseResponseEntity(customerService.find(name, phone, address, orderBy, ascDirection, page, size)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                    @Valid @RequestBody CustomerReq customer) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(customerService.update(id, customer))));
    }
}
