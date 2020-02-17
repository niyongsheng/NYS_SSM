package com.niyongsheng.common.exception;

import com.niyongsheng.common.model.ResponseDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.ConstraintViolationException;

/**
 * @author niyongsheng.com
 * @version $
 * @des RESTFUL异常统一处理类
 * @updateAuthor $
 * @updateDes
 */
@ControllerAdvice
public class ResponseExceptionHandler {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private ResourceBundleMessageSource messageSource;

    /**
     * 响应体异常处理
     * @param exception
     * @return
     */
    @ExceptionHandler(ResponseException.class)
    @ResponseBody
    public ResponseDto handlerResponseException(ResponseException exception) {
        logger.error(exception.toString());
        return new ResponseDto(exception.getResponseStatusEnum(), null);
    }

    /**
     * 参数合法性校验异常处理
     * @param exception
     * @return
     */
    @ExceptionHandler(ConstraintViolationException.class)
    @ResponseBody
    public ResponseDto handlerResponseException(ConstraintViolationException exception) {
        logger.error(exception.toString());
        // TODO 返回体包装还可以优化
//        ResponseStatusEnum responseStatusEnum = new ResponseStatusEnum(exception.getMessage());
        String replace = exception.getLocalizedMessage().replace(", ", "\n");
        int i = exception.hashCode();
        return new ResponseDto(replace);
    }
}
