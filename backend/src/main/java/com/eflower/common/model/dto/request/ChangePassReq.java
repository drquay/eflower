package com.eflower.common.model.dto.request;

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
public class ChangePassReq {

    @NotBlank
    @Size(min = 3, max = 40)
    private String oldPass;

    @NotBlank
    @Size(min = 3, max = 40)
    private String newPass;
}
