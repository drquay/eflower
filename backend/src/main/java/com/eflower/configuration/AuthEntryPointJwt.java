package com.eflower.configuration;

import com.eflower.common.model.common.CONST;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.FError;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import static com.eflower.common.model.common.CONST.EFL0001_MSG;

@Slf4j
@Component
public class AuthEntryPointJwt implements AuthenticationEntryPoint {

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         AuthenticationException authException) throws IOException {

        log.error("Unauthorized error: {}", authException.getMessage());

        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        objectMapper.writeValue(response.getOutputStream(), buildError());
    }

    private BaseResponseEntity buildError() {
        final FError error = FError.builder()
                .id(CONST.EFL0001_ID).message(EFL0001_MSG)
                .build();
        return new BaseResponseEntity(List.of(error));
    }
}
