package com.niyongsheng.application.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.niyongsheng.application.utils.JwtUtil;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserRedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * @author niyongsheng.com
 * @version $
 * @des 拦截器1
 * @updateAuthor $
 * @updateDes
 */
@Component
public class JwtAuthInterceptor implements HandlerInterceptor {

    private static final String USER = "user_";

    @Autowired
    private UserRedisService userRedisService;

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
        response.setCharacterEncoding("utf-8");
        // 获取请求的RUi:去除http:localhost:8080这部分剩下的
        String uri = request.getRequestURI();
        if (uri.contains("/index.jsp") || uri.contains("/csrf")) {
            return true;
        }

        String token = request.getHeader("Token");
        String account = request.getHeader("Account");

        if(token != null && account != null) {
            User jwtUser = JwtUtil.decryption(token, User.class);
            if(jwtUser != null) {
                if (!jwtUser.getStatus()) {
                    ResponseDto responseDto = new ResponseDto(ResponseStatusEnum.AUTH_STATUS_ERROR, null);
                    responseMessage(response, response.getWriter(), responseDto);
                    return false;
                }
                if (jwtUser.getAccount().equals(account)) {
                    if (userRedisService.getUserById(String.valueOf(jwtUser.getId())) == null) {
                        ResponseDto responseDto = new ResponseDto(ResponseStatusEnum.AUTH_UNLOGIN_ERROR, null);
                        responseMessage(response, response.getWriter(), responseDto);
                        return false;
                    }
                    // 通过验证
                    return true;
                } else {
                    ResponseDto responseDto = new ResponseDto(ResponseStatusEnum.AUTH_VERIFY_ERROR, null);
                    responseMessage(response, response.getWriter(), responseDto);
                    return false;
                }
            } else {
                ResponseDto responseDto = new ResponseDto(ResponseStatusEnum.AUTH_EXPIRE_ERROR, null);
                responseMessage(response, response.getWriter(), responseDto);
                return false;
            }
        } else {
            ResponseDto responseDto = new ResponseDto(ResponseStatusEnum.AUTH_NULL_ERROR, null);
            responseMessage(response, response.getWriter(), responseDto);
            return false;
        }
    }

    /**
     * 请求不通过，返回错误信息给客户端
     * @param response
     * @param out
     * @param responseDto
     */
    private void responseMessage(HttpServletResponse response, PrintWriter out, ResponseDto responseDto) {
        response.setContentType("application/json; charset=utf-8");
        String json = JSONObject.toJSONString(responseDto);
        out.print(json);
        out.flush();
        out.close();
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
