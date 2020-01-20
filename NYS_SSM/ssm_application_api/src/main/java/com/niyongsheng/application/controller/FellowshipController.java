package com.niyongsheng.application.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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
    @RequestMapping(value = "/selectFellowshipList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的团契", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Token", value = "此接口无需验证", required = false, dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Account", value = "此接口无需验证", required = false, dataType = "String", paramType = "header")
    })
    public ResponseDto<Fellowship> selectBannerList(HttpServletRequest request, Model model) throws ResponseException {

        // 1.无分页查询
        List<Fellowship> list = null;
        try {
                list = fellowshipService.getBaseMapper().selectList(null);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }

        // 2.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }
}
