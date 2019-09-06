package com.niyongsheng.manager.controller;

import com.niyongsheng.manager.exception.SysException;
import com.niyongsheng.persistence.service.AccountService;
import com.niyongsheng.persistence.domain.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @RequestMapping("/findAll")
    public String findAll(Model model) {
        System.out.println("表现层：查询所以的账户信息...");
        // 调用service的方法
        List<Account> list = accountService.findAll();
        model.addAttribute("list",list);
        return "list";
    }

    @RequestMapping("/save")
    public void save(Account account, HttpServletRequest request, HttpServletResponse response) throws SysException {
        System.out.println("表现层：保存账户信息...");
        // 调用service的方法
        accountService.saveAccount(account);
        try {
            // 跳转
            response.sendRedirect(request.getContextPath()+"/account/findAll");
        } catch (IOException e) {
            e.printStackTrace();
            throw new SysException(7002, "跳转失败");
        }

        return;
    }
}
