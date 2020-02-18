package com.niyongsheng.manager.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Conversation;
import com.niyongsheng.persistence.service.ConversationService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/conversation")
@Api(value = "会话信息")
@Validated
public class ConversationController {

    @Autowired
    private ConversationService conversationService;

    @ResponseBody
    @RequestMapping(value = "/getConversationList", method = {RequestMethod.GET, RequestMethod.POST})
    @ApiOperation(value = "查询所有的用户信息列表并分页展示", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto<Conversation> findAllUsers(HttpServletRequest request, Model model,
                                                  @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                  @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                  @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
//                                          @NotBlank(message = "{NotBlank.fellowship}")
                                                  @RequestParam(value = "fellowship", required = false) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        List<Conversation> list = null;
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = conversationService.getConversationListByFellowship(1);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = conversationService.getConversationListByFellowship(1);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }
}
