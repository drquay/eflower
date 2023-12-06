package com.eflower.common.model.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProductReq {

    private String code;
    private String description;
    private String referenceUrl;

    @NotEmpty
    private String name;

    @NotNull
    private BigDecimal price;

    @NotNull
    @NotEmpty
    private Set<String> imgIds;
}
