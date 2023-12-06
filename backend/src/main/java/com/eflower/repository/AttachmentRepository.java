package com.eflower.repository;

import com.eflower.common.model.db.Attachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AttachmentRepository extends JpaRepository<Attachment, String> {

    @Modifying(clearAutomatically = true)
    @Query(value = "UPDATE Attachment SET parentId = null WHERE parentId = :parentId")
    void setParentIdToNull(String parentId);

    @Modifying(clearAutomatically = true)
    @Query(value = "DELETE FROM Attachment WHERE parentId is null")
    void deleteRecordsHasParentIdIsNull();

    @Modifying(clearAutomatically = true)
    @Query(value = "DELETE FROM Attachment WHERE parentId = :parentId")
    void deleteByParentId(String parentId);

    List<Attachment> findByParentId(String parentId);
}
