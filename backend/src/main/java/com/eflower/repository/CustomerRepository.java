package com.eflower.repository;

import com.eflower.common.model.db.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, String> {

    @Procedure(procedureName = "FIND_CUSTOMER_FUNCTION")
    List<Customer> find(String name, String phone, String address, String orderBy, int ascDirection, int pageNumber, int pageSize);

    @Procedure(procedureName = "COUNT_FIND_CUSTOMER_FUNCTION")
    Long count(String name, String phone, String address);
}
