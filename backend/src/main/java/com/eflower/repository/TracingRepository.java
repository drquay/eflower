package com.eflower.repository;

import com.eflower.common.model.db.Tracing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface TracingRepository extends JpaRepository<Tracing, String> {

    @Modifying
    @Query("delete from Tracing where createdOn <= :dateTime")
    void deleteOutdatedRecordsBefore(LocalDateTime dateTime);
}
