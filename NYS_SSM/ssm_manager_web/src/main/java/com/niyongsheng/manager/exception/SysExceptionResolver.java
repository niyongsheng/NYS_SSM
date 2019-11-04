package com.niyongsheng.manager.exception;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author niyongsheng.com
 * @version $
 * @des 异常处理器
 * @updateAuthor $
 * @updateDes
 */
public class SysExceptionResolver implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        // 获取异常对象
        SysException exception = null;
        if (e instanceof SysException) {
            exception = (SysException) e;
        } else {
            exception = new SysException(7001, "未知错误");
        }

        // 创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("errorMsg", exception.getExceptionMessage());
        modelAndView.addObject("errorCode", exception.getExceptionCode());
        modelAndView.setViewName("error");
        return modelAndView;
    }
}
