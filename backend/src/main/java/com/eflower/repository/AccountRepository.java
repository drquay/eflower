package com.eflower.repository;

import com.eflower.common.model.db.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account, String> {

    Optional<Account> findByUsername(String username);
    Boolean existsByUsername(String username);

    @Procedure(procedureName = "FIND_ACCOUNT_FUNCTION")
    List<Account> find(String name, String phone, String username, String orderBy, int ascDirection, int pageNumber, int pageSize);

    @Procedure(procedureName = "COUNT_FIND_ACCOUNT_FUNCTION")
    Long count(String name, String phone, String username);
}
