package com.eflower.service;

import com.eflower.common.Utils;
import com.eflower.common.model.db.OrderSource;
import com.eflower.common.model.db.OrderStatus;
import com.eflower.common.model.db.ShipperRoute;
import com.eflower.common.model.dto.response.AccountRes;
import com.eflower.common.model.dto.response.OrderStatusStatisticRes;
import com.eflower.common.model.dto.response.ProfitReportRes;
import com.eflower.common.model.dto.response.ShippedInfoRes;
import com.eflower.common.model.dto.response.ShipperStatisticRes;
import com.eflower.repository.OrderRepository;
import com.eflower.repository.ShipperRouteRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ReportService {

    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private ShipperRouteRepository shipperRouteRepository;
    @Autowired
    private AccountService accountService;

    @Transactional
    public List<OrderStatusStatisticRes> orderStatusStatistic() {
        List<OrderStatusStatisticRes> actual;
        if (Utils.isAdmin() || Utils.isSaleAdmin()) {
            actual = orderRepository.getOrderStatusStatistic();
        } else if (Utils.isProvincialOrderManager()) {
            actual = orderRepository.getOrderStatusStatistic(List.of(OrderSource.OTHER));
        } else {
            actual = orderRepository.getOrderStatusStatistic(List.of(OrderSource.AGENT, OrderSource.HCM));
        }
        final Set<OrderStatus> actualStatus = actual.stream().map(OrderStatusStatisticRes::getStatus).collect(Collectors.toSet());
        Arrays.stream(OrderStatus.values()).filter(status -> !actualStatus.contains(status))
                .forEach(sts -> actual.add(new OrderStatusStatisticRes(sts, 0L)));
        return actual;
    }

    @Transactional
    public List<ProfitReportRes> getProfit(Optional<String> accountId,
                                           Optional<LocalDate> from,
                                           Optional<LocalDate> to) {
        final LocalDateTime fromDate = from.map(LocalDate::atStartOfDay).orElse(LocalTime.MIN.atDate(LocalDate.now()));
        final LocalDateTime toDate = to.map(LocalTime.MAX::atDate).orElse(LocalTime.MAX.atDate(LocalDate.now()));
        final List<List<String>> result = orderRepository.getProfitReport(accountId.orElse(""), fromDate, toDate);
        return result.stream()
                .map(itm -> itm.size() == 2 ? new ProfitReportRes(itm.get(0), itm.get(1)) : null)
                .filter(Objects::nonNull).collect(Collectors.toList());
    }

    @Transactional
    public List<ShipperStatisticRes> shipperStatistic(Optional<String> accountId,
                                                      Optional<LocalDate> from,
                                                      Optional<LocalDate> to) {
        final LocalDateTime fromDate = from.map(LocalDate::atStartOfDay).orElse(LocalTime.MIN.atDate(LocalDate.now()));
        final LocalDateTime toDate = to.map(LocalTime.MAX::atDate).orElse(LocalTime.MAX.atDate(LocalDate.now()));
        return accountId.map(s -> getReport(s, fromDate, toDate)).orElseGet(() -> getReport(fromDate, toDate));
    }

    private List<ShipperStatisticRes> getReport(String shipperId, LocalDateTime fromDate, LocalDateTime toDate) {
        final List<ShipperRoute> routes = shipperRouteRepository.findByFromDateAndToDateAndShipperId(shipperId, fromDate, toDate);
        final List<ShipperStatisticRes> result = new LinkedList<>();
        while (fromDate.isBefore(toDate) || fromDate.isEqual(toDate)) {
            result.add(getReportItemForAShipper(fromDate.toLocalDate(), routes));
            fromDate = fromDate.plusDays(1);
        }
        return result;
    }

    private List<ShipperStatisticRes> getReport(LocalDateTime fromDate, LocalDateTime toDate) {
        final List<ShipperRoute> routes = shipperRouteRepository.findByFromDateAndToDate(fromDate, toDate);
        final List<ShipperStatisticRes> result = new LinkedList<>();
        while (fromDate.isBefore(toDate) || fromDate.isEqual(toDate)) {
            result.add(getReportItem(fromDate.toLocalDate(), routes));
            fromDate = fromDate.plusDays(1);
        }
        return result;
    }

    private ShipperStatisticRes getReportItem(LocalDate reportDate, List<ShipperRoute> routes) {
        final Set<String> shipperIds = routes.stream().map(ShipperRoute::getShipperId)
                .filter(StringUtils::isNoneEmpty)
                .collect(Collectors.toSet());
        BigDecimal sum = BigDecimal.ZERO;
        final List<ShippedInfoRes> shippedInfo = new LinkedList<>();
        for (String shipperId : shipperIds) {
            for (ShipperRoute itm : routes) {
                final LocalDate date = itm.getCreatedOn().toLocalDate();
                if (reportDate.isEqual(date) && itm.getShipperId().equals(shipperId)) {
                    sum = sum.add(BigDecimal.valueOf(itm.getNumberOfKm()));
                }
            }
            final AccountRes shipper = accountService.findById(shipperId);
            shippedInfo.add(new ShippedInfoRes(shipper, sum));
        }
        return ShipperStatisticRes.builder()
                .reportDate(reportDate.format(DateTimeFormatter.ISO_DATE))
                .data(shippedInfo)
                .build();
    }

    private ShipperStatisticRes getReportItemForAShipper(LocalDate reportDate, List<ShipperRoute> routes) {
        BigDecimal sum = BigDecimal.ZERO;
        for (ShipperRoute itm : routes) {
            final LocalDate date = itm.getCreatedOn().toLocalDate();
            if (reportDate.isEqual(date)) {
                sum = sum.add(BigDecimal.valueOf(itm.getNumberOfKm()));
            }
        }
        return ShipperStatisticRes.builder()
                .reportDate(reportDate.format(DateTimeFormatter.ISO_DATE))
                .data(List.of(new ShippedInfoRes(null, sum)))
                .build();
    }
}
