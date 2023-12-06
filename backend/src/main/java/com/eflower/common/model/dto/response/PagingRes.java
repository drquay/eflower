package com.eflower.common.model.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PagingRes<T> {

    private long totalItems;
    private int totalPages;
    private List<T> items;
    private int currentPage;
}
