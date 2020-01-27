package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Scorelog;
import com.niyongsheng.persistence.service.ScorelogService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.core.MediaType;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/scorelog", produces = MediaType.APPLICATION_JSON)
@Api(value = "交易记录", produces = MediaType.APPLICATION_JSON)
@Validated
public class ScorelogController {

    @Autowired
    private ScorelogService scorelogService;

    @ResponseBody
    @RequestMapping(value = "/selectScorelogList", method = RequestMethod.GET)
    @ApiOperation(value = "查询积分记录列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契id", required = true)
    })
    public ResponseDto<Scorelog> selectScorelogList(HttpServletRequest request, Model model,
                                                    @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                    @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                    @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                    @NotBlank
                                                    @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Scorelog> list = null;
        Integer fel = Integer.valueOf(fellowship);
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = scorelogService.selectUserScorelogByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = scorelogService.selectUserScorelogByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/signToday", method = RequestMethod.GET)
    @ApiOperation(value = "今日签到", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "remark", value = "备注信息", required = false),
            @ApiImplicitParam(name = "fellowship", value = "团契id", required = true)
    })
    public ResponseDto<Scorelog> signToday(HttpServletRequest request, Model model,
                                           @RequestParam(value = "remark", required = false) String remark,
                                           @NotBlank
                                           @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {
        // 1.检查今天是否已签过到
        String account = request.getHeader("Account");
        Boolean isSignedToday = scorelogService.isSignedToday(1, account, Integer.valueOf(fellowship));
        if (isSignedToday) {
            throw  new ResponseException(ResponseStatusEnum.SCORE_STATUS_RESIGN_ERROR);
        }

        // 2.插入交易记录表
        Scorelog scorelog = new Scorelog();
        scorelog.setAccount(account);
        // TODO Boolean写入数据库bit报错 1064
//        scorelog.setInout(true);
        scorelog.setType(1); // 交易类型
        scorelog.setAmount(+1.0); // 积分数
        scorelog.setFellowship(Integer.valueOf(fellowship));
        scorelog.setGmtCreate(LocalDateTime.now());
        try {
            scorelogService.sign(scorelog);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_TR_ERROR);
        }

        // 3.返回成功信息
        return new ResponseDto(ResponseStatusEnum.SUCCESS, scorelog);
    }
}
