package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Banner;
import com.niyongsheng.persistence.service.BannerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
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
@RequestMapping(value = "/banner", produces = MediaType.APPLICATION_JSON)
@Api(value = "轮播图", produces = MediaType.APPLICATION_JSON)
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @ResponseBody
    @RequestMapping(value = "/selectBannerList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的banner图", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0")
    })
    public ResponseDto<Banner> findAll(HttpServletRequest request, Model model,
                                     @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                     @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                     @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak
    ) throws ResponseException {

        // 1.调用service的方法
        List<Banner> list = null;
        try {
//            list = bannerService.getBaseMapper().selectList(null);
             list = bannerService.selectAllMultiTable();
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.是否分页
        if (isPageBreak) {
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize);

            // 2.2包装分页对象
            PageInfo pageInfo = new PageInfo(list);

            model.addAttribute("pagingList", pageInfo);
            return new ResponseDto(ResponseStatusEnum.SUCCESS, pageInfo);
        } else {
            model.addAttribute("pagingList", list);
            return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
        }
    }
}
