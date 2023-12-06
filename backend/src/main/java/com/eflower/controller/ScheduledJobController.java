package com.eflower.controller;

import com.eflower.service.ScheduledJobService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ScheduledJobController {

    @Autowired
    private ScheduledJobService scheduledJobService;

    @Scheduled(fixedDelay = 3600000)
    public void ScheduledJobController() {
        deleteDraftNotification();
        deleteDraftAttachment();
        createNotificationWhenOrderWillBeExpiredNext1Hour();
    }

    @Async
    public void deleteDraftAttachment() {
        scheduledJobService.deleteDraftAttachment();
    }

    @Async
    public void deleteDraftNotification() {
        scheduledJobService.deleteDraftNotification();
    }

    @Async
    public void createNotificationWhenOrderWillBeExpiredNext1Hour() {
        scheduledJobService.createNotificationWhenOrderWillBeExpiredNext1Hour();
    }
}
