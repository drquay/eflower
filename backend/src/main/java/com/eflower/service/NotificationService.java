package com.eflower.service;

import com.eflower.common.model.common.CONST;
import com.eflower.common.model.db.Notification;
import com.eflower.repository.NotificationRepository;
import com.eflower.repository.OrderRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import static com.eflower.common.model.common.CONST.*;

@Slf4j
@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private AccountService accountService;

    @Transactional
    public String createShipperStoppedNotification() {
        try {
            final Notification notification = new Notification();
//            notification.setMessageId(SHIPPER_STOPPING_NOTIFICATION);
//            notification.setFromAccount(Utils.getAccountId());
            return notificationRepository.save(notification).getId();
        } catch (Exception e) {
            log.error("Error during creating ShipperStoppedNotification", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public String createShipperShutdownAppNotification() {
        try {
            final Notification notification = new Notification();
//            notification.setMessageId(SHIPPER_SHUTDOWN_APP_NOTIFICATION);
//            notification.setFromAccount(Utils.getAccountId());
            return notificationRepository.save(notification).getId();
        } catch (Exception e) {
            log.error("Error during creating ShipperStoppedNotification", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public String createFloristReceivedOrderNotification(String orderId) {
        orderRepository.findById(orderId).orElseThrow(CONST.RESOURCE_NOT_FOUND);
        try {
            final Notification notification = new Notification();
//            notification.setMessageId(FLORIST_RECEIVED_ORDER_NOTIFICATION);
            notification.setMessage(orderId);
//            notification.setFromAccount(Utils.getAccountId());
            return notificationRepository.save(notification).getId();
        } catch (Exception e) {
            log.error("Error during creating FloristReceivedOrderNotification", e);
            throw new RuntimeException(e);
        }
    }
}
