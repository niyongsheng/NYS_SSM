package com.niyongsheng.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/home")
public class HomeController {

    @RequestMapping("/infoBox")
    public String infoBox(Model model) {

        return "home";
    }
}
