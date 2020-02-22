package com.niyongsheng.manager.exception;

import org.apache.shiro.ShiroException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author niyongsheng.com
 * @version $
 * @des 异常处理器
 * @updateAuthor $
 * @updateDes
 */
@ControllerAdvice
public class WebExceptionHandler {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 自定义web异常处理
     * @param exception
     * @return
     */
    @ExceptionHandler(WebException.class)
    @ResponseBody
    public ModelAndView handleWebException(WebException exception) {
        logger.error(exception.toString());
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("errorMsg", exception.getExceptionMessage());
        modelAndView.addObject("errorCode", exception.getExceptionCode());
        modelAndView.setViewName("error");
        return modelAndView;
    }

    /**
     * shiro异常处理
     * @param exception
     * @return
     */
    @ExceptionHandler(ShiroException.class)
    @ResponseBody
    public ModelAndView handle(ShiroException exception) {
        logger.error(exception.toString());
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("errorUnauth");
        return modelAndView;
    }
}
