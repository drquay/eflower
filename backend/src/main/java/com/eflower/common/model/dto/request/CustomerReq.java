package com.eflower.common.model.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomerReq {

    @NotBlank
    @Size(min = 1, max = 500)
    private String fullName;

    @NotBlank
    @Size(min = 1, max = 50)
    private String phoneNumber;

    @NotBlank
    @Size(min = 1, max = 500)
    private String address;
}
