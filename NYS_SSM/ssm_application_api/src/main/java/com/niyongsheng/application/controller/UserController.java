package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
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
import com.niyongsheng.persistence.domain.Fellowship;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.FellowshipService;
import com.niyongsheng.persistence.service.KeyValueRedisService;
import com.niyongsheng.persistence.service.UserRedisService;
import com.niyongsheng.persistence.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.ws.rs.core.MediaType;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
@Api(value = "用户信息", produces = MediaType.APPLICATION_JSON)
@RequestMapping(value = "/user", produces = MediaType.APPLICATION_JSON)
//@CrossOrigin(origins = "*",allowedHeaders = {"Access-Control-Allow-*"}) // 跨域
@Validated
public class UserController {

    /**
     * 验证码在redis中的key前缀（后面拼接手机号）
     */
    public static final String ONCECODE_KEY = "onceCode_";
    /* 默认用户头像 */
    public static final String USERICON_URL = "http://file.daocaodui.top/1575438242063_jpeg";

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
    private FellowshipService fellowshipService;

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
            user = userService.findUserByPhone(loginUser.getPhone());
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
                                           @NotBlank(message = "{NotBlank.fellowship}")
                                           @RequestParam(value = "fellowship", required = true) String fellowship,
                                           @Pattern(regexp = AppRegularConfig.REGEXP_PASSWORD, message = "{Pattern.user.password}")
                                           @RequestParam(value = "password", required = true) String password
    ) throws ResponseException {

        // 1.Redis中验证码一致性校验
        if (!onceCode.equals(keyValueRedisService.get(ONCECODE_KEY + phone))) {
            throw new ResponseException(ResponseStatusEnum.AUTH_ONCECODE_ERROR);
        }

        // 2.重复手机号注册校验
        if (userService.findUserByPhone(phone) != null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_REPEAT_ERROR);
        }

        // 3.创建User对象并初始化
        User registerUser = new User();
        registerUser.setPhone(phone);
        registerUser.setPassword(MD5Util.crypt(password));
        registerUser.setFellowship(Integer.valueOf(fellowship));
        registerUser.setStatus(true);
        registerUser.setProfession(1);
        // 生成account
        String account = MathUtils.randomDigitNumber(7);
        while (true) {
            // 自动生成的account排重检查
            if (userService.findUserByAccount(account) == null) {
                break;
            }
            account = MathUtils.randomDigitNumber(7);
        }
        registerUser.setAccount(account);
        // 默认头像
        String iconUrl = USERICON_URL;
        registerUser.setIcon(iconUrl);
        // 随机昵称
        String nickName = EnumUtil.random(NickeNameEnum.class).toString();
        registerUser.setNickname(nickName);
        // 3.1封装JWT载荷对象
        HashMap<String, Object> cryptMap = new HashMap<>();
        cryptMap.put("id", registerUser.getId());
        cryptMap.put("account", registerUser.getAccount());
        cryptMap.put("profession", registerUser.getProfession());
        cryptMap.put("status", registerUser.getStatus());
        cryptMap.put("fellowship", registerUser.getFellowship());
        // 3.2JWT加密生成token和时效（一个月）
        String token = JwtUtil.encryption(cryptMap, 60L * 60L * 1000L * 24L * 30L);
        // 3.3将token封装进User对象返回给客户端
        registerUser.setToken(token);

        // 4.注册RongCloud并设置注册用户的ImToken
        registerUser.setImToken(rongCloudService.rongCloudGetToken(account, nickName, iconUrl));

        // 5.写入数据库
        try {
            userService.addUser(registerUser);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 6.返回注册结果
        return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, registerUser);
    }

    @ResponseBody
    @RequestMapping(value = "/qqRegister", method = RequestMethod.POST)
    @ApiOperation(value = "QQ登录注册接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "qqUnionId", value = "uid", required = true),
            @ApiImplicitParam(name = "iconUrl", value = "QQ头像", required = true),
            @ApiImplicitParam(name = "nickname", value = "QQ昵称", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = false)
    })
    public ResponseDto<User> qqRegister(HttpServletRequest request,
                                        @NotBlank(message = "{NotBlank.unionId}")
                                        @RequestParam(value = "qqUnionId", required = true) String qqUnionId,
                                        @RequestParam(value = "iconUrl", required = true) String iconUrl,
                                        @RequestParam(value = "nickname", required = true) String nickname,
                                        @RequestParam(value = "fellowship", required = false) String fellowship
    ) throws ResponseException {

        // 1.查询QQ号是否已注册（登录流程）
        try {
            User qqUser = userService.findUserByQqOpenId(qqUnionId);
            if (qqUser != null) {
                if (!qqUser.getStatus()) {
                    throw new ResponseException(ResponseStatusEnum.AUTH_STATUS_ERROR);
                }
                return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, qqUser);
            }
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.创建User对象并初始化（注册流程）
        if (StringUtils.isEmpty(fellowship)) {
            throw new ResponseException(ResponseStatusEnum.AUTH_FELLOWSHIP_ERROR);
        }
        // 查询团契信息并判断其合法性
        Fellowship fell = fellowshipService.getBaseMapper().selectById(Integer.valueOf(fellowship));
        if (fell == null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_FELLOWSHIP_NONENTITY_ERROR);
        }

        User registerUser = new User();
        registerUser.setAppleUserId(fell.getFellowshipName());
        registerUser.setQqOpenid(qqUnionId);
        registerUser.setIcon(iconUrl);
        registerUser.setNickname(nickname);
        registerUser.setFellowship(Integer.valueOf(fellowship));
        registerUser.setStatus(true);
        registerUser.setProfession(1);
        // 生成account
        String account = MathUtils.randomDigitNumber(7);
        while (true) {
            // 自动生成的account排重检查
            if (userService.findUserByAccount(account) == null) {
                break;
            }
            account = MathUtils.randomDigitNumber(7);
        }
        registerUser.setAccount(account);
        // 2.1封装JWT载荷对象
        HashMap<String, Object> cryptMap = new HashMap<>();
        cryptMap.put("id", registerUser.getId());
        cryptMap.put("account", registerUser.getAccount());
        cryptMap.put("profession", registerUser.getProfession());
        cryptMap.put("status", registerUser.getStatus());
        cryptMap.put("fellowship", registerUser.getFellowship());
        // 2.2JWT加密生成token和时效（一个月）
        String token = JwtUtil.encryption(cryptMap, 60L * 60L * 1000L * 24L * 30L);
        // 2.3将token封装进User对象返回给客户端
        registerUser.setToken(token);

        // 3.注册RongCloud并设置注册用户的ImToken
        registerUser.setImToken(rongCloudService.rongCloudGetToken(account, nickname, iconUrl));

        // 4.写入数据库
        try {
            userService.addUser(registerUser);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 5.返回注册结果
        return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, registerUser);
    }

    @ResponseBody
    @RequestMapping(value = "/wxRegister", method = RequestMethod.POST)
    @ApiOperation(value = "微信登录注册接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "wxUnionId", value = "uid", required = true),
            @ApiImplicitParam(name = "iconUrl", value = "微信头像", required = true),
            @ApiImplicitParam(name = "nickname", value = "微信昵称", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = false)
    })
    public ResponseDto<User> wxRegister(HttpServletRequest request,
                                        @NotBlank(message = "{NotBlank.unionId}")
                                        @RequestParam(value = "wxUnionId", required = true) String wxUnionId,
                                        @RequestParam(value = "iconUrl", required = true) String iconUrl,
                                        @RequestParam(value = "nickname", required = true) String nickname,
                                        @RequestParam(value = "fellowship", required = false) String fellowship
    ) throws ResponseException {

        // 1.查询微信号是否已注册（登录流程）
        try {
            User wxUser = userService.findUserByWxOpenId(wxUnionId);
            if (wxUser != null) {
                if (!wxUser.getStatus()) {
                    throw new ResponseException(ResponseStatusEnum.AUTH_STATUS_ERROR);
                }
                return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, wxUser);
            }
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.创建User对象并初始化（注册流程）
        if (StringUtils.isEmpty(fellowship)) {
            throw new ResponseException(ResponseStatusEnum.AUTH_FELLOWSHIP_ERROR);
        }
        // 查询团契信息并判断其合法性
        Fellowship fell = fellowshipService.getBaseMapper().selectById(Integer.valueOf(fellowship));
        if (fell == null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_FELLOWSHIP_NONENTITY_ERROR);
        }

        User registerUser = new User();
        registerUser.setFellowshipName(fell.getFellowshipName());
        registerUser.setQqOpenid(wxUnionId);
        registerUser.setIcon(iconUrl);
        registerUser.setNickname(nickname);
        registerUser.setFellowship(Integer.valueOf(fellowship));
        registerUser.setStatus(true);
        registerUser.setProfession(1);
        // 生成account
        String account = MathUtils.randomDigitNumber(7);
        while (true) {
            // 自动生成的account排重检查
            if (userService.findUserByAccount(account) == null) {
                break;
            }
            account = MathUtils.randomDigitNumber(7);
        }
        registerUser.setAccount(account);
        // 2.1封装JWT载荷对象
        HashMap<String, Object> cryptMap = new HashMap<>();
        cryptMap.put("id", registerUser.getId());
        cryptMap.put("account", registerUser.getAccount());
        cryptMap.put("profession", registerUser.getProfession());
        cryptMap.put("status", registerUser.getStatus());
        cryptMap.put("fellowship", registerUser.getFellowship());
        // 2.2JWT加密生成token和时效（一个月）
        String token = JwtUtil.encryption(cryptMap, 60L * 60L * 1000L * 24L * 30L);
        // 2.3将token封装进User对象返回给客户端
        registerUser.setToken(token);

        // 3.注册RongCloud并设置注册用户的ImToken
        registerUser.setImToken(rongCloudService.rongCloudGetToken(account, nickname, iconUrl));

        // 4.写入数据库
        try {
            userService.addUser(registerUser);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 5.返回注册结果
        return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, registerUser);
    }

    @ResponseBody
    @RequestMapping(value = "/loginWithApple", method = RequestMethod.POST)
    @ApiOperation(value = "Apple登录注册接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "appleUserId", value = "Apple用户标识符", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = false)
    })
    public ResponseDto<User> loginWithApple(HttpServletRequest request,
                                            @NotBlank(message = "{NotBlank.unionId}")
                                            @RequestParam(value = "appleUserId", required = true) String appleUserId,
                                            @RequestParam(value = "fellowship", required = false) String fellowship
    ) throws ResponseException {

        // 1.查询微信号是否已注册（登录流程）
        try {
            User wxUser = userService.findUserByAppleId(appleUserId);
            if (wxUser != null) {
                if (!wxUser.getStatus()) {
                    throw new ResponseException(ResponseStatusEnum.AUTH_STATUS_ERROR);
                }
                return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, wxUser);
            }
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.创建User对象并初始化（注册流程）
        if (StringUtils.isEmpty(fellowship)) {
            throw new ResponseException(ResponseStatusEnum.AUTH_FELLOWSHIP_ERROR);
        }
        // 查询团契信息并判断其合法性
        Fellowship fell = fellowshipService.getBaseMapper().selectById(Integer.valueOf(fellowship));
        if (fell == null) {
            throw new ResponseException(ResponseStatusEnum.AUTH_FELLOWSHIP_NONENTITY_ERROR);
        }

        User registerUser = new User();
        registerUser.setFellowshipName(fell.getFellowshipName());
        registerUser.setAppleUserId(appleUserId);
        registerUser.setFellowship(Integer.valueOf(fellowship));
        registerUser.setStatus(true);
        registerUser.setProfession(1);
        // 生成account
        String account = MathUtils.randomDigitNumber(7);
        while (true) {
            // 自动生成的account排重检查
            if (userService.findUserByAccount(account) == null) {
                break;
            }
            account = MathUtils.randomDigitNumber(7);
        }
        registerUser.setAccount(account);
        // 默认头像
        String iconUrl = USERICON_URL;
        registerUser.setIcon(iconUrl);
        // 随机昵称
        String nickName = EnumUtil.random(NickeNameEnum.class).toString();
        registerUser.setNickname(nickName);
        // 2.1封装JWT载荷对象
        HashMap<String, Object> cryptMap = new HashMap<>();
        cryptMap.put("id", registerUser.getId());
        cryptMap.put("account", registerUser.getAccount());
        cryptMap.put("profession", registerUser.getProfession());
        cryptMap.put("status", registerUser.getStatus());
        cryptMap.put("fellowship", registerUser.getFellowship());
        // 2.2JWT加密生成token和时效（一个月）
        String token = JwtUtil.encryption(cryptMap, 60L * 60L * 1000L * 24L * 30L);
        // 2.3将token封装进User对象返回给客户端
        registerUser.setToken(token);

        // 3.注册RongCloud并设置注册用户的ImToken
        registerUser.setImToken(rongCloudService.rongCloudGetToken(account, nickName, iconUrl));

        // 4.写入数据库
        try {
            userService.addUser(registerUser);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 5.返回注册结果
        return new ResponseDto(ResponseStatusEnum.AUTH_REGISTER_SUCESS, registerUser);
    }

    @ResponseBody
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    @ApiOperation(value = "用户登出接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header")
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
            @ApiImplicitParam(name = "pageNum", value = "页码"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto<User> findAllUsers(HttpServletRequest request, Model model,
                                          @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                          @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                          @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                          @NotBlank(message = "{NotBlank.fellowship}")
                                          @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        List<User> list = null;
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = userService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship));
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = userService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship));
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
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
        // TODO 高并发情况下可以优先使用redis中的用户数据降低服务器负载（注意：数据修改同步刷新redis缓存）

        // 1.数据库查询用户
        User user = null;
        try {
            user = userService.findUserByAccount(account);
            // 数据校验
            if (user == null) {
                throw new ResponseException(ResponseStatusEnum.AUTH_UNEXISTENT_ERROR);
            }
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.返回查询对象
        return new ResponseDto(ResponseStatusEnum.SUCCESS, user);
    }

    @ResponseBody
    @RequestMapping(value = "/refreshUserInfo", method = RequestMethod.GET)
    @ApiOperation(value = "刷新用户信息接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account", value = "账号", required = true),
    })
    public ResponseDto<User> refreshUserInfo(HttpServletRequest request) throws ResponseException {
        // 1.数据库查询用户
        User user = null;
        try {
            user = userService.refreshUserInfo(request.getHeader("Account"));
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.返回查询对象
        return new ResponseDto(ResponseStatusEnum.SUCCESS, user);
    }

    @ResponseBody
    @RequestMapping(value = "/updateInfoForUser", method = RequestMethod.POST)
    @ApiOperation(value = "用户信息修改接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "icon", value = "头像URL"),
            @ApiImplicitParam(name = "truename", value = "姓名"),
            @ApiImplicitParam(name = "nickname", value = "昵称"),
            @ApiImplicitParam(name = "gender", value = "性别:unknown默认未知 male男 female女 secret保密"),
            @ApiImplicitParam(name = "birthday", value = "生日:yyyy-MM-dd"),
            @ApiImplicitParam(name = "phone", value = "手机"),
            @ApiImplicitParam(name = "password", value = "密码"),
            @ApiImplicitParam(name = "e_mail", value = "邮箱"),
            @ApiImplicitParam(name = "introduction", value = "简介"),
            @ApiImplicitParam(name = "address", value = "地址"),
            @ApiImplicitParam(name = "qqOpenid", value = "qqOpenid"),
            @ApiImplicitParam(name = "wcOpenid", value = "wcOpenid")
    })
    public ResponseDto<User> updateInfoForUser(HttpServletRequest request,
                                               @RequestParam(value = "icon", required = false) String icon,
                                               @RequestParam(value = "truename", required = false) String truename,
                                               @RequestParam(value = "nickname", required = false) String nickname,
                                               @RequestParam(value = "gender", required = false) String gender,
                                               @RequestParam(value = "birthday", required = false) String birthday,
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
        // 1.1日期字符串转date
        if (!StringUtils.isEmpty(birthday)) {
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateTime = LocalDate.parse(birthday, dateFormat);
            user.setBirthday(dateTime);
        }
        // 防止误操作
        if (password != null && !"".equals(password.trim())) {
            user.setPassword(MD5Util.crypt(password));
        }
        user.setEmail(e_mail);
        user.setIntroduction(introduction);
        user.setAddress(address);
        if (!StringUtils.isEmpty(qqOpenid)) {
            User userByQqOpenId = userService.findUserByQqOpenId(qqOpenid);
            if (userByQqOpenId != null) {
                throw new ResponseException(ResponseStatusEnum.AUTH_REPEAT_QQ_ERROR);
            } else {
                user.setQqOpenid(qqOpenid);
            }
        }
        if (!StringUtils.isEmpty(wcOpenid)) {
            User userByWxOpenId = userService.findUserByWxOpenId(wcOpenid);
            if (userByWxOpenId != null) {
                throw new ResponseException(ResponseStatusEnum.AUTH_REPEAT_WX_ERROR);
            } else {
                user.setWcOpenid(wcOpenid);
            }
        }

        // 2.更新用户DB数据
        try {
            userService.updateUser(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_UPDATE_ERROR);
        }

        // 3.数据库查询修改后的用户信息
        User newUser = null;
        try {
            newUser = userService.refreshUserInfo(account);
            // 数据校验
            if (newUser == null) {
                throw new ResponseException(ResponseStatusEnum.AUTH_UNEXISTENT_ERROR);
            }
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }


        // 4.redis缓存刷新
        try {
            userRedisService.insertUser(newUser);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.REDIS_INSERT_ERROR);
        }

        // 5.返回成功信息
        return new ResponseDto(ResponseStatusEnum.AUTH_UPDATE_SUCESS, newUser);
    }

    @ResponseBody
    @RequestMapping(value = "/resetUserPassword", method = RequestMethod.POST)
    @ApiOperation(value = "重置密码接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "phone", value = "手机", required = true),
            @ApiImplicitParam(name = "onceCode", value = "验证码(6位，3分钟内有效)", required = true),
            @ApiImplicitParam(name = "password", value = "密码", required = true),
            @ApiImplicitParam(name = "affirmPassword", value = "确认密码", required = true)
    })
    public ResponseDto resetUserPassword(HttpServletRequest request,
                                         @Pattern(regexp = AppRegularConfig.REGEXP_PHONE, message = "{Pattern.user.phone}")
                                         @RequestParam(value = "phone", required = true) String phone,
                                         @DecimalMin(value = "6", message = "{DecimalMin.user.onceCode}")
                                         @RequestParam(value = "onceCode", required = true) String onceCode,
                                         @Pattern(regexp = AppRegularConfig.REGEXP_PASSWORD, message = "{Pattern.user.password}")
                                         @RequestParam(value = "password", required = true) String password,
                                         @Pattern(regexp = AppRegularConfig.REGEXP_PASSWORD, message = "{Pattern.user.password}")
                                         @RequestParam(value = "affirmPassword", required = true) String affirmPassword
    ) throws ResponseException {
        // 1.Redis中验证码一致性校验
        if (!onceCode.equals(keyValueRedisService.get(ONCECODE_KEY + phone))) {
            throw new ResponseException(ResponseStatusEnum.AUTH_ONCECODE_ERROR);
        }

        // 2.两次密码是否一致
        if (!password.equals(affirmPassword)) {
            throw new ResponseException(ResponseStatusEnum.AUTH_2PASSWORD_ERROR);
        }

        // 3.修改用户密码(sql中已做非空判断)
        String account = request.getHeader("Account");
        User user = new User();
        user.setAccount(account);
        user.setPassword(password);

        // 4.更新用户DB数据
        try {
            userService.updateUser(user);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_UPDATE_ERROR);
        }

        // 6.返回成功信息
        return new ResponseDto(ResponseStatusEnum.SUCCESS);
    }

}
