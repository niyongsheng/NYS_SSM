package com.niyongsheng.application.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.service.MusicService;
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
        String prefix = request.getHeader("Account") + "/" + this.getClass().getName() + "/";
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
}
