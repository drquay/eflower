package com.eflower.common.model.db;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;
import lombok.experimental.SuperBuilder;
import org.springframework.data.domain.Persistable;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;
import javax.persistence.Version;
import java.io.Serializable;
import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@SuperBuilder
@Getter
@Setter
@MappedSuperclass
@EntityListeners(value = AuditListener.class)
public abstract class BaseEntity implements Serializable, Persistable<String> {

    @Id
    @Column(name = "id", unique = true, nullable = false, updatable = false)
    protected String id;

    @Version
    protected Long version;

    @Column(name = "created_on", nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    protected LocalDateTime createdOn;

    @Column(name = "created_by", nullable = false)
    protected String createdBy;

    @Transient
    protected boolean isNew;

    @Override
    public boolean isNew() {
        return isNew;
    }
}
