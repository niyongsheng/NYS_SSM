package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.MusicMenu;
import com.niyongsheng.persistence.service.MusicMenuService;
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
import javax.ws.rs.core.MediaType;
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
@RequestMapping(value = "/musicSongMenu", produces = MediaType.APPLICATION_JSON)
@Api(value = "歌单", produces = MediaType.APPLICATION_JSON)
@Validated
public class MusicMenuController {

    @Autowired
    private MusicMenuService musicMenuService;

    @ResponseBody
    @RequestMapping(value = "/selectAllByFellowship", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的歌单完整信息（含歌曲列表、用户信息、团契信息)", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<MusicMenu> selectAllByFellowship(HttpServletRequest request, Model model,
                                                      @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                      @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                      @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                      @NotBlank
                                                      @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<MusicMenu> list = null;
        try {
            Map<String,Object> columnMap = new HashMap<>();
            columnMap.put("fellowship", Integer.valueOf(fellowship));
            list = musicMenuService.selectAllByFellowship(Integer.valueOf(fellowship));
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

    @ResponseBody
    @RequestMapping(value = "/selectMusicMenuList", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的歌单", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum", value = "页码", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", defaultValue = "10"),
            @ApiImplicitParam(name = "isPageBreak", value = "是否分页", defaultValue = "0"),
            @ApiImplicitParam(name = "fellowship", value = "团契", required = true)
    })
    public ResponseDto<MusicMenu> selectMusicMenuList(HttpServletRequest request, Model model,
                                                          @RequestParam(value = "pageNum", defaultValue = "1", required = false) Integer pageNum,
                                                          @RequestParam(value = "pageSize", defaultValue = "10", required = false) Integer pageSize,
                                                          @RequestParam(value = "isPageBreak", defaultValue = "0", required = false) boolean isPageBreak,
                                                          @NotBlank
                                                          @RequestParam(value = "fellowship", required = true) String fellowship
    ) throws ResponseException {

        // 1.调用service的方法
        List<MusicMenu> list = null;
        try {
            Map<String,Object> columnMap = new HashMap<>();
            columnMap.put("fellowship", Integer.valueOf(fellowship));
            list = musicMenuService.getBaseMapper().selectByMap(columnMap);
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

    @ResponseBody
    @RequestMapping(value = "/selectMusicListById", method = RequestMethod.GET)
    @ApiOperation(value = "根据歌单id查询歌曲列表", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "歌单id", required = true)
    })
    public ResponseDto<MusicMenu> selectMusicListById(HttpServletRequest request, Model model,
                                                      @NotBlank
                                                      @RequestParam(value = "id", required = true) String id
    ) throws ResponseException {

        // 1.调用service的SQL方法
        MusicMenu musicMenu = new MusicMenu();
        try {
            musicMenu = musicMenuService.selectMusicListById(Integer.valueOf(id));
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.DB_SELECT_ERROR);
        }

        // 2.返回结果
        return new ResponseDto(ResponseStatusEnum.SUCCESS, musicMenu);
    }
}
