package com.eflower.common.model.common;

import com.eflower.common.model.dto.response.FError;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ConflictRequestException extends RuntimeException {

    private FError error;
}
