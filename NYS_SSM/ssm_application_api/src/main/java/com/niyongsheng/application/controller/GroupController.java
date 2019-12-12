package com.niyongsheng.application.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Group;
import com.niyongsheng.persistence.service.GroupService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/group", produces = MediaType.APPLICATION_JSON)
@Api(value = "群组信息", produces = MediaType.APPLICATION_JSON)
@Validated
public class GroupController {

    private final GroupService groupService;
    @Autowired
    public GroupController(GroupService groupService) {
        this.groupService = groupService;
    }

    @ResponseBody
    @RequestMapping(value = "/findAllGroups", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的群组信息列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Group> FindAllGroups(HttpServletRequest request,
                                            @NotNull(message = "{NotBlank.fellowship}")
                                            @RequestParam(value = "fellowship", required = true) Integer fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Group> list = null;
        try {
            list = groupService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship));
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.返回分页对象
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }


    @ResponseBody
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
