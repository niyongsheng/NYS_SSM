package com.niyongsheng.manager.controller;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/jsonp")
@Api(value = "跨域传输")
@Validated
public class JsonpController {

    @Autowired
    private UserService userService;

    @RequestMapping("/jsonpTest")
    @RequiresRoles(value={"superadmin","admin"},logical= Logical.OR)
    public String test() {
        return "jsonp";
    }

    /**
     * 跨域传送
     * @param callback
     * @param userId
     * @return
     */
    @RequestMapping(value = "/jsonpInfo", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "jsonp测试接口", notes = "参数描述")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "callback", value = "回调函数", required = true),
            @ApiImplicitParam(name = "userId", value = "用户id", required = true)
    })
    public Object jsonpInfo(@RequestParam(value="callback", required = true) String callback,
                            @RequestParam(value="userId", required = true) Integer userId) {
        User user = userService.findUserById(String.valueOf(userId));
        JSONPObject jsonpObject = new JSONPObject(callback, user) ;
        return jsonpObject;
    }

}
