package com.eflower.service;

import com.eflower.common.Utils;
import com.eflower.common.model.db.Tracing;
import com.eflower.repository.TracingRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;

@Slf4j
@Service
public class TracingService {

    @Autowired
    private TracingRepository tracingRepository;

    @Value("${tracingRetentionPeriod}")
    private int tracingRetentionPeriod;

    @Async
    @Transactional
    public void addTracingData(Tracing entity) {
        try {
            tracingRepository.save(entity.normalize());
            if (tracingRetentionPeriod > 0) {
                cleanUpTracingData();
            }
        } catch (Exception e) {
            log.error("Error when adding tracing data ", e);
        }
    }

    private void cleanUpTracingData() {
        try {
            final LocalDateTime dateTime = LocalDateTime.now().minusDays(tracingRetentionPeriod);
            tracingRepository.deleteOutdatedRecordsBefore(dateTime);
        } catch (Exception e) {
            log.error("Error when clean up tracing data ", e);
        }
    }
}
