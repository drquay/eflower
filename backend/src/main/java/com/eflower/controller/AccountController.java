package com.eflower.controller;

import com.eflower.common.model.dto.request.ChangePassReq;
import com.eflower.common.model.dto.request.CustomerOrderBy;
import com.eflower.common.model.dto.request.UpdateAccountInfoReq;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Optional;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/accounts")
@Validated
public class AccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping
    public ResponseEntity<?> find(@Valid @Min(0) @RequestParam(defaultValue = "0") int page,
                                  @Valid @Min(0) @Max(1000) @RequestParam(defaultValue = "50") int size,
                                  @RequestParam(name = "name", required = false) Optional<String> name,
                                  @RequestParam(name = "phone", required = false) Optional<String> phone,
                                  @RequestParam(name = "username", required = false) Optional<String> username,
                                  @RequestParam(name = "sortBy", required = false, defaultValue = "createdOn") CustomerOrderBy orderBy,
                                  @RequestParam(name = "ascDirection", required = false, defaultValue = "0") int ascDirection) {
        return ResponseEntity.ok(new BaseResponseEntity(accountService.find(name, phone, username, orderBy, ascDirection, page, size)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                    @Valid @RequestBody UpdateAccountInfoReq account) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(accountService.update(id, account))));
    }

    @PostMapping("/{id}/change-password")
    public ResponseEntity<?> changeAccountPassword(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                                   @Valid @RequestBody ChangePassReq request) {
        return accountService.changePassword(id, request) ? ResponseEntity.ok().build() : ResponseEntity.internalServerError().build();
    }

    @PreAuthorize("hasAnyAuthority('PRI_ADMIN')")
    @PutMapping("/{id}/blocked")
    public ResponseEntity<?> blockAccount(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return accountService.lockOrUnblockAccount(id, Boolean.TRUE) ? ResponseEntity.ok().build() : ResponseEntity.internalServerError().build();
    }

    @PreAuthorize("hasAnyAuthority('PRI_ADMIN')")
    @PutMapping("/{id}/un-blocked")
    public ResponseEntity<?> unblockAccount(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return accountService.lockOrUnblockAccount(id, Boolean.FALSE) ? ResponseEntity.ok().build() : ResponseEntity.internalServerError().build();
    }
}
