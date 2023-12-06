package com.eflower.service;

import com.eflower.common.model.db.Role;
import com.eflower.repository.RoleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
public class RoleService {

    @Autowired
    private RoleRepository roleRepository;

    public Set<String> findAll() {
        return roleRepository.findAll().stream().map(Role::getName).collect(Collectors.toSet());
    }
}
