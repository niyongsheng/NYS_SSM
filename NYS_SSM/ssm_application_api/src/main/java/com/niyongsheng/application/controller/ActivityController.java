package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import com.niyongsheng.common.rongCloud.RongCloudService;
import com.niyongsheng.common.utils.MathUtils;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.domain.User_Activity;
import com.niyongsheng.persistence.service.ActivityService;
import com.niyongsheng.persistence.service.GroupService;
import com.niyongsheng.persistence.service.User_ActivityService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.core.MediaType;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * 1.活动包含群组;
 * 2.活动成员即群组成员;
 * 3.活动结束对应群组/成员关系清空;
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/activity", produces = MediaType.APPLICATION_JSON)
@Api(value = "活动", produces = MediaType.APPLICATION_JSON)
@Validated
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @Autowired
    private GroupService groupService;

    @Autowired
    private User_ActivityService user_activityService;

    @Autowired
    private QiniuUploadFileService qiniuUploadFileService;

    @Autowired
    private RongCloudService rongCloudService;


    @ResponseBody
    @RequestMapping(value = "/selectActivityList", method = RequestMethod.GET)
    @ApiOperation(value = "查询活动列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Activity> selectActivityList(HttpServletRequest request, Model model,
                                                    @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                    @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                    @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                    @NotBlank
                                                    @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Activity> list = null;
        Integer fel = Integer.valueOf(fellowship);
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = activityService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = activityService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectClockActivityList", method = RequestMethod.GET)
    @ApiOperation(value = "查询打卡活动列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Activity> selectClockActivityList(HttpServletRequest request, Model model,
                                                    @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                    @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                    @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                    @NotBlank
                                                    @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Activity> list = null;
        Integer fel = Integer.valueOf(fellowship);
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = activityService.selectByTypeAndFellowshipMultiTable(2, fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = activityService.selectByTypeAndFellowshipMultiTable(2, fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/publishActivity", method = RequestMethod.POST)
    @ApiOperation(value = "发布活动", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "活动名称", required = true),
            @ApiImplicitParam(name = "introduction", value = "活动简介", required = true),
            @ApiImplicitParam(name = "activityType", value = "活动类型", required = true),
            @ApiImplicitParam(name = "isNeedGroup", value = "是否创建群组'true' 'false'", required = true),
            @ApiImplicitParam(name = "expireTime", value = "过期时间'yyyy-MM-dd HH:mm:ss'", required = false),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto publishActivity(HttpServletRequest request, Model model,
                                       @NotBlank(message = "{NotBlank.activityName}")
                                       @RequestParam(value = "name", required = true) String name,
                                       @NotBlank(message = "{NotBlank.introduction}")
                                       @RequestParam(value = "introduction", required = true) String introduction,
                                       @NotBlank(message = "{NotBlank.type}")
                                       @RequestParam(value = "activityType", required = true) String activityType,
                                       @NotBlank
                                       @RequestParam(value = "isNeedGroup", required = true) String isNeedGroup,
                                       @RequestParam(value = "expireTime", required = false) String expireTime,
                                       @RequestParam(value = "fellowship", required = true) String fellowship,
                                       @ApiParam(value = "封面图片", required = true)
                                       @RequestParam(value = "iconImage", required = true) MultipartFile iconImage
    ) throws ResponseException {

        // 1.上传图片
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        String prefix = request.getHeader("Account") + "_";
        Map<String, Object> resultMap = qiniuUploadFileService.qiniuUpload(prefix, iconImage, uploadPath, false);

        // 2.创建活动数据模型
        String account = request.getHeader("Account");
        String activityIcon = (String) resultMap.get("FileFullURL");
        Activity activity = new Activity();
        activity.setAccount(account);
        activity.setName(name);
        activity.setIntroduction(introduction);
        activity.setActivityType(Integer.valueOf(activityType));
        activity.setFellowship(Integer.valueOf(fellowship));
        activity.setIcon(activityIcon);
        // 日期字符串转date
        if (!StringUtils.isEmpty(expireTime)) {
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime expireLocalDateTime = LocalDateTime.parse(expireTime, dateFormat);
            activity.setExpireTime(expireLocalDateTime);
        }
        activity.setGmtCreate(LocalDateTime.now());

        // 3.创建用户_活动映射关系模型
        User_Activity user_activity = new User_Activity();
        user_activity.setAccount(activity.getAccount());
        user_activity.setGmtCreate(LocalDateTime.now());

        // 4.创建群组-活动/群主-写入数据库
        if (Boolean.parseBoolean(isNeedGroup)) {
            String groupID = MathUtils.randomDigitNumber(5);
            while (true) {
                // 4.1自动生成的groupID排重检查
                if (groupService.selectByGroupId(groupID) == null) {
                    break;
                }
                // 随机生成5位群id
                groupID = MathUtils.randomDigitNumber(5);
            }
            // 4.2注册融云群组
            Integer createStatusCode = rongCloudService.createGroup(account, groupID, name);
            if (createStatusCode != 200) {
                qiniuUploadFileService.qiniuDelete((String) resultMap.get("FileKey"));
                throw new ResponseException(ResponseStatusEnum.RONGCLOUD_STATUS_CODE_CREATE_GROUP_ERROR);
            }
            Integer joinStatusCode = rongCloudService.joinGroup(account, groupID, name);
            // 4.3群主加入群组
            if (joinStatusCode != 200) {
                rongCloudService.dismissGroup(account, groupID);
                qiniuUploadFileService.qiniuDelete((String) resultMap.get("FileKey"));
                throw new ResponseException(ResponseStatusEnum.RONGCLOUD_STATUS_CODE_JOIN_GROUP_ERROR);
            }
            // 4.4设置群组id
            activity.setGroupId(Integer.valueOf(groupID));

            // 4.5创建群组数据模型
            Group group = new Group();
            group.setGroupId(Integer.valueOf(groupID));
            group.setGroupIcon(activityIcon);
            group.setGroupName(name);
            group.setCreator(account);
            group.setIntroduction(introduction);
            // 4.5.1日期字符串转LocalDateTime
            if (!StringUtils.isEmpty(expireTime)) {
                DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime dateTime = LocalDateTime.parse(expireTime, dateFormat);
                group.setExpireTime(dateTime);
            }
            group.setFellowship(Integer.valueOf(fellowship));
            group.setGmtCreate(LocalDateTime.now());

            // 4.6调用activityService创建活动/群组/成员关系+事务管理
            try {
                activityService.createGroupActivity(activity, group, user_activity);
            } catch (Exception e) {
                // 数据库异常解散群组，防止脏数据
                rongCloudService.dismissGroup(account, groupID);
                qiniuUploadFileService.qiniuDelete((String) resultMap.get("FileKey"));
                throw new ResponseException(ResponseStatusEnum.DB_TR_ERROR);
            }

            // 4.7返回结果
            return (new ResponseDto(ResponseStatusEnum.SUCCESS));
        }

        // 4.调用activityService创建活动/成员关系+事务管理
        try {
            activityService.createActivity(activity, user_activity);
        } catch (Exception e) {
            // 数据库异常删除七牛云活动图片，防止脏数据
            qiniuUploadFileService.qiniuDelete((String) resultMap.get("FileKey"));
            throw new ResponseException(ResponseStatusEnum.DB_TR_ERROR);
        }

        // 5.返回成功结果
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }

    @ResponseBody
    @RequestMapping(value = "/dismissActivity", method = RequestMethod.GET)
    @ApiOperation(value = "结束活动", notes = "参数描述", hidden = false)
    public ResponseDto dismissActivity(HttpServletRequest request, Model model,
                                                    @NotBlank
                                                    @ApiParam(name = "activityID", value = "活动ID", required = true)
                                                    @RequestParam(value = "activityID", required = true) String activityID
    ) throws ResponseException {
        Activity activity = new Activity();
        try {
            // 0.获取活动信息
            activity = activityService.getBaseMapper().selectById(activityID);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 1.判断权限是否是群主操作
        String account = request.getHeader("Account");
        if (!activity.getAccount().equals(account)) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_DISMISS_GROUP_OWNER_ERROR);
        }

        try {
            // 2.删除活动成员关系表/群组表/活动表
            activityService.dismissGroupActivity(activity);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_TR_ERROR);
        }

        // 3.判断解散融云群组
        Integer groupId = activity.getGroupId();
        if (groupId != null) {
            try {
                rongCloudService.dismissGroup(account, String.valueOf(groupId));
            } catch (ResponseException e) {
                throw new ResponseException(ResponseStatusEnum.RONGCLOUD_STATUS_CODE_DISMISS_GROUP_ERROR);
            }
        }

        // 4.返回成功结果
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }

    @ResponseBody
    @RequestMapping(value = "/joinActivity", method = RequestMethod.GET)
    @ApiOperation(value = "加入活动", notes = "参数描述", hidden = false)
    public ResponseDto joinActivity(HttpServletRequest request, Model model,
                                                    @NotBlank
                                                    @ApiParam(name = "activityID", value = "活动ID", required = true)
                                                    @RequestParam(value = "activityID", required = true) String activityID
    ) throws ResponseException {
        Activity activity = new Activity();
        try {
            // 0.获取活动信息
            activity = activityService.getBaseMapper().selectById(activityID);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 1.判断活动是否有群组 加入融云群组操作
        Integer groupId = activity.getGroupId();
        String account = request.getHeader("Account");
        if (groupId != null) {
            try {
                rongCloudService.joinGroup(account, String.valueOf(groupId), activity.getName());
            } catch (ResponseException e) {
                throw new ResponseException(ResponseStatusEnum.RONGCLOUD_STATUS_CODE_JOIN_GROUP_ERROR);
            }
        }

        try {
            // 2.插入活动成员关系表
            User_Activity user_activity = new User_Activity();
            user_activity.setAccount(account);
            user_activity.setActivityID(activity.getId());
            user_activity.setGmtCreate(LocalDateTime.now());
            user_activityService.getBaseMapper().insert(user_activity);
        } catch (Exception e) {
            // 数据库写入出错时退出群组，防止脏数据（加入事务管理会覆盖错误提示，不方便定位错误）
            rongCloudService.quitGroup(account, String.valueOf(groupId), activity.getName());
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 3.返回成功结果
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }

    @ResponseBody
    @RequestMapping(value = "/quitActivity", method = RequestMethod.GET)
    @ApiOperation(value = "退出活动", notes = "参数描述", hidden = false)
    public ResponseDto quitActivity(HttpServletRequest request, Model model,
                                    @NotBlank
                                    @ApiParam(name = "activityID", value = "活动ID", required = true)
                                    @RequestParam(value = "activityID", required = true) String activityID
    ) throws ResponseException {
        Activity activity = new Activity();
        try {
            // 0.获取活动信息
            activity = activityService.getBaseMapper().selectById(activityID);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 1.判断活动是否有群组 退出融云群组操作
        Integer groupId = activity.getGroupId();
        String account = request.getHeader("Account");
        if (groupId != null) {
            try {
                rongCloudService.quitGroup(account, String.valueOf(groupId), activity.getName());
            } catch (ResponseException e) {
                throw new ResponseException(ResponseStatusEnum.RONGCLOUD_STATUS_CODE_QUIT_GROUP_ERROR);
            }
        }

        try {
            // 2.删除活动成员关系表
            user_activityService.deleteOneByAccountAndActivityID(account, activity.getId());
        } catch (Exception e) {
            // 数据库删除出错时重新加入群组，防止脏数据（加入事务管理会覆盖错误提示，不方便定位错误）
            rongCloudService.joinGroup(account, String.valueOf(groupId), activity.getName());
            throw new ResponseException(ResponseStatusEnum.DB_DELETE_ERROR);
        }

        // 3.返回成功结果
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }
}
