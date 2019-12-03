package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.application.arcSoft.ArcSoftFaceRecognition;
import com.niyongsheng.application.utils.JwtUtil;
import com.niyongsheng.common.config.AppRegularConfig;
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

import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
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
@Validated
public class UserController {

    /** 验证码在redis中的key前缀（后面拼接手机号）*/
    public static final String ONCECODE_KEY = "onceCode_";
    /* 默认用户头像 */
    public static final String USERICON_URL = "http://pyd6p69m3.bkt.clouddn.com/config/icon/me_dcd.png";

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
                                   @Pattern(regexp = AppRegularConfig.REGEXP_PHONE, message = "{Pattern.user.phone}")
                                   @RequestParam(value = "phone", required = true) String phone,
                                   @Length(min = 6, max = 20, message = "密码长度6~20位")
                                   @RequestParam(value = "password", required = true) String password
    ) throws ResponseException {
        // 1.参数封装
        User loginUser = new User();
        loginUser.setPhone(phone);
        loginUser.setPassword(MD5Util.crypt(password));

        // 2.数据库查询用户
        User user = null;
        try {
            user = userService.findUserByPhone(phone);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

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
            throw new ResponseException(ResponseStatusEnum.AUTH_UNEXISTENT_ERROR);
        }

        // 4.将token回存到数据库用户表
        try {
            userService.updateUser(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_UPDATE_ERROR);
        }

        // 5.将user存入redis缓存
        try {
            userRedisService.insertUser(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.REDIS_INSERT_ERROR);
        }


        // 6.返回登录的User对象
        return new ResponseDto(ResponseStatusEnum.AUTH_LOGIN_SUCESS, user);
    }

    @ResponseBody
    @RequestMapping(value = "/getOnceCode", method = RequestMethod.GET)
    @ApiOperation(value = "获取手机验证码接口", notes = "*3分钟过期,多次获取覆盖", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "phone", value = "手机号", required = true),
    })
    public ResponseDto<String> getOnceCode(HttpServletRequest request,
                                           @Pattern(regexp = AppRegularConfig.REGEXP_PHONE, message = "{Pattern.user.phone}")
                                           @RequestParam(value = "phone", required = true) String phone
    ) throws ResponseException {

        // 1.获取验证码
        String onceCode = qiniuSMSService.getOnceCode(phone);
        System.out.println(phone + "验证码：" + onceCode);

        // 2.Redis缓存3分钟过期,多次获取覆盖
        try {
            keyValueRedisService.set(ONCECODE_KEY + phone, onceCode, 60L * 3 * 1000L);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.REDIS_INSERT_ERROR);
        }

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
            @ApiImplicitParam(name = "onceCode", value = "验证码(6位，3分钟内有效)", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true),
            @ApiImplicitParam(name = "password", value = "密码(6-21位的数字和字母组合)", required = true)
    })
    public ResponseDto<User> phoneRegister(HttpServletRequest request,
                                           @Pattern(regexp = AppRegularConfig.REGEXP_PHONE, message = "{Pattern.user.phone}")
                                           @RequestParam(value = "phone", required = true) String phone,
                                           @DecimalMin(value = "6", message = "{DecimalMin.user.onceCode}")
                                           @RequestParam(value = "onceCode", required = true) String onceCode,
                                           @NotBlank
                                           @RequestParam(value = "fellowship", required = true) Integer fellowship,
                                           @Pattern(regexp = AppRegularConfig.REGEXP_PASSWORD, message = "{Pattern.user.password}")
                                           @RequestParam(value = "password", required = true) String password
    ) throws ResponseException {

        // 1.Redis中验证码一致性校验
        if (!onceCode.equals(keyValueRedisService.get(ONCECODE_KEY + phone))) {
            throw new ResponseException(ResponseStatusEnum.AUTH_ONCECODE_ERROR);
        }

        // 2.重复注册校验
        if (userService.findUserByPhone(phone) != null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_REPEAT_ERROR);
        }

        // 3.创建User对象并初始化
        User registerUser = new User();
        registerUser.setPhone(phone);
        registerUser.setPassword(MD5Util.crypt(password));
        registerUser.setFellowship(fellowship);
        registerUser.setStatus(true);
        registerUser.setProfession(1);
        String account = MathUtils.randomDigitNumber(7);
        while (true) {
            // 自动生成的account排重检查
            if (userService.findUserByAccount(account) == null) {
                break;
            }
            account = MathUtils.randomDigitNumber(7);
        }
        registerUser.setAccount(account);
        String iconUrl = USERICON_URL;
        registerUser.setIcon(iconUrl);
        String nickName = EnumUtil.random(NickeNameEnum.class).toString();
        registerUser.setNickname(nickName);

        // 4.注册RongCloud并设置注册用户的ImToken
        registerUser.setImToken(rongCloudService.rongCloudGetToken(account, nickName, iconUrl));

        // 5.写入数据库
        try {
            userService.addUser(registerUser);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 6.返回注册结果
        return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS);
    }

    @ResponseBody
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    @ApiOperation(value = "用户登出接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
           /* @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),*/
    })
    public ResponseDto logout(HttpServletRequest request) throws ResponseException {

        String account = request.getHeader("Account");
        User user = null;
        try {
            user = userService.findUserByAccount(account);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }
        // 删除user的redis缓存
        try {
            userRedisService.del(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.REDIS_DELETE_ERROR);
        }

        return new ResponseDto(ResponseStatusEnum.AUTH_LOGOUT_SUCESS);
    }

    @ResponseBody
    @RequestMapping(value = "/findAllUsers", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的用户信息列表并分页展示", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "跳转到的页数"),
            @ApiImplicitParam(name = "pageSize", value = "每页展示的记录数"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", paramType = "boolean")
    })
    public ResponseDto<User> findAll(HttpServletRequest request, Model model,
                                     @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                     @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                     @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak
    ) throws ResponseException {

        // 1.调用service的方法
        List<User> list = null;
        try {
            list = userService.findAll();
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.是否分页
        if (isPageBreak) {
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize);

            // 2.2包装分页对象
            PageInfo pageInfo = new PageInfo(list);

            model.addAttribute("pagingList", pageInfo);
            return new ResponseDto(ResponseStatusEnum.SUCCESS, pageInfo);
        } else {
            model.addAttribute("pagingList", list);
            return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/providerInfoForUser", method = RequestMethod.GET)
    @ApiOperation(value = "用户信息提供者接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account", value = "账号", required = true),
    })
    public ResponseDto<User> providerInfoForUser(HttpServletRequest request,
                                                 @NotBlank()
                                                 @RequestParam(value = "account", required = true) String account
    ) throws ResponseException {

        // 1.数据库查询用户
        User user = null;
        try {
            user = userService.findUserByAccount(account);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.数据校验
        if (user == null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_UNEXISTENT_ERROR);
        }

        // 3.返回分页对象
        return new ResponseDto(ResponseStatusEnum.SUCCESS, user);
    }

    @ResponseBody
    @RequestMapping(value = "/updateInfoForUser", method = RequestMethod.POST)
    @ApiOperation(value = "用户信息修改接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "icon", value = "头像"),
            @ApiImplicitParam(name = "truename", value = "姓名"),
            @ApiImplicitParam(name = "nickname", value = "昵称"),
            @ApiImplicitParam(name = "gender", value = "性别"),
            @ApiImplicitParam(name = "phone", value = "手机"),
            @ApiImplicitParam(name = "password", value = "密码"),
            @ApiImplicitParam(name = "e_mail", value = "邮箱"),
            @ApiImplicitParam(name = "introduction", value = "简介"),
            @ApiImplicitParam(name = "address", value = "地址"),
            @ApiImplicitParam(name = "qqOpenid", value = "qqOpenid"),
            @ApiImplicitParam(name = "wcOpenid", value = "wcOpenid")
    })
    public  ResponseDto<User> updateInfoForUser(HttpServletRequest request,
                                                @RequestParam(value = "icon", required = false) String icon,
                                                @RequestParam(value = "truename", required = false) String truename,
                                                @RequestParam(value = "nickname", required = false) String nickname,
                                                @RequestParam(value = "gender", required = false) String gender,
                                                @Pattern(regexp = AppRegularConfig.REGEXP_PHONE, message = "{Pattern.user.phone}")
                                                @RequestParam(value = "phone", required = false) String phone,
                                                @Pattern(regexp = AppRegularConfig.REGEXP_PASSWORD, message = "{Pattern.user.password}")
                                                @RequestParam(value = "password", required = false) String password,
                                                @Email
                                                @RequestParam(value = "e_mail", required = false) String e_mail,
                                                @RequestParam(value = "introduction", required = false) String introduction,
                                                @RequestParam(value = "address", required = false) String address,
                                                @RequestParam(value = "qqOpenid", required = false) String qqOpenid,
                                                @RequestParam(value = "wcOpenid", required = false) String wcOpenid
    ) throws ResponseException {

        // 1.修改用户信息(sql中已做非空判断)
        String account = request.getHeader("Account");
        User user = new User();
        user.setAccount(account);
        user.setIcon(icon);
        user.setTruename(truename);
        user.setNickname(nickname);
        user.setGender(gender);
        user.setPhone(phone);
        if (password != null && !"".equals(password.trim())) {
            user.setPassword(MD5Util.crypt(password));
        }
        user.setEmail(e_mail);
        user.setIntroduction(introduction);
        user.setAddress(address);
        user.setQqOpenid(qqOpenid);
        user.setWcOpenid(wcOpenid);

        // 2.更新用户数据
        try {
            userService.updateUser(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_UPDATE_ERROR);
        }

        // 3.数据库查询修改后的用户信息
        try {
            user = userService.findUserByAccount(account);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 4.数据校验
        if (user == null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_UNEXISTENT_ERROR);
        }

        // 5.redis缓存刷新
        try {
            userRedisService.insertUser(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.REDIS_INSERT_ERROR);
        }

        // 6.返回成功信息
        return new ResponseDto(ResponseStatusEnum.AUTH_UPDATE_SUCESS, user);
    }

    private ResponseDto register() {

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
