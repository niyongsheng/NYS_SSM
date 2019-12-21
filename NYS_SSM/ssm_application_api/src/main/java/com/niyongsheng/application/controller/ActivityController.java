package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Activity;
import com.niyongsheng.persistence.service.ActivityService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
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
@RequestMapping(value = "/activity", produces = MediaType.APPLICATION_JSON)
@Api(value = "活动", produces = MediaType.APPLICATION_JSON)
@Validated
public class ActivityController {

    @Autowired
    private ActivityService activityService;

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

        // 2.是否分页
        if (isPageBreak) {
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize, false);
            try {
                list = activityService.selectByFellowshipMultiTable(Integer.valueOf(fellowship));
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }

        } else {
            try {
                list = activityService.selectByFellowshipMultiTable(Integer.valueOf(fellowship));
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        model.addAttribute("pagingList", list);
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }
}
