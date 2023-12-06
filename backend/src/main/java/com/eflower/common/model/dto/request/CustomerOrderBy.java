package com.eflower.common.model.dto.request;

public enum CustomerOrderBy {

    createdOn("created_on"),
    name("full_name"),
    phone("phone_number"),
    address("address");

    private String dbColumn;

    CustomerOrderBy(String dbColumn) {
        this.dbColumn = dbColumn;
    }

    public String getDbColumn() {
        return dbColumn;
    }
}
