package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Fellowship;
import com.niyongsheng.persistence.service.FellowshipService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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
@RequestMapping(value = "/fellowship", produces = MediaType.APPLICATION_JSON)
@Api(value = "团契", produces = MediaType.APPLICATION_JSON)
@Validated
public class FellowshipController {

    private FellowshipService fellowshipService;
    @Autowired
    public FellowshipController(FellowshipService fellowshipService) {
        this.fellowshipService = fellowshipService;
    }

    @ResponseBody
    @RequestMapping(value = "/selectArticleList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的文章", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0")
    })
    public ResponseDto<Fellowship> selectBannerList(HttpServletRequest request, Model model,
                                                    @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                    @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                    @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        List<Fellowship> list = null;
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = fellowshipService.getBaseMapper().selectList(null);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = fellowshipService.getBaseMapper().selectList(null);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }
}
