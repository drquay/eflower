package com.eflower.common.model.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BaseResponseEntity {

    private List<FError> errors;
    private Object data;

    public BaseResponseEntity(Object data) {
        this.data = data;
    }

    public BaseResponseEntity(List<FError> errors) {
        this.errors = errors;
    }
}
