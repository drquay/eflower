package com.eflower.controller;

import com.eflower.common.model.dto.request.ProductOrderBy;
import com.eflower.common.model.dto.request.ProductReq;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.ProductService;
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

@Validated
@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping
    public ResponseEntity<?> create(@Valid @RequestBody ProductReq product) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(productService.create(product))));
    }

    @GetMapping
    public ResponseEntity<?> find(@Valid @Min(0) @RequestParam(defaultValue = "0") int page,
                                  @Valid @Min(0) @Max(1000) @RequestParam(defaultValue = "50") int size,
                                  @RequestParam(name = "name", required = false) Optional<String> name,
                                  @RequestParam(name = "code", required = false) Optional<String> code,
                                  @RequestParam(name = "sortBy", required = false, defaultValue = "createdOn") ProductOrderBy orderBy,
                                  @RequestParam(name = "ascDirection", required = false, defaultValue = "0") int ascDirection) {
        return ResponseEntity.ok(new BaseResponseEntity(productService.find(name, code, orderBy, ascDirection, page, size)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(new BaseResponseEntity(productService.findById(id)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                    @Valid @RequestBody ProductReq product) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(productService.update(id, product))));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(new BaseResponseEntity(productService.delete(id)));
    }
}
