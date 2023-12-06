package com.eflower.service;

import com.eflower.common.Utils;
import com.eflower.common.model.db.ShipperRoute;
import com.eflower.common.model.db.ShipperRouteDetail;
import com.eflower.common.model.dto.request.ShipperRouteForUpdateReq;
import com.eflower.common.model.dto.request.ShipperRouteOrderBy;
import com.eflower.common.model.dto.response.PagingRes;
import com.eflower.common.model.dto.response.ShipperRouteDetailRes;
import com.eflower.common.model.dto.response.ShipperRouteRes;
import com.eflower.repository.ShipperRouteDetailRepository;
import com.eflower.repository.ShipperRouteRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ShipperRouteService {

    @Autowired
    private ShipperRouteRepository shipperRouteRepository;
    @Autowired
    private ShipperRouteDetailRepository shipperRouteDetailRepository;

    @Transactional
    public boolean delete(String id) {
        try {
            final ShipperRoute entity = shipperRouteRepository.findById(id).orElse(null);
            if (entity == null) {
                return false;
            }
            shipperRouteRepository.delete(entity);
            return true;
        } catch (Exception e) {
            log.error("Error during deleting ShipperRoute id" + id, e);
            return false;
        }
    }

    @Transactional
    public String update(String id, ShipperRouteForUpdateReq route) {
        final ShipperRoute entity = shipperRouteRepository.findById(id).orElse(null);
        if (entity == null) {
            return null;
        }
        entity.setBeginLatitude(route.getFromLatitude());
        entity.setBeginLongitude(route.getFromLongitude());
        entity.setEndLongitude(route.getToLongitude());
        entity.setEndLatitude(route.getToLatitude());
        entity.setNumberOfKm(route.getNumberOfKm());
        return shipperRouteRepository.save(entity).getId();
    }

    public ShipperRouteRes findById(String id) {
        final ShipperRoute route = shipperRouteRepository.findById(id).orElse(null);
        if (route == null) {
            return null;
        }
        final ShipperRouteRes res = this.mapping(route);
        res.setDetails(route.getDetails().stream().map(this::mapping).collect(Collectors.toList()));
        return res;
    }

    public ShipperRouteRes findByShipperId(String shipperId) {
        final ShipperRoute route = shipperRouteRepository.findByShipperId(shipperId);
        if (route == null) {
            return null;
        }
        final ShipperRouteRes res = this.mapping(route);
        res.setDetails(route.getDetails().stream().map(this::mapping).collect(Collectors.toList()));
        return res;
    }

    @Transactional
    public PagingRes<ShipperRouteRes> find(
            Optional<String> shipperId, Optional<LocalDate> from, Optional<LocalDate> to,
            ShipperRouteOrderBy orderBy, int ascDirection, int page, int size) {
        try {
            final LocalDateTime fromDate = from.map(LocalDate::atStartOfDay).orElse(LocalTime.MIN.atDate(LocalDate.now()));
            final LocalDateTime toDate = to.map(LocalTime.MAX::atDate).orElse(LocalTime.MAX.atDate(LocalDate.now()));
            final List<ShipperRoute> routes = shipperRouteRepository.find(shipperId.orElse(null), fromDate, toDate, orderBy.getDbColumn(), ascDirection, page, size);
            final Long totalItems = shipperRouteRepository.count(shipperId.orElse(null), fromDate, toDate);

            final List<ShipperRouteRes> content = new HashSet<>(routes).stream().map(this::mapping).collect(Collectors.toList());
            final long totalPages = totalItems % size == 0 ? (totalItems / size) : (totalItems / size + 1);
            return new PagingRes<>(totalItems, (int) totalPages, content, page + 1);
        } catch (Exception e) {
            log.error("Error during retrieving ShipperRoute", e);
            return new PagingRes<>(0, 0, Collections.emptyList(), page + 1);
        }
    }

    @Transactional
    public String startRouteShipping(String longitude, String latitude) {
        final ShipperRoute route = new ShipperRoute();
        route.setBeginLongitude(longitude);
        route.setBeginLatitude(latitude);
        route.setShipperId(Utils.getAccountId());
        return shipperRouteRepository.save(route).getId();
    }

    @Transactional
    public String endRouteShipping(String longitude, String latitude, Float numberOfKm) {
        final ShipperRoute route = findOrAddStartingRouteOfShipper();
        route.setEndLongitude(longitude);
        route.setEndLatitude(latitude);
        route.setNumberOfKm(numberOfKm);
        return shipperRouteRepository.save(route).getId();
    }

    @Transactional
    public String addRouteDetailShipping(String orderId, String toLongitude, String toLatitude) {
        final ShipperRoute route = findOrAddStartingRouteOfShipper();
        final ShipperRouteDetail detail = new ShipperRouteDetail();
        detail.setRoute(route);
        detail.setOrderId(orderId);
        detail.setToLongitude(toLongitude);
        detail.setToLatitude(toLatitude);
        return shipperRouteDetailRepository.save(detail).getId();
    }

    private ShipperRoute findOrAddStartingRouteOfShipper() {
        final String shipperId = Utils.getAccountId();
        final List<ShipperRoute> routes = shipperRouteRepository.findStartingRouteOfShipper(shipperId);
        if (CollectionUtils.isEmpty(routes)) {
            log.warn("Could not find starting route record of shipperId " + shipperId);
            final ShipperRoute entity = new ShipperRoute();
            entity.setBeginLongitude("0");
            entity.setBeginLatitude("0");
            entity.setShipperId(Utils.getAccountId());
            return shipperRouteRepository.save(entity);
        }
        if (routes.size() > 1) {
            for (int i = 1; i < routes.size(); i++) {
                final ShipperRoute itm = routes.get(i);
                itm.setNumberOfKm(0f);
                itm.setEndLatitude("0");
                itm.setEndLongitude("0");
                shipperRouteRepository.save(itm);
            }
        }
        return routes.get(0);
    }

    private ShipperRouteRes mapping(ShipperRoute entity) {
        final ShipperRouteRes res = new ShipperRouteRes();
        BeanUtils.copyProperties(entity, res);
        res.setDetails(entity.getDetails().stream().map(this::mapping).collect(Collectors.toList()));
        return res;
    }

    private ShipperRouteDetailRes mapping(ShipperRouteDetail entity) {
        final ShipperRouteDetailRes res = new ShipperRouteDetailRes();
        BeanUtils.copyProperties(entity, res);
        return res;
    }
}
