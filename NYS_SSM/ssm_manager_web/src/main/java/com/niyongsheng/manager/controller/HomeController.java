package com.niyongsheng.manager.controller;

import com.sun.javafx.logging.PulseLogger;
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

    @RequestMapping("/login")
    public String index() {

        return "login";
    }

    @RequestMapping("/infoBox")
    public String infoBox(Model model) {

        return "home";
    }

    @RequestMapping("/markdown")
    public String markdown(Model model) {

        return "MDEditor";
    }

    @RequestMapping("/activity")
    public String activity(Model model) {

        return "activity";
    }

    @RequestMapping("/test")
    public String test() {

        return "nullError";
    }
}
