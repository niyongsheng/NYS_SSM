package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.application.arcSoft.ArcSoftFaceRecognition;
import com.niyongsheng.application.utils.JwtUtil;
import com.niyongsheng.common.enums.NickeNameEnum;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuSMSService;
import com.niyongsheng.common.rongCloud.RongCloudService;
import com.niyongsheng.common.utils.EnumUtil;
import com.niyongsheng.common.utils.MD5Util;
import com.niyongsheng.common.utils.MathUtils;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.KeyValueRedisService;
import com.niyongsheng.persistence.service.UserRedisService;
import com.niyongsheng.persistence.service.UserService;
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

    // 验证码在redis中的key前缀（后面拼接手机号）
    private static final String ONCECODE_KEY = "onceCode_";

    @Autowired
    private UserService userService;

    @Autowired
    private UserRedisService userRedisService;

    @Autowired
    private KeyValueRedisService keyValueRedisService;

    @Autowired
    private QiniuSMSService qiniuSMSService;

    @Autowired
    private RongCloudService rongCloudService;

    @Autowired
    private ArcSoftFaceRecognition arcSoftFaceRecognition;

    @ResponseBody
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ApiOperation(value = "用户登录接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "phone", value = "手机号", required = true),
            @ApiImplicitParam(name = "password", value = "密码", required = true)
    })
    public ResponseDto<User> login(HttpServletRequest request,
                                   @RequestParam(value = "phone", required = true) String phone,
                                   @RequestParam(value = "password", required = true) String password
    ) throws ResponseException {
        // 1.参数封装
        User loginUser = new User();
        loginUser.setPhone(phone);
        loginUser.setPassword(MD5Util.crypt(password));

        // 2.数据库查询用户
        User user = userService.findUserByPhone(phone);

        // 3.JWT处理
        if (user != null) {
            if (!user.getPassword().equals(MD5Util.crypt(password))) {
                throw new ResponseException(ResponseStatusEnum.AUTH_PASSWORD_ERROR);
            }
            if (!user.getStatus()) {
                throw new ResponseException(ResponseStatusEnum.AUTH_STATUS_ERROR);
            }
            // 3.1封装JWT载荷对象
            HashMap<String, Object> cryptMap = new HashMap<>();
            cryptMap.put("id", user.getId());
            cryptMap.put("account", user.getAccount());
            cryptMap.put("profession", user.getProfession());
            cryptMap.put("status", user.getStatus());
            cryptMap.put("fellowship", user.getFellowship());

            // 3.2JWT加密生成token和时效（一个月）
            String token = JwtUtil.encryption(cryptMap, 60L * 60L * 1000L * 24L * 30L);

            // 3.3将token封装进User对象返回给客户端
            user.setToken(token);
        } else {
            throw new ResponseException(ResponseStatusEnum.AUTH_ACCOUNT_ERROR);
        }

        // 4.将token存入数据库
        userService.updateUser(user);

        // 5.将user存入redis缓存
        userRedisService.insertUser(user);

        // 6.返回登录的User对象
        return new ResponseDto(ResponseStatusEnum.AUTH_LOGIN_SUCESS, user);
    }

    @ResponseBody
    @RequestMapping(value = "/getOnceCode", method = RequestMethod.GET)
    @ApiOperation(value = "获取手机验证码接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "phone", value = "手机号", required = true),
    })
    public ResponseDto<String> phoneRegister(HttpServletRequest request,
                                      @RequestParam(value = "phone", required = true) String phone
    ) throws ResponseException {

        // 1.获取验证码
        String onceCode = qiniuSMSService.getOnceCode(phone);
        System.out.println(phone + "验证码：" + onceCode);

        // 2.Redis缓存3分钟过期,多次获取覆盖
        keyValueRedisService.set(ONCECODE_KEY + phone, onceCode, 60L * 3 * 1000L);

        // 3.返回验证码
        return new ResponseDto(ResponseStatusEnum.AUTH_ONCECODE_SUCESS, onceCode);
    }

    @ResponseBody
    @RequestMapping(value = "/phoneRegister", method = RequestMethod.POST)
    @ApiOperation(value = "手机号用户注册接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "phone", value = "手机号", required = true),
            @ApiImplicitParam(name = "onceCode", value = "验证码(6位)", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true),
            @ApiImplicitParam(name = "password", value = "密码", required = true)
    })
    public ResponseDto<User> phoneRegister(HttpServletRequest request,
                                           @RequestParam(value = "phone", required = true) String phone,
                                           @RequestParam(value = "onceCode", required = true) String onceCode,
                                           @RequestParam(value = "fellowship", required = true) Integer fellowship,
                                           @RequestParam(value = "password", required = true) String password
    ) throws ResponseException {

        // 1.验证码校验
        if (!onceCode.equals(keyValueRedisService.get(ONCECODE_KEY + phone))) {
            throw new ResponseException(ResponseStatusEnum.AUTH_ONCECODE_ERROR);
        }

        // 2.是否重复注册
        if (userService.findUserByPhone(phone) != null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_REPEAT_ERROR);
        }

        // 2.创建User对象并初始化
        User registerUser = new User();
        registerUser.setPhone(phone);
        registerUser.setPassword(MD5Util.crypt(password));
        registerUser.setFellowship(fellowship);
        registerUser.setStatus(true);
        registerUser.setProfession(1);
        String account = MathUtils.randomDigitNumber(7);
        while (true) {
            // account排重
            if (userService.findUserByAccount(account) == null) {
                break;
            }
            account = MathUtils.randomDigitNumber(7);
        }
        registerUser.setAccount(account);
        // TODO 从团契配置表读取
        String iconUrl = "http://zhaijidi.qmook.com/morentouxiang@3x.png";
        registerUser.setIcon(iconUrl);
        String nickName = EnumUtil.random(NickeNameEnum.class).toString();
        registerUser.setNickname(nickName);

        // 4.注册RongCloud
        registerUser.setImToken(rongCloudService.rongCloudGetToken(account, nickName, iconUrl));

        // 写入数据库
        userService.addUser(registerUser);

        return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS);
    }

    @ResponseBody
    @RequestMapping(value = "/logout", method = RequestMethod.DELETE)
    @ApiOperation(value = "用户登出接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
           /* @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),*/
    })
    public ResponseDto logout(HttpServletRequest request) throws ResponseException {

        String account = request.getHeader("Account");
        User user = userService.findUserByAccount(account);
        // 删除user的redis缓存
        userRedisService.del(user);

        return new ResponseDto(ResponseStatusEnum.AUTH_LOGOUT_SUCESS);
    }

    @ResponseBody
    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的用户信息并分页展示", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "跳转到的页数", required = true, paramType = "query"),
            @ApiImplicitParam(name = "pageSize", value = "每页展示的记录数", required = true, paramType = "query")
    })
    public ResponseDto<User> findAll(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                     @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
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





    private ResponseDto Register() {

        /*SimpleDateFormat format =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //设置格式
        String timeText=format.format(new Date().getTime());*/


        String time = "2018-1-9 12:17:22";
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // 置要读取的时间字符串格式
        Date date = null;
        try {
            date = format.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        // 转换为Date类
        Long timestamp = date.getTime();

        return new ResponseDto();
    }
}
