package com.eflower.service;

import com.eflower.repository.AttachmentRepository;
import com.eflower.repository.NotificationRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Slf4j
@Service
public class ScheduledJobService {

    @Autowired
    private AttachmentRepository attachmentRepository;
    @Autowired
    private NotificationRepository notificationRepository;

    @Transactional
    public void deleteDraftAttachment() {
        log.warn("Starting job to clean up draft attachment......");
        attachmentRepository.deleteRecordsHasParentIdIsNull();
        log.warn("Finished job to clean up draft attachment......");
    }

    @Transactional
    public void deleteDraftNotification() {
        log.warn("Starting job to clean up draft notification......");
        notificationRepository.deleteRecordsOverThan(LocalDateTime.now().plusDays(7));
        log.warn("Finished job to clean up draft notification......");
    }

    @Transactional
    public void createNotificationWhenOrderWillBeExpiredNext1Hour() {
        log.warn("Starting job to create notification when order will be expired next 1 hour......");
        log.warn("Finished job to create notification when order will be expired next 1 hour.....");
    }
}
