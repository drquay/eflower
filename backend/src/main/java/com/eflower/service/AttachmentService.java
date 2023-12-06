package com.eflower.service;

import com.eflower.common.model.common.CONST;
import com.eflower.common.model.common.ResourceNotFoundException;
import com.eflower.common.model.db.Account;
import com.eflower.common.model.db.Attachment;
import com.eflower.common.model.dto.request.AttachmentReq;
import com.eflower.common.model.dto.response.AccountRes;
import com.eflower.common.model.dto.response.AttachmentRes;
import com.eflower.common.model.dto.response.FError;
import com.eflower.repository.AccountRepository;
import com.eflower.repository.AttachmentRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import static com.eflower.common.model.common.CONST.EFL0006_ID;
import static com.eflower.common.model.common.CONST.EFL0006_MSG;

@Slf4j
@Service
public class AttachmentService {

    @Autowired
    private AttachmentRepository attachmentRepository;
    @Autowired
    private AccountRepository accountRepository;

    @Transactional
    public boolean deleteAttachmentsByParentId(String parentId) {
        try {
            attachmentRepository.setParentIdToNull(parentId);
        } catch (Exception e) {
            log.error("Error during delete attachments by parentId ", e);
            return false;
        }
        return true;
    }

    @Transactional
    public boolean addAttachmentsIntoParentId(String parentId, Set<String> attachmentIds) {
        if (CollectionUtils.isNotEmpty(attachmentIds)) {
            final Set<Attachment> attachments = attachmentIds.stream()
                    .map(itm -> attachmentRepository.findById(itm).orElseThrow(CONST.RESOURCE_NOT_FOUND))
                    .collect(Collectors.toSet());
            for (Attachment itm : attachments) {
                itm.setParentId(parentId);
                attachmentRepository.save(itm);
            }
            return Boolean.TRUE;
        }
        return Boolean.FALSE;
    }

    public Set<AttachmentRes> getAttachmentsByParentId(String parentId) {
        final List<Attachment> attachments = attachmentRepository.findByParentId(parentId);
        if (CollectionUtils.isNotEmpty(attachments)) {
            return attachments.stream().map(itm -> {
                final AttachmentRes attachmentRes = new AttachmentRes();
                BeanUtils.copyProperties(itm, attachmentRes);
                if (StringUtils.isNoneEmpty(itm.getCreatedBy()) && !"SYS".equals(itm.getCreatedBy())) {
                    final Optional<Account> account = accountRepository.findByUsername(itm.getCreatedBy());
                    attachmentRes.setUploadedBy(account.map(acc -> {
                        final AccountRes res = new AccountRes();
                        BeanUtils.copyProperties(acc, res);
                        return res;
                    }).orElse(null));
                }
                return attachmentRes;
            }).collect(Collectors.toSet());
        }
        return Collections.emptySet();
    }

    @Transactional
    public String create(AttachmentReq req) {
        final Attachment attachment = new Attachment();
        BeanUtils.copyProperties(req, attachment);
        attachment.setNew(Boolean.TRUE);
        return attachmentRepository.save(attachment).getId();
    }

    @Transactional
    public Boolean delete(String id) {
        attachmentRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException(new FError(EFL0006_ID, EFL0006_MSG)));
        try {
            attachmentRepository.deleteById(id);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("Error during deleting OrderAttachment ", e);
            return Boolean.FALSE;
        }
    }
}
