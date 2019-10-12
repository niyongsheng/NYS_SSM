package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.application.arcSoft.ArcSoftFaceRecognition;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.core.MediaType;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
//@CrossOrigin(origins = "*",allowedHeaders = {"Access-Control-Allow-*"}) // 跨域
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ArcSoftFaceRecognition faceRecognition;

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
    public ResponseDto<User> findAll(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
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

        // 4.返回分页对象
        return new ResponseDto(ResponseStatusEnum.SUCCESS, pageInfo);
    }




    public ResponseDto Register() {

        /*SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //设置格式
        String timeText=format.format(new Date().getTime());*/


        String time="2018-1-9 12:17:22";
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // 置要读取的时间字符串格式
        Date date = null;
        try {
            date = format.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        // 转换为Date类
        Long timestamp=date.getTime();

        return new ResponseDto();
    }
}
