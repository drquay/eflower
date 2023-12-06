package com.eflower.common.model.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Size;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class UpdateAccountInfoReq {

    @Size(max = 500)
    private String fullName;

    @Size(max = 15)
    private String phoneNumber;

    private String avatar;

    private Set<String> roles;
}
