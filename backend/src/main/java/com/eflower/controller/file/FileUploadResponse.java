package com.eflower.controller.file;

import lombok.Data;

@Data
public class FileUploadResponse {
    private String fileName;
    private String link;
    private long size;
}
