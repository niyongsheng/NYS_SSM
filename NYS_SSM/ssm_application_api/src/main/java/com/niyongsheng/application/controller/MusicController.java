package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.niyongsheng.application.utils.JwtUtil;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.domain.User_Music_Collection;
import com.niyongsheng.persistence.service.MusicService;
import com.niyongsheng.persistence.service.User_Music_CollectionService;
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
@RequestMapping(value = "/music", produces = MediaType.APPLICATION_JSON)
@Api(value = "歌曲", produces = MediaType.APPLICATION_JSON)
@Validated
public class MusicController {

    @Autowired
    private MusicService musicService;

    @Autowired
    private QiniuUploadFileService qiniuUploadFileService;

    @Autowired
    private User_Music_CollectionService user_music_collectionService;

    @ResponseBody
    @RequestMapping(value = "/selectAllMusicList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的音乐列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Music> selectActivityList(HttpServletRequest request, Model model,
                                                 @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                 @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                 @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                 @NotBlank
                                                 @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Music> list = null;
        Integer fel = Integer.valueOf(fellowship);
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize, false);
            try {
                list = musicService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }

        } else {
            try {
                list = musicService.selectByFellowshipMultiTable(fel, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        model.addAttribute("pagingList", list);
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectCollectionMusicList", method = RequestMethod.GET)
    @ApiOperation(value = "查询收藏的音乐列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Music> selectCollectionMusicList(HttpServletRequest request, Model model,
                                                 @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                 @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                 @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                 @NotBlank
                                                 @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Music> list = null;
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize, false);
            try {
                list = user_music_collectionService.slectArticlesByCollectionAccount(account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }

        } else {
            try {
                list = user_music_collectionService.slectArticlesByCollectionAccount(account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        model.addAttribute("pagingList", list);
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/selectMyMusicList", method = RequestMethod.GET)
    @ApiOperation(value = "查询我发布的音乐", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<Music> selectMyMusicList(HttpServletRequest request, Model model,
                                                 @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                 @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                 @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                 @NotBlank
                                                 @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<Music> list = null;
        Integer fell = Integer.valueOf(fellowship);
        String account = request.getHeader("Account");

        // 2.是否分页
        if (isPageBreak) {
            // 2.1设置页码和分页大小
            PageHelper.startPage(pageNum, pageSize, false);
            try {
                list = musicService.selectMyMusicList(fell, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }

        } else {
            try {
                list = musicService.selectMyMusicList(fell, account);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
            }
        }

        model.addAttribute("pagingList", list);
        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/publishMusic", method = RequestMethod.POST)
    @ApiOperation(value = "发布音频", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "音频名称", required = true),
            @ApiImplicitParam(name = "singer", value = "歌手（声音主体）", required = true),
            @ApiImplicitParam(name = "wordAuthor", value = "词作者", required = false),
            @ApiImplicitParam(name = "anAuthor", value = "曲作者", required = false),
            @ApiImplicitParam(name = "musicType", value = "音频类型(歌单id)", required = true),
            @ApiImplicitParam(name = "fellowship", value = "团契编号", required = true)
    })
    public ResponseDto publishMusic(HttpServletRequest request, Model model,
                                    @NotBlank(message = "{NotBlank.musicName}")
                                    @RequestParam(value = "name", required = true) String name,
                                    @NotBlank(message = "{NotBlank.singer}")
                                    @RequestParam(value = "singer", required = true) String singer,
                                    @RequestParam(value = "wordAuthor", required = false) String wordAuthor,
                                    @RequestParam(value = "anAuthor", required = false) String anAuthor,
                                    @NotBlank(message = "{NotBlank.type}")
                                    @RequestParam(value = "musicType", required = true) String musicType,
                                    @NotBlank(message = "{NotBlank.fellowship}")
                                    @RequestParam(value = "fellowship", required = true) String fellowship,
                                    @ApiParam(value = "音频文件", required = true)
                                    @RequestParam(value = "musicFile", required = true) MultipartFile musicFile,
                                    @ApiParam(value = "歌词文件", required = false)
                                    @RequestParam(value = "lyricFile", required = false) MultipartFile lyricFile,
                                    @ApiParam(value = "封面图片", required = true)
                                    @RequestParam(value = "iconImage", required = true) MultipartFile iconImage
    ) throws ResponseException {

        // 1.上传文件
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        String prefix = request.getHeader("Account") + "_";
        Map<String, Object> musicMap = qiniuUploadFileService.qiniuUpload(prefix, musicFile, uploadPath, false);
        Map<String, Object> lyricMap = qiniuUploadFileService.qiniuUpload(prefix, lyricFile, uploadPath, false);
        Map<String, Object> iconMap = qiniuUploadFileService.qiniuUpload(prefix, iconImage, uploadPath, false);

        // 2.创建数据模型
        Music music = new Music();
        music.setAccount(request.getHeader("Account"));
        music.setName(name);
        music.setSinger(singer);
        music.setWordAuthor(wordAuthor);
        music.setAnAuthor(anAuthor);
        music.setMusicType(Integer.valueOf(musicType));
        music.setFellowship(Integer.valueOf(fellowship));
        music.setMusicUrl((String) musicMap.get("FileFullURL"));
        music.setLyric((String) lyricMap.get("FileFullURL"));
        music.setIcon((String) iconMap.get("FileFullURL"));
        music.setGmtCreate(LocalDateTime.now());

        // 3.插入数据库
        try {
            musicService.getBaseMapper().insert(music);
        } catch (Exception e) {
            // 清除失效文件
            qiniuUploadFileService.qiniuDelete((String) musicMap.get("FileKey"));
            qiniuUploadFileService.qiniuDelete((String) lyricMap.get("FileKey"));
            qiniuUploadFileService.qiniuDelete((String) iconMap.get("FileKey"));
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
                                         @ApiParam(name = "musicID", value = "音频ID", required = true)
                                         @RequestParam(value = "musicID", required = true) String musicID
    ) throws ResponseException {
        String account = request.getHeader("Account");
        Boolean isCollection = user_music_collectionService.isCollection(account, Integer.valueOf(musicID));
        // 判断然后收藏/取消收藏
        if (isCollection) {
            try {
                user_music_collectionService.cancelCollection(account, Integer.valueOf(musicID));
            } catch (NumberFormatException e) {
                throw new ResponseException(ResponseStatusEnum.DB_DELETE_ERROR);
            }
            HashMap<String, String> msg = new HashMap<>();
            msg.put("info", "取消收藏成功");
            return new ResponseDto(ResponseStatusEnum.SUCCESS,msg);
        } else {
            User_Music_Collection user_music_collection = new User_Music_Collection();
            user_music_collection.setAccount(account);
            user_music_collection.setMusicId(Integer.valueOf(musicID));
            user_music_collection.setGmtCreate(LocalDateTime.now());
            try {
                user_music_collectionService.getBaseMapper().insert(user_music_collection);
            } catch (Exception e) {
                throw new ResponseException(ResponseStatusEnum.DB_INSERT_ERROR);
            }
            HashMap<String, String> msg = new HashMap<>();
            msg.put("info", "收藏成功");
            return new ResponseDto(ResponseStatusEnum.SUCCESS,msg);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/deleteMusicById", method = RequestMethod.GET)
    @ApiOperation(value = "删除音乐", notes = "参数描述", hidden = false)
    public ResponseDto deleteMusicById(HttpServletRequest request, Model model,
                                         @NotBlank
                                         @ApiParam(name = "musicID", value = "音乐ID", required = true)
                                         @RequestParam(value = "musicID", required = true) String musicID
    ) throws ResponseException {
        Integer id = Integer.valueOf(musicID);
        String account = request.getHeader("Account");
        String token = request.getHeader("Token");
        // 1.token解析
        User jwtUser = JwtUtil.decryption(token, User.class);
        Music music = musicService.getBaseMapper().selectById(id);
        // 2.删除对象存在判断
        if (music != null) {
            // 3.管理员和自己拥有删除权限判断
            if (music.getAccount().equals(account) || jwtUser.getProfession() == 0 || jwtUser.getProfession() == 2) {
                try {
                    // 4.删除操作
                    musicService.getBaseMapper().deleteById(id);
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
