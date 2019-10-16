package com.niyongsheng.application.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Face;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.ws.rs.core.MediaType;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/error", produces = MediaType.APPLICATION_JSON)
@Api(value = "错误信息", produces = MediaType.APPLICATION_JSON)
public class ErrorController {

    @ResponseBody
    @RequestMapping(value = "/getResponseStatusEnumList", method = RequestMethod.POST)
    @ApiOperation(value = "获取响应错误信息接口", notes = "参数描述", hidden = false)
    public ResponseDto<ResponseStatusEnum> getResponseStatusEnumList() {
        return new ResponseDto(ResponseStatusEnum.SUCCESS, ResponseStatusEnum.toList());
    }
}
