package com.niyongsheng.manager.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.common.utils.MD5Util;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 查询所有
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping("/findAll")
    public String findAll(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
                          @RequestParam(value="pageSize",defaultValue="10")Integer pageSize,
                          Model model) {
        System.out.println("表现层：查询所有的用户信息...");
        // 1.设置页码和分页大小
        PageHelper.startPage(pageNum, pageSize);

        // 2.调用service的方法
        List<User> list = userService.findAll();

        // 3.包装分页对象
        PageInfo pageInfo = new PageInfo(list);

        model.addAttribute("pagingList", pageInfo);
        return "userList";
    }

    /**
     * 分页模糊搜索
     * @param pageNum 页码
     * @param pageSize 分页大小
     * @param nickname 昵称
     * @param account 账号
     * @param phone 手机号
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/findByFuzzySearch")
    public String findByFuzzySearch(@RequestParam(value="pageNum", defaultValue="1") Integer pageNum,
                                    @RequestParam(value="pageSize", defaultValue="10") Integer pageSize,
                                    @RequestParam(name="nickname") String nickname,
                                    @RequestParam(name="account") String account,
                                    @RequestParam(name="phone") String phone,
                                    Model model,
                                    HttpServletRequest request) {
        // 0.获取条件查询的参数
        Map<String, String[]> condition = request.getParameterMap();

        // 1.设置页码和分页大小
        PageHelper.startPage(pageNum, pageSize);

        // 2.调用service的方法
        List<User> list = userService.findByFuzzySearch(nickname, account, phone);

        // 3.包装分页对象
        PageInfo pageInfo = new PageInfo(list);

        // 4.数据装载
        model.addAttribute("pagingList", pageInfo);
        model.addAttribute("condition", condition);

        // 5.返回对应视图
        return "userList";
    }

    /**
     * 删除用户
     * @param id
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping("/deleteUserById")
    public String deleteUserById(@RequestParam(name="id") String id,
                                 @RequestParam(name="pageNum", defaultValue="1") Integer pageNum,
                                 @RequestParam(name="pageSize", defaultValue="10") Integer pageSize) {
        userService.deleteUser(id);
        String temp = "";
        return "redirect:findByFuzzySearch?nickname="+temp+"&account="+temp+"&phone="+temp+"&pageNum="+pageNum+"&pageSize="+pageSize+"";
    }

    /**
     * 批量删除用户
     * @param request
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping("/deleteSelected")
    public String deleteSelected(HttpServletRequest request,
                                 @RequestParam(name="pageNum", defaultValue="1") Integer pageNum,
                                 @RequestParam(name="pageSize", defaultValue="10") Integer pageSize) {
        String[] ids = request.getParameterValues("uid");
        userService.deleteSelectedUser(ids);
        String temp = "";
        return "redirect:findByFuzzySearch?nickname="+temp+"&account="+temp+"&phone="+temp+"&pageNum="+pageNum+"&pageSize="+pageSize+"";
    }

    /**
     * 登录
     * @param model
     * @param request
     * @param response
     * @param account
     * @param password
     * @param verifycode
     * @return
     */
    @RequestMapping("/login")
    public String login(Model model,
                        HttpServletRequest request,
                        HttpServletResponse response,
                        @RequestParam(name="account") String account,
                        @RequestParam(name="password") String password,
                        @RequestParam(name="verifycode") String verifycode,
                        @RequestParam(name="rememberMe", required = false) String rememberMe) {

        // 获取程序自动生成的验证码
        HttpSession session = request.getSession();
        String checkCode_session = (String) session.getAttribute("CHECKCODE_SERVER");
        System.out.println("CHECKCODE_SERVER:"+checkCode_session);
        // 删除session中存储的验证码（防止验证码被多次验证安全问题）
        session.removeAttribute("CHECKCODE_SERVER");

        // 先判断验证码是否正确
        if (checkCode_session != null && checkCode_session.equalsIgnoreCase(verifycode)) { // 忽略大小写比较字符串
            // 4.调用UserDao的login方法
            User user = userService.login(account, MD5Util.crypt(password));

            // 5.判断user
            if (user == null) {
                // 登录失败
                // 存储信息到request域
                model.addAttribute("login_msg","用户名或密码错误");
                // 转发
                return "login";
            } else {
                // 登录成功,判断是否记住登录状态
                if(rememberMe==null || rememberMe.length()==0){
                    rememberMe = "0";
                }
                if (rememberMe.equalsIgnoreCase("1") || rememberMe.equalsIgnoreCase("on")) {
                    // 创建Cookie保存用户信息，设定cookie失效时间
                    String loginInfo = account + "#" + password;
                    Cookie userCookie = new Cookie("loginInfo", loginInfo);
                    userCookie.setMaxAge(1 * 24 * 60 * 60); // 存活期为一天 1*24*60*60
                    userCookie.setPath("/");
                    response.addCookie(userCookie);
                    // 2天session时效
                    session.setMaxInactiveInterval(60 * 60 * 24 * 2);
                } else {
                    // 5分钟session时效
                    session.setMaxInactiveInterval(60 * 5);
                }
                // 存储数据（重定向是两次请求，将数据存储到session中）
                session.setAttribute("user", user);
                // 重定向
                String contextpath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                return "redirect:"+contextpath+"/index.jsp";
            }
        } else {
            // 存储信息（转发是一次请求，将数据存储到request域中）
            model.addAttribute("login_msg","验证码错误");
            // 转发
            return "login";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        // 清空session中的登录用户信息
        HttpSession session = request.getSession();
        session.removeAttribute("user");

        return "login";
    }


    @RequestMapping("/test")
    public String test() {

        return "amisAlert";
    }
}
