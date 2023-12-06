package com.eflower.service;

import com.eflower.common.model.db.Tracing;
import com.eflower.common.model.common.CachedBodyHttpServletRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.util.ContentCachingResponseWrapper;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

@Slf4j
@Service
public class TracingServiceHelper {

    @Autowired
    private TracingService tracingService;
    @Autowired
    private ObjectMapper objectMapper;
    private final String TRACING_REQUEST_ATTRIBUTE = "TracingRequestAttribute";

    public Tracing getTracing() {
        final RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        return (Tracing) requestAttributes.getAttribute(TRACING_REQUEST_ATTRIBUTE, RequestAttributes.SCOPE_REQUEST);
    }

    public void setTracing(Tracing tracing) {
        final RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        requestAttributes.setAttribute(TRACING_REQUEST_ATTRIBUTE, tracing, RequestAttributes.SCOPE_REQUEST);
    }

    public void initTracingData(HttpServletRequest request) {
        Tracing tracing = getTracing();
        if (tracing == null) {
            Map<String, List<String>> headers = Collections.list(request.getHeaderNames()).stream()
                    .collect(Collectors.toMap(Function.identity(), h -> Collections.list(request.getHeaders(h))));
            tracing = Tracing.builder().requestHeader(toJsonString(headers)).build();
        }
        setTracing(tracing);
    }

    public void finaliseTracingData(CachedBodyHttpServletRequest requestWrapper,
                                    ContentCachingResponseWrapper responseWrapper) {
        try {
            final Tracing tracing = getTracing();
            final byte[] contentReq = requestWrapper.getInputStream().readAllBytes();
            final byte[] contentRes = responseWrapper.getContentAsByteArray();
            tracing.setServiceResponse(new String(contentRes, Charset.defaultCharset()));
            tracing.setRequestBody(new String(contentReq, Charset.defaultCharset()));
            tracing.setNew(Boolean.TRUE);
            tracingService.addTracingData(tracing);
        } catch (Exception e) {
            log.error("Error during finalise tracing data ", e);
        }
    }

    private String toJsonString(Object obj) {
        return Optional.ofNullable(obj).map(ob -> {
            try {
                return objectMapper.writeValueAsString(ob);
            } catch (Exception e) {
                log.error("Error during converting object to json ", e);
                return "{}";
            }
        }).orElse("{}");
    }
}
