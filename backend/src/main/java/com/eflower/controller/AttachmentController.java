package com.eflower.controller;

import com.eflower.common.model.dto.request.AttachmentReq;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.IdRes;
import com.eflower.service.AttachmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@Validated
@RequestMapping("/api/attachments")
public class AttachmentController {

    @Autowired
    private AttachmentService attachmentService;

    @PostMapping
    public ResponseEntity<?> create(@Valid @RequestBody AttachmentReq att) {
        return ResponseEntity.ok(new BaseResponseEntity(new IdRes(attachmentService.create(att))));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@Valid @NotBlank @Size(min = 36, max = 36) @PathVariable String id) {
        return attachmentService.delete(id) ?
                ResponseEntity.accepted().build() :
                ResponseEntity.internalServerError().build();
    }
}
