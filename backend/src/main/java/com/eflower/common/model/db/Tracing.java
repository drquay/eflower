package com.eflower.common.model.db;

import com.eflower.common.Utils;
import com.vladmihalcea.hibernate.type.json.JsonBinaryType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@Entity
@Table(name = "tracing")
@TypeDef(name = "jsonb", typeClass = JsonBinaryType.class)
public class Tracing extends BaseEntity {

    @Column(name = "request_header", columnDefinition = "jsonb")
    @Type(type = "jsonb")
    private String requestHeader;

    @Column(name = "request_body", columnDefinition = "jsonb")
    @Type(type = "jsonb")
    private String requestBody;

    @Column(name = "service_response", columnDefinition = "jsonb")
    @Type(type = "jsonb")
    private String serviceResponse;

    public Tracing normalize() {
        if (StringUtils.isBlank(this.requestBody) || !Utils.isValidJson(this.requestBody)) {
            this.requestBody = null;
        }
        if (StringUtils.isBlank(this.requestHeader) || !Utils.isValidJson(this.requestHeader)) {
            this.requestHeader = null;
        }
        if (StringUtils.isBlank(this.serviceResponse) || !Utils.isValidJson(this.serviceResponse)) {
            this.serviceResponse = null;
        }
        return this;
    }
}
