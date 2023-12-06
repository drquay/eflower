package com.eflower.common.model.db;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "system_configurations")
public class SystemConfiguration extends BaseEntity {

    @Column(name = "key")
    private String key;

    @Column(name = "value")
    private String value;
}
