package com.eflower.common.model.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class NotificationRes {

    private String id;
    private String messageId;
    private String message;
    private boolean read;
    private AccountRes from;
}
