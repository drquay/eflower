package com.eflower.common.model.dto.request;

public enum AccountOrderBy {

    createdOn("created_on"),
    name("full_name"),
    phone("phone_number"),
    username("username");

    private String dbColumn;

    AccountOrderBy(String dbColumn) {
        this.dbColumn = dbColumn;
    }

    public String getDbColumn() {
        return dbColumn;
    }
}
