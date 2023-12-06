package com.eflower.controller;

import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.Optional;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/reports")
public class ReportController {

    @Autowired
    private ReportService reportService;

    @GetMapping("/order-statistic")
    public ResponseEntity<?> orderStatistic() {
        return ResponseEntity.ok(new BaseResponseEntity(reportService.orderStatusStatistic()));
    }

    @GetMapping("/profits")
    public ResponseEntity<?> getProfit(
            @RequestParam(name = "accountId", required = false) Optional<String> accountId,
            @RequestParam(name = "from", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<LocalDate> from,
            @RequestParam(name = "to", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<LocalDate> to) {
        return ResponseEntity.ok(new BaseResponseEntity(reportService.getProfit(accountId, from, to)));
    }

    @GetMapping("/shipper-statistic")
    public ResponseEntity<?> shipperStatistic(@RequestParam(name = "accountId", required = false) Optional<String> accountId,
                                              @RequestParam(name = "from", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<LocalDate> from,
                                              @RequestParam(name = "to", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<LocalDate> to) {
        return ResponseEntity.ok(new BaseResponseEntity(reportService.shipperStatistic(accountId, from, to)));
    }
}
