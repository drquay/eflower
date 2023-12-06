package com.eflower.controller.file;

import com.eflower.common.model.dto.response.BaseResponseEntity;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Objects;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
public class FileUploadController {

    private FileUploadResponse saveFile(String folder, MultipartFile multipartFile) throws IOException {
        final var baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        var resourcePath = "Files/Upload/";
        var fileName = RandomStringUtils.randomAlphanumeric(8) + "-" + StringUtils.cleanPath(Objects.requireNonNull(multipartFile.getOriginalFilename()));
        var size = multipartFile.getSize();

        // Save file.
        FileUploadUtil.saveFile(resourcePath + folder, fileName, multipartFile);

        var response = new FileUploadResponse();
        response.setFileName(fileName);
        response.setSize(size);
        response.setLink(baseUrl + "/files/" + folder + "/" + fileName);

        // return.
        return response;
    }

    @PostMapping("/uploadFile")
    public ResponseEntity<BaseResponseEntity> uploadFile(@RequestParam("file") MultipartFile multipartFile) throws IOException {
        // folder.
        var folder = LocalDateTime.now().toLocalDate().toString();
        // save file.
        var response = this.saveFile(folder, multipartFile);

        return ResponseEntity.ok(new BaseResponseEntity(response));
    }

    @PostMapping("/uploadAvatar")
    public ResponseEntity<BaseResponseEntity> uploadAvatar(@RequestParam("file") MultipartFile multipartFile) throws IOException {
        // folder.
        var folder = "avatars";
        // save file.
        var response = this.saveFile(folder, multipartFile);

        return ResponseEntity.ok(new BaseResponseEntity(response));
    }

}
