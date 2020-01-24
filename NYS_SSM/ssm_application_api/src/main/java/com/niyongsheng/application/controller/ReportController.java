package com.niyongsheng.application.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Report;
import com.niyongsheng.persistence.service.ReportService;
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
import javax.validation.constraints.NotNull;
import javax.ws.rs.core.MediaType;
import java.time.LocalDateTime;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/report", produces = MediaType.APPLICATION_JSON)
@Api(value = "举报", produces = MediaType.APPLICATION_JSON)
@Validated
public class ReportController {

    @Autowired
    private ReportService reportService;

    @ResponseBody
    @RequestMapping(value = "/userReport", method = RequestMethod.POST)
    @ApiOperation(value = "用户举报接口", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "举报类型：1.广告信息 2.垃圾信息 3.不感兴趣", required = true),
            @ApiImplicitParam(name = "reportId", value = "举报项目id", required = true),
            @ApiImplicitParam(name = "content", value = "举报内容", required = false),
            @ApiImplicitParam(name = "idType", value = "id类型： 1.分享 2.代祷 3.音频 4.活动", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto userReport(HttpServletRequest request, Model model,
                                   @NotNull
                                   @RequestParam(value = "type", required = true) Integer type,
                                   @NotNull
                                   @RequestParam(value = "reportId", required = true) Integer reportId,
                                   @RequestParam(value = "content", required = false) String content,
                                   @NotNull
                                   @RequestParam(value = "idType", required = true) Integer idType,
                                   @NotBlank(message = "{NotBlank.fellowship}")
                                   @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {
        // 1.创建对象
        Report report = new Report();
        report.setAccount(request.getHeader("Account"));
        report.setType(type);
        report.setReportId(reportId);
        report.setContent(content);
        report.setIdType(idType);
        report.setFellowship(Integer.valueOf(fellowship));
        report.setGmtCreate(LocalDateTime.now());

        // 2.写入数据库
        try {
            reportService.getBaseMapper().insert(report);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 3.返回结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS);
    }
}
