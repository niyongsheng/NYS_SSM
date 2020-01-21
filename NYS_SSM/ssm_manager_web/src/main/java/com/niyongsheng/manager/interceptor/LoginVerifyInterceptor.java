package com.niyongsheng.manager.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author niyongsheng.com
 * @version $
 * @des 拦截器1
 * @updateAuthor $
 * @updateDes
 */
public class LoginVerifyInterceptor implements HandlerInterceptor {
    /**
     * 预处理，在controller方法执行前
     * @param request
     * @param response
     * @param handler
     * @return true放行，执行下一个拦截器，如果没有执行controller中的方法
     *         false拦截，执行拦截器方法
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取请求的RUi:去除http:localhost:8080这部分剩下的
        String uri = request.getRequestURI();
        // UTL:除了login.jsp是可以公开访问的，其他的URL都进行拦截控制
        if (uri.contains("/login.jsp") || uri.contains("/img/") || uri.contains("/css/") || uri.contains("/js/") || uri.contains("/fonts/") || uri.contains("/plugins/") || uri.contains("/file/") || uri.contains("/appDownload/")) {
            // 放行
            return true;
        }
        // 从session中获取user，验证用户是否登录
        Object user = request.getSession().getAttribute("user");
        if (user != null) {
            // 放行
            return true;
        } else {
            System.out.println("preHandle:登录拦截方法执行了");
            // 跳转登录
            request.setAttribute("login_msg", "您尚未登录，请登录");
            request.getRequestDispatcher("/user/logout").forward(request, response);
            return false;
        }
    }

     /**
     * 后处理：controller方法执行之后，success.jsp之前
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//        System.out.println("postHandle执行了111");
//        request.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(request, response);
    }

    /**
     * success.jsp之后执行
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//        System.out.println("afterCompletion执行了111");
    }
}
