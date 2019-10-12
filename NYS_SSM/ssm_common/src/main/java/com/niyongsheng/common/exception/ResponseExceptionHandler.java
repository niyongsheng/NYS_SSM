package com.niyongsheng.common.exception;

import com.niyongsheng.common.model.ResponseDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author niyongsheng.com
 * @version $
 * @des RESTFUL异常统一处理类
 * @updateAuthor $
 * @updateDes
 */
@ControllerAdvice
public class ResponseExceptionHandler {

    private static final Logger LOG = LoggerFactory.getLogger(ResponseExceptionHandler.class);

    /**
     * 响应异常处理
     * @param exception
     * @return
     */
    @ExceptionHandler(ResponseException.class)
    @ResponseBody
    public ResponseDto handlerResponseException(ResponseException exception) {
        LOG.error(exception.toString());
        return new ResponseDto(exception.getResponseStatusEnum(), null);
    }


}
