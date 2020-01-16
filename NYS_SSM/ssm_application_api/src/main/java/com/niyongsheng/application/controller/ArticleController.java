package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import com.niyongsheng.persistence.domain.Article;
import com.niyongsheng.persistence.domain.User_Article_Collection;
import com.niyongsheng.persistence.service.ArticleService;
import com.niyongsheng.persistence.service.User_Article_CollectionService;
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
@RequestMapping(value = "/article", produces = MediaType.APPLICATION_JSON)
@Api(value = "文章", produces = MediaType.APPLICATION_JSON)
@Validated
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private QiniuUploadFileService qiniuUploadFileService;

    @Autowired
    private User_Article_CollectionService user_article_collectionService;

    @ResponseBody
    @RequestMapping(value = "/selectArticleList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的文章", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Article> selectBannerList(HttpServletRequest request, Model model,
                                                 @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                 @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                 @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                 @NotBlank
                                                 @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        List<Article> list = null;
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = articleService.selectByFellowshipMultiTable(Integer.valueOf(fellowship));
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = articleService.selectByFellowshipMultiTable(Integer.valueOf(fellowship));
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectCollectionArticleList", method = RequestMethod.GET)
    @ApiOperation(value = "查询收藏的文章", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Article> selectCollectionArticleList(HttpServletRequest request, Model model,
                                                 @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                 @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                 @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                 @NotBlank
                                                 @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.是否分页，调用service的方法
        List<Article> list = null;
        String account = request.getHeader("Account");
        if (isPageBreak) {
            try {
                // 2.1分页查询 设置页码和分页大小
                PageHelper.startPage(pageNum, pageSize, false);
                list = user_article_collectionService.selectArticlesByCollectionAccount(account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        } else {
            try {
                // 2.1无分页查询
                list = user_article_collectionService.selectArticlesByCollectionAccount(account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        // 3.返回查询结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/publishArticle", method = RequestMethod.POST)
    @ApiOperation(value = "发布分享", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "title", value = "标题", required = true),
            @ApiImplicitParam(name = "subTitle", value = "子标题", required = true),
            @ApiImplicitParam(name = "author", value = "作者", required = false),
            @ApiImplicitParam(name = "content", value = "内容", required = true),
            @ApiImplicitParam(name = "articleUrl", value = "转发链接", required = false),
            @ApiImplicitParam(name = "articleType", value = "类型（1原创/2转发）", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto publishArticle(HttpServletRequest request, Model model,
                                      @NotBlank(message = "{NotBlank.title}")
                                      @RequestParam(value = "title", required = true) String title,
                                      @NotBlank(message = "{NotBlank.subTitle}")
                                      @RequestParam(value = "subTitle", required = true) String subTitle,
                                      @RequestParam(value = "author", required = false) String author,
                                      @NotBlank(message = "{NotBlank.content}")
                                      @RequestParam(value = "content", required = true) String content,
                                      @RequestParam(value = "articleUrl", required = false) String articleUrl,
                                      @NotBlank(message = "{NotBlank.type}")
                                      @RequestParam(value = "articleType", required = true) String articleType,
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
        Article article = new Article();
        article.setAccount(request.getHeader("Account"));
        article.setTitle(title);
        article.setSubtitle(subTitle);
        article.setAuthor(author);
        article.setContent(content);
        article.setArticleUrl(articleUrl);
        article.setFellowship(Integer.valueOf(fellowship));
        article.setArticleType(Integer.valueOf(articleType));
        article.setIcon((String) resultMap.get("FileFullURL"));
        article.setGmtCreate(LocalDateTime.now());

        // 3.插入数据库
        try {
            articleService.getBaseMapper().insert(article);
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
                                    @ApiParam(name = "articleID", value = "文章ID", required = true)
                                    @RequestParam(value = "articleID", required = true) String articleID
    ) throws ResponseException {
        String account = request.getHeader("Account");
        Boolean isCollection = user_article_collectionService.isCollection(account, Integer.valueOf(articleID));
        // 判断然后收藏/取消收藏
        if (isCollection) {
            try {
                user_article_collectionService.cancelCollection(account, Integer.valueOf(articleID));
            } catch (NumberFormatException e) {
                throw new ResponseException(ResponseStatusEnum.DB_DELETE_ERROR);
            }
            HashMap<String, String> msg = new HashMap<>();
            msg.put("info", "取消收藏成功");
            return new ResponseDto(ResponseStatusEnum.SUCCESS,msg);
        } else {
            User_Article_Collection user_article_collection = new User_Article_Collection();
            user_article_collection.setAccount(account);
            user_article_collection.setArticleId(Integer.valueOf(articleID));
            user_article_collection.setGmtCreate(LocalDateTime.now());
            try {
                user_article_collectionService.getBaseMapper().insert(user_article_collection);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
            }
            HashMap<String, String> msg = new HashMap<>();
            msg.put("info", "收藏成功");
            return new ResponseDto(ResponseStatusEnum.SUCCESS,msg);
        }
    }
}