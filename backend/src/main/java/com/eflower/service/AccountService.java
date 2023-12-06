package com.eflower.service;

import com.eflower.common.JwtUtils;
import com.eflower.common.Utils;
import com.eflower.common.model.common.AccountDetails;
import com.eflower.common.model.common.CONST;
import com.eflower.common.model.common.ResourceNotFoundException;
import com.eflower.common.model.db.Account;
import com.eflower.common.model.db.Role;
import com.eflower.common.model.dto.request.*;
import com.eflower.common.model.dto.response.AccountRes;
import com.eflower.common.model.dto.response.FError;
import com.eflower.common.model.dto.response.LoginRes;
import com.eflower.common.model.dto.response.PagingRes;
import com.eflower.repository.AccountRepository;
import com.eflower.repository.RoleRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;
import java.util.stream.Collectors;

import static com.eflower.common.model.common.CONST.*;

@Slf4j
@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private JwtUtils jwtUtils;
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private PasswordEncoder encoder;

    public AccountRes findByUsername(String username) {
        if (StringUtils.isNoneEmpty(username)) {
            final Account account = accountRepository.findByUsername(username).orElse(null);
            return account == null ? new AccountRes() : mapping(account);
        }
        throw new ResourceNotFoundException(new FError(EFL0006_ID, EFL0006_MSG));
    }

    public AccountRes findById(String id) {
        if (StringUtils.isNoneEmpty(id)) {
            final Account account = accountRepository.findById(id).orElse(null);
            return account == null ? new AccountRes() : mapping(account);
        }
        throw new ResourceNotFoundException(new FError(EFL0006_ID, EFL0006_MSG));
    }

    public LoginRes signIn(LoginReq loginReq) {
        final Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginReq.getUsername(), loginReq.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        final String jwt = jwtUtils.generateJwtToken(authentication);

        final AccountDetails userDetails = (AccountDetails) authentication.getPrincipal();
        final List<String> privileges = userDetails.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .map(itm -> CONST.PRIVILEGE_MAPPING.getOrDefault(itm, null))
                .collect(Collectors.toList());

        final String avatar = accountRepository.findById(userDetails.getId()).get().getAvatar();
        log.warn(userDetails.getUsername() + " login successful into system.");
        return new LoginRes(jwt,
                userDetails.getId(),
                userDetails.getUsername(),
                privileges, avatar);
    }

    @Transactional
    public String signUp(SignupReq signUp) {
        if (accountRepository.existsByUsername(signUp.getUsername())) {
            throw new BadCredentialsException(EFL0008_MSG);
        }
        final Set<String> strRoles = Optional.ofNullable(signUp.getRoles()).orElse(new HashSet<>());
        final Set<Role> roles = strRoles.stream().map(role -> roleRepository.findByName(role)
                        .orElseThrow(() -> new ResourceNotFoundException(new FError(EFL0004_ID, String.format(EFL0004_MSG, role)))))
                .collect(Collectors.toSet());
        try {
            final Account user = new Account(signUp.getUsername(), encoder.encode(signUp.getPassword()));
            Optional.ofNullable(signUp.getPhoneNumber()).ifPresent(user::setPhoneNumber);
            Optional.ofNullable(signUp.getFullName()).ifPresent(user::setFullName);
            user.setRoles(roles);
            final String id = accountRepository.save(user).getId();
            log.warn(signUp.getUsername() + " register successful into system.");
            return id;
        } catch (Exception e) {
            log.error("Error during registering Account ", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public PagingRes<AccountRes> find(Optional<String> name, Optional<String> phone, Optional<String> username,
                                      CustomerOrderBy orderBy, int ascDirection, int page, int size) {
        try {
            final List<AccountRes> accounts = accountRepository.find(name.orElse(null), phone.orElse(null), username.orElse(null),
                            orderBy.getDbColumn(), ascDirection, page, size)
                    .stream().map(itm -> {
                        final AccountRes dto = new AccountRes();
                        BeanUtils.copyProperties(itm, dto);
                        final Set<String> roles = itm.getRoles().stream().map(Role::getName).collect(Collectors.toSet());
                        dto.setRoles(roles);
                        return dto;
                    }).collect(Collectors.toList());
            final Long totalItems = accountRepository.count(name.orElse(null), phone.orElse(null), username.orElse(null));
            final long totalPages = totalItems % size == 0 ? (totalItems / size) : (totalItems / size + 1);
            return new PagingRes<>(totalItems, (int) totalPages, accounts, page + 1);
        } catch (Exception e) {
            log.error("Error during retrieving Account", e);
            return new PagingRes<>(0, 0, Collections.emptyList(), page + 1);
        }
    }

    @Transactional
    public String update(String id, UpdateAccountInfoReq account) {
        final Account entity = accountRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        try {
            BeanUtils.copyProperties(account, entity);
            entity.setNew(Boolean.FALSE);
            final Set<String> strRoles = Optional.ofNullable(account.getRoles()).orElse(new HashSet<>());
            final Set<Role> roles = strRoles.stream().map(role -> roleRepository.findByName(role)
                            .orElseThrow(() -> new ResourceNotFoundException(new FError(EFL0004_ID, String.format(EFL0004_MSG, role)))))
                    .collect(Collectors.toSet());
            entity.setRoles(roles);
            return accountRepository.save(entity).getId();
        } catch (Exception e) {
            log.error("Error during updating Account Info", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public boolean changePassword(String id, ChangePassReq req) {
        final Account account = accountRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        if (!Utils.getAccountId().equals(id) && !Utils.isAdmin()) {
            throw new AccessDeniedException("Access Denied");
        }
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(account.getUsername(), req.getOldPass()));
        try {
            account.setPassword(encoder.encode(req.getNewPass()));
            accountRepository.save(account);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("Error during changePassword", e);
            return Boolean.FALSE;
        }
    }

    @Transactional
    public boolean lockOrUnblockAccount(String id, boolean blocked) {
        final Account account = accountRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        try {
            account.setBlocked(blocked);
            accountRepository.save(account);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("Error during lockOrUnblockAccount", e);
            return Boolean.FALSE;
        }
    }

    public AccountRes mapping(Account entity) {
        final AccountRes dto = new AccountRes();
        BeanUtils.copyProperties(entity, dto);
        dto.setRoles(entity.getRoles().stream().map(Role::getName).collect(Collectors.toSet()));
        return dto;
    }
}
