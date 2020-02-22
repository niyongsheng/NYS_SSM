package com.niyongsheng.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/app")
public class AppInfoController {

    @RequestMapping("/download")
    public String userProtocol() {
        return "appdownload";
    }

}
