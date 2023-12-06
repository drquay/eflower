package com.eflower.common.model.dto.request;

public enum ShipperRouteOrderBy {

    createdOn("created_on"),
    numberOfKm("number_of_km");

    private String dbColumn;

    ShipperRouteOrderBy(String dbColumn) {
        this.dbColumn = dbColumn;
    }

    public String getDbColumn() {
        return dbColumn;
    }
}
