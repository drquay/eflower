package com.eflower.common.model.db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "notification")
public class Notification extends BaseEntity {

    @Column(name = "from_account_id")
    private String fromAccountId;

    @Column(name = "to_account_id")
    private String toAccountId;

    @Column(name = "to_role_id")
    private String toRoleId;

    @Enumerated(EnumType.STRING)
    @Column(name = "message_id")
    private NotificationMessageId messageId;

    @Column(name = "message")
    private String message;
}
