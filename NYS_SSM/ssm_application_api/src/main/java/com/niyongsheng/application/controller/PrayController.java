package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.application.utils.JwtUtil;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import com.niyongsheng.persistence.domain.Pray;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Pray_Collection;
import com.niyongsheng.persistence.service.PrayService;
import com.niyongsheng.persistence.service.User_Pray_CollectionService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.core.MediaType;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@RestController
@RequestMapping(value = "/pray", produces = MediaType.APPLICATION_JSON)
@Api(value = "代祷事项", produces = MediaType.APPLICATION_JSON)
@Validated
public class PrayController {

    @Autowired
    private PrayService prayService;

    @Autowired
    private QiniuUploadFileService qiniuUploadFileService;

    @Autowired
    private User_Pray_CollectionService user_pray_collectionService;

    @ResponseBody
    @RequestMapping(value = "/selectPrayList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的代祷事项", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Pray> selectPrayList(HttpServletRequest request, Model model,
                                       @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                       @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                       @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                       @NotBlank
                                       @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        String account = request.getHeader("Account");
        List<Pray> list = null;
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = prayService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship), account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = prayService.selectAllByFellowshipMultiTable(Integer.valueOf(fellowship), account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectCollectionPrayList", method = RequestMethod.GET)
    @ApiOperation(value = "查询收藏的代祷事项", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Pray> selectCollectionPrayList(HttpServletRequest request, Model model,
                                            @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                            @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                            @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                            @NotBlank
                                            @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        List<Pray> list = null;
        String account = request.getHeader("Account");
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = user_pray_collectionService.slectArticlesByCollectionAccount(account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = user_pray_collectionService.slectArticlesByCollectionAccount(account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectMyPrayList", method = RequestMethod.GET)
    @ApiOperation(value = "查询我发布的代祷事项", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Pray> selectMyPrayList(HttpServletRequest request, Model model,
                                            @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                            @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                            @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                            @NotBlank
                                            @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        String account = request.getHeader("Account");
        Integer fell = Integer.valueOf(fellowship);
        List<Pray> list = null;
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = prayService.selectMyPrayList(fell, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = prayService.selectMyPrayList(fell, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/publishPray", method = RequestMethod.POST)
    @ApiOperation(value = "发布代祷", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "title", value = "标题", required = true),
            @ApiImplicitParam(name = "subTitle", value = "子标题", required = true),
            @ApiImplicitParam(name = "content", value = "内容", required = true),
            @ApiImplicitParam(name = "prayUrl", value = "代祷链接", required = false),
            @ApiImplicitParam(name = "prayType", value = "代祷类型1", required = true),
            @ApiImplicitParam(name = "anonymity", value = "匿名状态 1匿名 2不匿名", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto publishPray(HttpServletRequest request, Model model,
                                   @NotBlank(message = "{NotBlank.title}")
                                   @RequestParam(value = "title", required = true) String title,
                                   @NotBlank(message = "{NotBlank.subTitle}")
                                   @RequestParam(value = "subTitle", required = true) String subTitle,
                                   @NotBlank(message = "{NotBlank.content}")
                                   @RequestParam(value = "content", required = true) String content,
                                   @RequestParam(value = "prayUrl", required = false) String prayUrl,
                                   @NotBlank(message = "{NotBlank.type}")
                                   @RequestParam(value = "prayType", required = true) String prayType,
                                   @NotBlank
                                   @RequestParam(value = "anonymity", required = true) String anonymity,
                                   @NotBlank(message = "{NotBlank.fellowship}")
                                   @RequestParam(value = "fellowship", required = true) String fellowship,
                                   @ApiParam(value = "封面图片", required = true)
                                   @RequestParam(value = "iconImage", required = true) MultipartFile iconImage
    ) throws ResponseException {

        // 1.上传图片
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        String prefix = request.getHeader("Account") + "_";
        Map<String, Object> resultMap = qiniuUploadFileService.qiniuUpload(prefix, iconImage, uploadPath, false);

        // 2.创建数据模型
        Pray pray = new Pray();
        pray.setAccount(request.getHeader("Account"));
        pray.setTitle(title);
        pray.setSubtitle(subTitle);
        pray.setContent(content);
        pray.setPrayUrl(prayUrl);
        pray.setPrayType(Integer.valueOf(prayType));
        pray.setAnonymity(Boolean.valueOf(anonymity));
        pray.setFellowship(Integer.valueOf(fellowship));
        pray.setIcon((String) resultMap.get("FileFullURL"));
        pray.setGmtCreate(LocalDateTime.now());

        // 3.插入数据库
        try {
            prayService.getBaseMapper().insert(pray);
        } catch (Exception e) {
            qiniuUploadFileService.qiniuDelete((String) resultMap.get("FileKey"));
            throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
        }

        // 4.返回结果
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }

    @ResponseBody
    @RequestMapping(value = "/collectionInOrOut", method = RequestMethod.GET)
    @ApiOperation(value = "收藏/取消收藏", notes = "参数描述", hidden = false)
    public ResponseDto collectionInOrOut(HttpServletRequest request, Model model,
                                         @NotBlank
                                         @ApiParam(name = "prayID", value = "代祷ID", required = true)
                                         @RequestParam(value = "prayID", required = true) String prayID
    ) throws ResponseException {
        String account = request.getHeader("Account");
        Boolean isCollection = user_pray_collectionService.isCollection(account, Integer.valueOf(prayID));
        // 判断然后收藏/取消收藏
        if (isCollection) {
            try {
                user_pray_collectionService.cancelCollection(account, Integer.valueOf(prayID));
            } catch (NumberFormatException e) {
                throw new ResponseException(ResponseStatusEnum.DB_DELETE_ERROR);
            }
            HashMap<String, String> msg = new HashMap<>();
            msg.put("info", "取消收藏成功");
            return new ResponseDto(ResponseStatusEnum.SUCCESS,msg);
        } else {
            User_Pray_Collection user_pray_collection = new User_Pray_Collection();
            user_pray_collection.setAccount(account);
            user_pray_collection.setPrayId(Integer.valueOf(prayID));
            user_pray_collection.setGmtCreate(LocalDateTime.now());
            try {
                user_pray_collectionService.getBaseMapper().insert(user_pray_collection);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
            }
            HashMap<String, String> msg = new HashMap<>();
            msg.put("info", "收藏成功");
            return new ResponseDto(ResponseStatusEnum.SUCCESS,msg);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/deletePrayById", method = RequestMethod.GET)
    @ApiOperation(value = "删除代祷", notes = "参数描述", hidden = false)
    public ResponseDto deletePrayById(HttpServletRequest request, Model model,
                                       @NotBlank
                                       @ApiParam(name = "prayID", value = "代祷ID", required = true)
                                       @RequestParam(value = "prayID", required = true) String prayID
    ) throws ResponseException {
        Integer id = Integer.valueOf(prayID);
        String account = request.getHeader("Account");
        String token = request.getHeader("Token");
        // 1.token解析
        User jwtUser = JwtUtil.decryption(token, User.class);
        Pray pray = prayService.getBaseMapper().selectById(id);
        // 2.删除对象存在判断
        if (pray != null) {
            // 3.管理员和自己拥有删除权限判断
            if (pray.getAccount().equals(account) || jwtUser.getProfession() == 0 || jwtUser.getProfession() == 2) {
                try {
                    // 4.删除操作
                    prayService.getBaseMapper().deleteById(id);
                } catch (Exception e) {
                    throw new ResponseException(ResponseStatusEnum.DB_DELETE_ERROR);
                }
            } else {
                throw new ResponseException(ResponseStatusEnum.DB_DELETE_POWER_ERROR);
            }
        } else {
            throw new ResponseException(ResponseStatusEnum.DB_DELETE_EMPTY_ERROR);
        }

        // 4.返回成功信息
        return (new ResponseDto(ResponseStatusEnum.SUCCESS));
    }

}
