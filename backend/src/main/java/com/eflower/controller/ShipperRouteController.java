package com.eflower.controller;

import com.eflower.common.model.dto.request.RouteType;
import com.eflower.common.model.dto.request.ShipperRouteForUpdateReq;
import com.eflower.common.model.dto.request.ShipperRouteOrderBy;
import com.eflower.common.model.dto.request.ShipperRouteReq;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.ShipperRouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.Optional;

@Validated
@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/shipper-routes")
public class ShipperRouteController {

    @Autowired
    private ShipperRouteService shipperRouteService;

    @GetMapping
    public ResponseEntity<?> find(
            @RequestParam(name = "shipperId", required = false) Optional<String> shipperId,
            @RequestParam(name = "from", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<LocalDate> from,
            @RequestParam(name = "to", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<LocalDate> to,
            @Valid @Min(0) @RequestParam(defaultValue = "0") int page,
            @Valid @Min(0) @Max(1000) @RequestParam(defaultValue = "50") int size,
            @RequestParam(name = "sortBy", required = false, defaultValue = "createdOn") ShipperRouteOrderBy orderBy,
            @RequestParam(name = "ascDirection", required = false, defaultValue = "0") int ascDirection) {

        return ResponseEntity.ok(new BaseResponseEntity(shipperRouteService.find(shipperId, from, to, orderBy, ascDirection, page, size)));
    }

    @GetMapping("/shippers/{id}")
    public ResponseEntity<?> findByShipperId(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(new BaseResponseEntity(shipperRouteService.findByShipperId(id)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(new BaseResponseEntity(shipperRouteService.findById(id)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id,
                                    @Valid @RequestBody ShipperRouteForUpdateReq route) {
        return ResponseEntity.ok(new BaseResponseEntity(shipperRouteService.update(id, route)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return ResponseEntity.ok(new BaseResponseEntity(shipperRouteService.delete(id)));
    }

    @PostMapping
    public ResponseEntity<?> beginOrEndRoute(@Valid @RequestBody ShipperRouteReq route) {
        if (route.getType() == RouteType.BEGIN) {
            return ResponseEntity.ok(new BaseResponseEntity(new IdRes(shipperRouteService.startRouteShipping(route.getToLongitude(), route.getToLatitude()))));
        }
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(shipperRouteService.endRouteShipping(route.getToLongitude(), route.getToLatitude(), route.getNumberOfKm()))));
    }
}
