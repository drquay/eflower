package com.eflower.service;

import com.eflower.common.model.common.CONST;
import com.eflower.common.model.db.Attachment;
import com.eflower.common.model.db.Product;
import com.eflower.common.model.dto.request.ProductOrderBy;
import com.eflower.common.model.dto.request.ProductReq;
import com.eflower.common.model.dto.response.PagingRes;
import com.eflower.common.model.dto.response.ProductRes;
import com.eflower.repository.AttachmentRepository;
import com.eflower.repository.ProductRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private AttachmentRepository attachmentRepository;
    @Autowired
    private AttachmentService attachmentService;

    @Value("${productCodePrefix}")
    private String productCodePrefix;

    @Transactional
    public PagingRes<ProductRes> find(Optional<String> name, Optional<String> code,
                                      ProductOrderBy orderBy, int ascDirection, int page, int size) {
        try {
            final List<ProductRes> products = productRepository.find(name.orElse(null), code.orElse(null), orderBy.getDbColumn(), ascDirection, page, size)
                    .stream().map(this::mapping).collect(Collectors.toList());
            final Long totalItems = productRepository.count(name.orElse(null), code.orElse(null));
            final long totalPages = totalItems % size == 0 ? (totalItems / size) : (totalItems / size + 1);
            return new PagingRes<>(totalItems, (int) totalPages, products, page + 1);
        } catch (Exception e) {
            log.error("Error during retrieving Product", e);
            return new PagingRes<>(0, 0, Collections.emptyList(), page + 1);
        }
    }

    public boolean delete(String id) {
        try {
            productRepository.deleteById(id);
        } catch (Exception e) {
            log.error("Error during deleting Product", e);
            return false;
        }
        return true;
    }

    public ProductRes findById(String id) {
        final Product existedEntity = productRepository.findById(id).orElse(new Product());
        return mapping(existedEntity);
    }

    @Transactional
    public String update(String id, ProductReq prod) {
        final Product existedEntity = productRepository.findById(id).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        BeanUtils.copyProperties(prod, existedEntity);
        existedEntity.setNew(Boolean.FALSE);
        attachmentRepository.setParentIdToNull(id);
        productRepository.save(existedEntity);
        addAttachmentsIntoParent(id, prod.getImgIds());
        return id;
    }

    @Transactional
    public String create(ProductReq prod) {
        final Product entity = new Product();
        BeanUtils.copyProperties(prod, entity);
        entity.setNew(Boolean.TRUE);
        if (StringUtils.isEmpty(prod.getCode())) {
            entity.setCode(this.generatorCode());
        }
        final String id = productRepository.save(entity).getId();
        addAttachmentsIntoParent(id, prod.getImgIds());
        return id;
    }

    private ProductRes mapping(Product entity) {
        final ProductRes resp = new ProductRes();
        BeanUtils.copyProperties(entity, resp);
        resp.setImages(attachmentService.getAttachmentsByParentId(entity.getId()));
        return resp;
    }

    private void addAttachmentsIntoParent(String parentId, Set<String> attachmentIds) {
        Set<Attachment> attachments = new HashSet<>();
        if (CollectionUtils.isNotEmpty(attachmentIds)) {
            attachments = attachmentIds.stream()
                    .map(itm -> attachmentRepository.findById(itm).orElseThrow(CONST.RESOURCE_NOT_FOUND))
                    .collect(Collectors.toSet());
        }
        for (Attachment itm : attachments) {
            itm.setParentId(parentId);
            attachmentRepository.save(itm);
        }
    }

    private String generatorCode() {
        Optional<Product> existed;
        String code;
        do {
            code = productCodePrefix + RandomStringUtils.randomAlphanumeric(6);
            existed = productRepository.findByCode(code.toUpperCase());
        } while (existed.isPresent());
        return code.toUpperCase();
    }
}
