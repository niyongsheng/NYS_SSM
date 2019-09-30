package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.core.MediaType;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/user", produces = MediaType.APPLICATION_JSON)
@Api(value = "用户信息", produces = MediaType.APPLICATION_JSON)
//@CrossOrigin(origins = "*",allowedHeaders = {"Access-Control-Allow-*"})
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
    @ResponseBody
    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的用户信息并分页展示", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum",value = "跳转到的页数", required = true, paramType = "query"),
            @ApiImplicitParam(name = "pageSize",value = "每页展示的记录数", required = true, paramType = "query")
    })
    public ResponseDto findAll(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
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

        // 4.包装返回体
        Map<String, Object> respMap = new HashMap();
        respMap.put("auth", "NYS");
        respMap.put("list", pageInfo);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }


    public ResponseDto Register() {


        return new ResponseDto();
    }
}
