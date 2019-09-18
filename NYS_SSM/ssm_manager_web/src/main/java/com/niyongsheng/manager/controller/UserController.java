package com.niyongsheng.manager.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping("/findAll")
    public String findAll(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum, @RequestParam(value="pageSize",defaultValue="10")Integer pageSize, Model model) {
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

    @RequestMapping("/deleteUserById")
    public String deleteUserById(@RequestParam(name="id") String id) {


        return "userList";
    }
}
