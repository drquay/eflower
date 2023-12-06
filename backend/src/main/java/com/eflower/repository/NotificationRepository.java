package com.eflower.repository;

import com.eflower.common.model.db.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, String> {

    @Modifying(clearAutomatically = true)
    @Query(value = "DELETE FROM Notification WHERE createdOn >= :limitTime")
    void deleteRecordsOverThan(LocalDateTime limitTime);
}
