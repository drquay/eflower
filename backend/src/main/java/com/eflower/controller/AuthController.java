package com.eflower.controller;

import com.eflower.common.model.dto.request.LoginReq;
import com.eflower.common.model.dto.request.SignupReq;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AccountService accountService;

    @PostMapping("/signin")
    public ResponseEntity<?> signIn(@Valid @RequestBody LoginReq login) {
        return ResponseEntity.ok(new BaseResponseEntity(accountService.signIn(login)));
    }

    @PreAuthorize("hasAnyAuthority('PRI_ADMIN')")
    @PostMapping("/signup")
    public ResponseEntity<?> signUp(@Valid @RequestBody SignupReq signUp) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(accountService.signUp(signUp))));
    }
}
