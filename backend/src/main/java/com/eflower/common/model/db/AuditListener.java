package com.eflower.common.model.db;


import com.eflower.common.Utils;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.PrePersist;
import java.time.LocalDateTime;
import java.util.UUID;

public class AuditListener<T extends BaseEntity> {

    @PrePersist
    public void prePersist(T entity) {
        if (StringUtils.isAllBlank(entity.getId())) {
            entity.setId(UUID.randomUUID().toString());
        }
//        entity.setCreatedOn(Utils.toUtc(LocalDateTime.now()));
        entity.setNew(Boolean.TRUE);
        entity.setCreatedOn(LocalDateTime.now());
        entity.setCreatedBy(Utils.getUsername());
    }
}
