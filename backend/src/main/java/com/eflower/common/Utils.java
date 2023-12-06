package com.eflower.common;

import com.eflower.common.model.common.AccountDetails;
import com.eflower.common.model.db.BaseEntity;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.owasp.esapi.ESAPI;
import org.owasp.esapi.errors.IntrusionException;
import org.owasp.esapi.errors.ValidationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.io.IOException;
import java.util.Optional;

@Slf4j
public class Utils {

    public static boolean isEntityBelongCurrentUser(BaseEntity entity) {
        final String createdUsername = entity.getCreatedBy();
        final String deletedUsername = Utils.getUsername();
        return createdUsername.equals(deletedUsername);
    }

    public static boolean isEntityBelongOrder(Optional<? extends BaseEntity> findEntityByOrderId, BaseEntity entity) {
        return findEntityByOrderId.isPresent() && findEntityByOrderId.get().getId().equals(entity.getId());
    }

    public static boolean isValidJson(String jsonInString) {
        try {
            final ObjectMapper mapper = new ObjectMapper();
            mapper.readTree(jsonInString);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    private static boolean hasRole(String privilege) {
        try {
            final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            final AccountDetails userDetails = (AccountDetails) authentication.getPrincipal();
            return userDetails.getAuthorities().stream().anyMatch(itm -> privilege.equals(itm.getAuthority()));
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isFlorist() {
        try {
            return hasRole("PRI_FLORIST");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isShipper() {
        try {
            return hasRole("PRI_SHIPPER");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isAdmin() {
        try {
            return hasRole("PRI_ADMIN");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isProvincialOrderManager() {
        try {
            return hasRole("PRI_PROVINCIAL_ORDER_MANAGER");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isSaleAdmin() {
        try {
            return hasRole("PRI_SALE_ADMIN");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isSale() {
        try {
            return hasRole("PRI_SALE");
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isDispatchers() {
        try {
            return hasRole("PRI_DISPATCHERS");
        } catch (Exception e) {
            return false;
        }
    }

    public static String getAccountId() {
        try {
            final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            final AccountDetails userDetails = (AccountDetails) authentication.getPrincipal();
            return userDetails.getId();
        } catch (Exception e) {
            return "SYS_ID";
        }
    }

    public static String getUsername() {
        try {
            final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            final AccountDetails userDetails = (AccountDetails) authentication.getPrincipal();
            return userDetails.getUsername();
        } catch (Exception e) {
            return "SYS";
        }
    }

    private static boolean isValid(String stringToScan) {
        try {
            ESAPI.validator().getValidInput("StringToScan", stringToScan, "SafeString", 30, false, true);
            return true;
        } catch (IntrusionException | ValidationException e) {
            log.warn("Invalid input : " + e.getMessage());
        }
        return false;
    }

//    public static LocalDateTime toZone(LocalDateTime time, ZoneId fromZone, ZoneId toZone) {
//        final ZonedDateTime zonedDateTime = time.atZone(fromZone);
//        final ZonedDateTime convertDateTime = zonedDateTime.withZoneSameInstant(toZone);
//        return convertDateTime.toLocalDateTime();
//    }

//    public static LocalDateTime toUtc(LocalDateTime time, ZoneId fromZone) {
//        return Utils.toZone(time, fromZone, ZoneOffset.UTC);
//    }
//
//    public static LocalDateTime toUtc(LocalDateTime time) {
//        return Utils.toUtc(time, ZoneId.systemDefault());
//    }
}
