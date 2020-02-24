package com.niyongsheng.manager.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.rongCloud.RongCloudService;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.GroupService;
import com.niyongsheng.persistence.service.UserService;
import io.rong.models.response.GroupUser;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping(value = "/group")
@Api(value = "群组信息")
@Validated
public class GroupController {

    @Autowired
    private GroupService groupService;

    @Autowired
    private RongCloudService rongCloudService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/findAllGroups", method = {RequestMethod.POST, RequestMethod.GET})
    @ApiOperation(value = "查询所有的群组信息列表", notes = "参数描述")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "pageNum", value = "页码", required = false),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = false),
            @ApiImplicitParam(name = "fellowship", value = "团契id", required = true)
    })
    public String findAllGroups(Model model,
                          @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                          @RequestParam(value="pageNum", defaultValue="1", required = false) Integer pageNum,
                          @RequestParam(value="pageSize", defaultValue="10", required = false) Integer pageSize,
                          @NotNull(message = "{NotBlank.fellowship}")
                          @RequestParam(value = "fellowship", required = true) String fellowship
    ) {
        if (isPageBreak) {
            // 1.设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize);

            // 2.调用service的方法
            List<Group> list = groupService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship));

            // 3.包装分页对象
            PageInfo pageInfo = new PageInfo(list);

            // 4.存入request域
            model.addAttribute("pagingList", pageInfo);
        } else {
            // 1.调用service的方法
            List<Group> list = groupService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship));

            // 2.存入request域
            model.addAttribute("pagingList", list);
        }

        return "groupList";
    }

    @RequestMapping(value = "/selectGroupMemberListById", method = RequestMethod.GET)
    @ApiOperation(value = "查询群组成员列表", notes = "参数描述", hidden = false)
    public ResponseDto<User> selectActivityMemberListById(HttpServletRequest request, Model model,
                                                          @NotBlank(message = "{NotBlank.activityID}")
                                                          @ApiParam(name = "groupId", value = "群组ID", required = true)
                                                          @RequestParam(value = "groupId", required = true) String groupId
    ) throws ResponseException {
        try {
            // 1.获取群成员id列表
            List<GroupUser> groupUserList = rongCloudService.getGroupMember(groupId);
            // 2.群成员列表手动装载
            List<User> userList = new ArrayList<User>();
            for (GroupUser groupUser : groupUserList) {
                try {
                    User user = userService.findUserByAccount(groupUser.getId());
                    userList.add(user);
                } catch (Exception e) {
                    throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
                }
            }
            // 3.返回查询结果
            return new ResponseDto(ResponseStatusEnum.SUCCESS, userList);
        } catch (ResponseException e) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_GETMEMBER_GROUP_ERROR);
        }
    }

    @RequestMapping(value = "/providerInfoForGroup", method = RequestMethod.GET)
    @ApiOperation(value = "群组信息提供者接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "groupId", value = "群ID", required = true),
    })
    public ResponseDto<Group> ProviderInfoForGroup(HttpServletRequest request,
                                                 @NotEmpty
                                                 @RequestParam(value = "groupId", required = true) String groupId
    ) throws ResponseException {

        // 1.数据库查询用户
        Group group = null;
        try {
            group = groupService.selectByGroupId(groupId);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.数据校验
        if (group == null) {
            throw new ResponseException(ResponseStatusEnum.GROUP_UNEXISTENT_ERROR);
        }

        // 3.返回分页对象
        return new ResponseDto(ResponseStatusEnum.SUCCESS, group);
    }
}
