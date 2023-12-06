package com.eflower.common.model.common;

import com.eflower.common.model.dto.response.FError;

import java.util.Map;
import java.util.function.Supplier;

public interface CONST {
    String EFL0001_ID = "EFL01";
    String EFL0001_MSG = "Unauthorized";
    String EFL0002_ID = "EFL02";
    String EFL0002_MSG = "Internal server error";
    String EFL0003_ID = "EFL03";
    String EFL0003_MSG = "User account is locked";
    String EFL0004_ID = "EFL04";
    String EFL0004_MSG = "%s role is not found";
    String EFL0005_ID = "EFL05";
    String EFL0005_MSG = "Bad credentials";
    String EFL0006_ID = "EFL06";
    String EFL0006_MSG = "Resource not found";
    String EFL0007_ID = "EFL07";
    String EFL0007_MSG = "Request method not supported";
    String EFL0008_ID = "EFL08";
    String EFL0008_MSG = "Username is already taken";
    String EFL0009_ID = "EFL09";
    String EFL0009_MSG = "Bad request";
    String EFL0010_ID = "EFL10";
    String EFL0010_MSG = "Conflict request";
    Supplier<ResourceNotFoundException> RESOURCE_NOT_FOUND = () -> new ResourceNotFoundException(new FError(EFL0006_ID, EFL0006_MSG));

    Map<String, String> PRIVILEGE_MAPPING = Map.of(
            "PRI_ADMIN", "ADMINISTRATOR_PRIVILEGE",
            "PRI_SALE", "SALE_PRIVILEGE",
            "PRI_SALE_ADMIN", "SALE_ADMIN_PRIVILEGE",
            "PRI_DISPATCHERS", "DISPATCHERS_PRIVILEGE",
            "PRI_FLORIST", "FLORIST_PRIVILEGE",
            "PRI_PROVINCIAL_ORDER_MANAGER", "PROVINCIAL_ORDER_MANAGER_PRIVILEGE",
            "PRI_SHIPPER", "SHIPPER_PRIVILEGE");
}
