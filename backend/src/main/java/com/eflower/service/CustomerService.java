package com.eflower.service;

import com.eflower.common.model.common.CONST;
import com.eflower.common.model.common.ResourceNotFoundException;
import com.eflower.common.model.db.Customer;
import com.eflower.common.model.dto.request.CustomerOrderBy;
import com.eflower.common.model.dto.request.CustomerReq;
import com.eflower.common.model.dto.response.CustomerRes;
import com.eflower.common.model.dto.response.FError;
import com.eflower.common.model.dto.response.PagingRes;
import com.eflower.repository.CustomerRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.eflower.common.model.common.CONST.EFL0006_ID;
import static com.eflower.common.model.common.CONST.EFL0006_MSG;

@Slf4j
@Service
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    public CustomerRes findById(String id) {
        if (StringUtils.isNoneEmpty(id)) {
            final Customer buyer = customerRepository.findById(id).orElse(new Customer());
            final CustomerRes res = new CustomerRes();
            BeanUtils.copyProperties(buyer, res);
            return res;
        }
        throw new ResourceNotFoundException(new FError(EFL0006_ID, EFL0006_MSG));
    }

    @Transactional
    public String create(CustomerReq customer) {
        try {
            final Customer entity = new Customer();
            BeanUtils.copyProperties(customer, entity);
            entity.setNew(Boolean.TRUE);
            return customerRepository.save(entity).getId();
        } catch (Exception e) {
            log.error("Error during saving Customer ", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public String update(String id, CustomerReq customer) {
        final Customer entity = customerRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        try {
            BeanUtils.copyProperties(customer, entity);
            entity.setNew(Boolean.FALSE);
            return customerRepository.save(entity).getId();
        } catch (Exception e) {
            log.error("Error during updating Customer ", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public PagingRes<CustomerRes> find(Optional<String> name, Optional<String> phone, Optional<String> address,
                                       CustomerOrderBy orderBy, int ascDirection, int page, int size) {
        try {
            final List<CustomerRes> customers = customerRepository.find(name.orElse(null), phone.orElse(null), address.orElse(null),
                            orderBy.getDbColumn(), ascDirection, page, size)
                    .stream().map(itm -> {
                        final CustomerRes dto = new CustomerRes();
                        BeanUtils.copyProperties(itm, dto);
                        return dto;
                    }).collect(Collectors.toList());
            final Long totalItems = customerRepository.count(name.orElse(null), phone.orElse(null), address.orElse(null));
            final long totalPages = totalItems % size == 0 ? (totalItems / size) : (totalItems / size + 1);
            return new PagingRes<>(totalItems, (int) totalPages, customers, page + 1);
        } catch (Exception e) {
            log.error("Error during retrieving Customer", e);
            return new PagingRes<>(0, 0, Collections.emptyList(), page + 1);
        }
    }
}
