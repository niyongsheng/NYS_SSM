package com.niyongsheng.manager.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/error")
@Api(value = "错误信息")
public class ErrorController {

    @RequestMapping(value = "/", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "错误", notes = "")
    public String error(Model model) {

        return "error";
    }

    @RequestMapping(value = "/null", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "空指针错误", notes = "")
    public String errorNull(Model model) {

        return "errorNull";
    }


    @RequestMapping(value = "/errorUnauth", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "未授权错误", notes = "")
    public String errorUnauth(Model model) {

        return "errorUnauth";
    }

    @RequestMapping(value = "/404", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "404错误", notes = "")
    public String error404(Model model) {

        return "error404";
    }

    @RequestMapping(value = "/405", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "405错误", notes = "")
    public String error405(Model model) {

        return "error405";
    }

    @RequestMapping(value = "/500", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "500错误", notes = "")
    public String error500(Model model) {

        return "error500";
    }
}
