package com.eflower.controller;

import com.eflower.common.model.common.BadRequestException;
import com.eflower.common.model.common.CONST;
import com.eflower.common.model.common.ConflictRequestException;
import com.eflower.common.model.common.ResourceNotFoundException;
import com.eflower.common.model.dto.response.BaseResponseEntity;
import com.eflower.common.model.dto.response.FError;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.validation.ConstraintViolationException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.eflower.common.model.common.CONST.*;

@Slf4j
@ControllerAdvice
public class ExceptionHandlerController {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<BaseResponseEntity> methodArgumentNotValidException(MethodArgumentNotValidException ex) {
        log.warn("ExceptionHandlerController-MethodArgumentNotValidException ", ex);
        final List<FError> errors = new LinkedList<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            final String fieldName = ((FieldError) error).getField();
            final String errorMessage = error.getDefaultMessage();
            errors.add(new FError(fieldName, errorMessage));
        });
        return new ResponseEntity<>(new BaseResponseEntity(errors), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<BaseResponseEntity> resourceNotFoundException(ResourceNotFoundException ex) {
        log.warn("ExceptionHandlerController-ResourceNotFoundException ", ex);
        Optional.ofNullable(ex.getError()).ifPresent(itm -> log.warn(itm.getMessage()));
        return new ResponseEntity<>(new BaseResponseEntity(List.of(ex.getError())), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(LockedException.class)
    public ResponseEntity<BaseResponseEntity> lockedException(LockedException ex) {
        log.warn("ExceptionHandlerController-LockedException ", ex);
        final FError error = new FError(EFL0003_ID, EFL0003_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseEntity<BaseResponseEntity> httpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException ex) {
        log.warn("ExceptionHandlerController-HttpRequestMethodNotSupportedException ", ex);
        final FError error = new FError(EFL0007_ID, EFL0007_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<BaseResponseEntity> badCredentialsException(BadCredentialsException ex) {
        log.warn("ExceptionHandlerController-BadCredentialsException ", ex);
        final FError error = new FError(EFL0005_ID, EFL0005_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<BaseResponseEntity> accessDeniedException(AccessDeniedException ex) {
        log.warn("ExceptionHandlerController-AccessDeniedException ", ex);
        final FError error = new FError(CONST.EFL0001_ID, CONST.EFL0001_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<BaseResponseEntity> badRequestException(BadRequestException ex) {
        log.warn("ExceptionHandlerController-BadRequestException ", ex);
        final FError error = new FError(CONST.EFL0009_ID, CONST.EFL0009_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ConflictRequestException.class)
    public ResponseEntity<BaseResponseEntity> conflictRequestException(ConflictRequestException ex) {
        log.warn("ExceptionHandlerController-ConflictRequestException ", ex);
        final FError error = new FError(CONST.EFL0010_ID, CONST.EFL0010_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<BaseResponseEntity> constraintViolationException(ConstraintViolationException ex) {
        log.warn("ExceptionHandlerController-ConstraintViolationException ", ex);
        final List<FError> errors = ex.getConstraintViolations().stream()
                .map(itm -> new FError(itm.getPropertyPath().toString(), itm.getMessage()))
                .collect(Collectors.toList());
        return new ResponseEntity<>(new BaseResponseEntity(errors), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Throwable.class)
    public ResponseEntity<BaseResponseEntity> globalException(Throwable ex) {
        log.error("ExceptionHandlerController-Throwable ", ex);
        final FError error = new FError(EFL0002_ID, EFL0002_MSG);
        return new ResponseEntity<>(new BaseResponseEntity(List.of(error)), HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
