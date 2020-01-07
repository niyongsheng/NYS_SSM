package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.WeekBible;
import com.niyongsheng.persistence.service.WeekBibleService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.core.MediaType;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.temporal.WeekFields;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/bible", produces = MediaType.APPLICATION_JSON)
@Api(value = "圣经", produces = MediaType.APPLICATION_JSON)
@Validated
public class BibleController {

    @Autowired
    private WeekBibleService weekBibleService;

    @ResponseBody
    @RequestMapping(value = "/selectWeekBibleList", method = RequestMethod.GET)
    @ApiOperation(value = "查询每周经文列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<WeekBible> selectWeekBibleList(HttpServletRequest request, Model model,
                                                      @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                      @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                      @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                      @NotBlank
                                                      @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<WeekBible> list = null;
        Integer fel = Integer.valueOf(fellowship);
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = weekBibleService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = weekBibleService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectWeekBible", method = RequestMethod.GET)
    @ApiOperation(value = "查询本周经文", notes = "参数描述", hidden = false)
    public ResponseDto<WeekBible> selectWeekBibleList(HttpServletRequest request, Model model,
                                                      @NotBlank(message = "{NotBlank.fellowship}")
                                                      @ApiParam(name = "fellowship", value = "团契", required = true)
                                                      @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {
        // 1.计算当前是本年中的第几周
        WeekFields weekFields = WeekFields.of(DayOfWeek.MONDAY,1);
        int weekOfYear = LocalDateTime.now().get(weekFields.weekOfYear());

        // 2.查询并返回结果
        try {
            WeekBible weekBible = weekBibleService.selectWeekBibleByWeekOfYearAndFellowship(weekOfYear, Integer.valueOf(fellowship));
            return new ResponseDto<WeekBible>(ResponseStatusEnum.SUCCESS, weekBible);
        } catch (NumberFormatException e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }
    }
}
