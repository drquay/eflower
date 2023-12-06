package com.eflower.common.model.dto.request;

public enum ProductOrderBy {

    name("name"), createdOn("created_on"), code("code");
    private String dbColumn;

    ProductOrderBy(String dbColumn) {
        this.dbColumn = dbColumn;
    }

    public String getDbColumn() {
        return dbColumn;
    }
}
