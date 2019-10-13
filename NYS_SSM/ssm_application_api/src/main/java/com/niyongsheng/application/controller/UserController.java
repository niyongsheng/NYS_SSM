package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.application.arcSoft.ArcSoftFaceRecognition;
import com.niyongsheng.application.utils.JwtUtil;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.utils.MD5Util;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import com.sun.xml.internal.bind.v2.TODO;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.MediaType;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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


    @ResponseBody
    @RequestMapping(value="/login", method = RequestMethod.POST)
    @ApiOperation(value = "用户登录接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "phone",value = "手机号", required = true),
            @ApiImplicitParam(name = "password",value = "密码", required = true)
    })
    public ResponseDto<User> login(HttpServletRequest request,
                              @RequestParam(value = "phone", required = true) String phone,
                              @RequestParam(value = "password", required = true) String password
    ) throws ResponseException {
        // 1.参数封装
        User loginUser = new User();
        loginUser.setPhone(phone);
        loginUser.setPassword(MD5Util.crypt(password));

        // 2.先到数据库验证
        User user = userService.findUserByPhone(phone);

        // 3.JWT处理
        if(user != null) {
            if (!user.getPassword().equals(MD5Util.crypt(password))) {
                throw new ResponseException(ResponseStatusEnum.AUTH_PASSWORD_ERROR);
            }
            // 3.1封装加密对象
            HashMap<String, Object> cryptMap = new HashMap<>();
            cryptMap.put("id", user.getId());
            cryptMap.put("profession", user.getProfession());
            cryptMap.put("status", user.getStatus());
            cryptMap.put("fellowship", user.getFellowship());

            // 3.2JWT加密生成token
            String token = JwtUtil.encryption(cryptMap, 60L* 1000L* 30L);

            // 3.3将token封装进User对象返回给客户端
            user.setToken(token);

            // 3.4将token存入数据库

        } else {
            throw new ResponseException(ResponseStatusEnum.AUTH_ACCOUNT_ERROR);
        }

        return new ResponseDto(ResponseStatusEnum.SUCCESS, user);
    }



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
