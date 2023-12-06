package com.eflower.repository;

import com.eflower.common.model.db.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, String> {

    Optional<Product> findByCode(String code);

    @Procedure(procedureName = "FIND_PRODUCT_FUNCTION")
    List<Product> find(String name, String code, String orderBy, int ascDirection, int pageNumber, int pageSize);

    @Procedure(procedureName = "COUNT_FIND_PRODUCT_FUNCTION")
    Long count(String name, String code);
}
