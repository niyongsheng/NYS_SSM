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
    private QiniuUploadFileService qiniuUploadFileService;

    @Autowired
    private RongCloudService rongCloudService;

    @Autowired
    private GroupService groupService;

    @ResponseBody
    @RequestMapping(value = "/selectActivityList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的活动", notes = "参数描述", hidden = false)
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
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize, false);
            try {
                list = activityService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }

        } else {
            try {
                list = activityService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        model.addAttribute("pagingList", list);
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
        activity.setGmtCreate(LocalDateTime.now());

        // 3.创建群组-活动/群主-写入数据库
        if (Boolean.parseBoolean(isNeedGroup)) {
            String groupID = MathUtils.randomDigitNumber(5);
            while (true) {
                // 3.1自动生成的groupID排重检查
                if (groupService.selectByGroupId(groupID) == null) {
                    break;
                }
                groupID = MathUtils.randomDigitNumber(5);
            }
            // 3.2注册融云群组
            Integer statusCode = rongCloudService.createGroup(account, groupID, name);
            if (statusCode != 200) {
                qiniuUploadFileService.qiniuDelete((String) resultMap.get("FileKey"));
                throw new ResponseException(ResponseStatusEnum.RONGCLOUD_STATUS_CODE_GROUP_ERROR);
            }
            // 3.3设置群组id
            activity.setGroupId(Integer.valueOf(groupID));

            // 3.4创建群组数据模型
            Group group = new Group();
            group.setGroupId(Integer.valueOf(groupID));
            group.setGroupIcon(activityIcon);
            group.setGroupName(name);
            group.setCreator(account);
            group.setIntroduction(introduction);
            // 3.4.1日期字符串转LocalDateTime
            if (!StringUtils.isEmpty(expireTime)) {
                DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime dateTime = LocalDateTime.parse(expireTime, dateFormat);
                group.setExpireTime(dateTime);
            }
            group.setFellowship(Integer.valueOf(fellowship));
            group.setGmtCreate(LocalDateTime.now());

            // 3.5创建用户_活动映射关系模型
            User_Activity user_activity = new User_Activity();
            user_activity.setAccount(activity.getAccount());
            user_activity.setActivityId(activity.getId());
            user_activity.setGmtCreate(LocalDateTime.now());

            // 3.6调用activityService创建活动和群主+事务管理
            try {
                activityService.createGroupActivity(activity, group, user_activity);
            } catch (Exception e) {
                // 数据库异常解散群组，防止脏数据
                rongCloudService.dismissGroup(account, groupID);
                throw new ResponseException(ResponseStatusEnum.DB_TR_ERROR);
            }

            // 3.7返回结果
            return (new ResponseDto(ResponseStatusEnum.SUCCESS));
        }

        // 4.插入数据库活动表
        try {
            activityService.getBaseMapper().insert(activity);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 5.返回结果
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }
}
