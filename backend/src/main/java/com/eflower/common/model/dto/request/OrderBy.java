package com.eflower.common.model.dto.request;

public enum OrderBy {

    createdOn("created_on"),
    status("status"),
    code("code"),
    price("price"),
    deliveryDateTime("delivery_date"),
    source("source");

    private String dbColumn;

    OrderBy(String dbColumn) {
        this.dbColumn = dbColumn;
    }

    public String getDbColumn() {
        return dbColumn;
    }
}
