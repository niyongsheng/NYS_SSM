package com.niyongsheng.manager.controller;

import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

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

    @RequestMapping("/findAll")
    public String findAll(Model model) {
        System.out.println("表现层：查询所有的用户信息...");
        // 调用service的方法
        List<User> list = userService.findAll();
        System.out.println(list);
        model.addAttribute("list", list);
        return "userList";
    }

    @RequestMapping("/amisAlert")
    public String test() {
        return "amisAlert";
    }
}
