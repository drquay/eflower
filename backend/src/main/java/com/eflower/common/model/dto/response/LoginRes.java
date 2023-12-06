package com.eflower.common.model.dto.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class LoginRes {

    private String token;
    private String type = "Bearer";
    private String id;
    private String username;
    private String avatar;
    private List<String> privileges;

    public LoginRes(String token, String id, String username, List<String> privileges, String avatar) {
        this.username = username;
        this.token = token;
        this.id = id;
        this.privileges = privileges;
        this.avatar = avatar;
    }
}
