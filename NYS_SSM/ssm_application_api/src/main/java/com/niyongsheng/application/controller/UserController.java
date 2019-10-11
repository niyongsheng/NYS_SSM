package com.niyongsheng.application.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.niyongsheng.application.utils.ArcSoftFaceRecognition;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.UserService;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.MediaType;
import java.io.File;
import java.io.IOException;
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
@RequestMapping(value = "/user", produces = MediaType.APPLICATION_JSON)
@Api(value = "用户信息", produces = MediaType.APPLICATION_JSON)
//@CrossOrigin(origins = "*",allowedHeaders = {"Access-Control-Allow-*"}) // 跨域
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ArcSoftFaceRecognition faceRecognition;

    /**
     * 查询所有
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询所有的用户信息并分页展示", notes = "参数描述", hidden = false)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageNum",value = "跳转到的页数", required = true, paramType = "query"),
            @ApiImplicitParam(name = "pageSize",value = "每页展示的记录数", required = true, paramType = "query")
    })
    public ResponseDto<User> findAll(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
                              @RequestParam(value="pageSize",defaultValue="10")Integer pageSize,
                              Model model) {
        System.out.println("表现层：查询所有的用户信息...");
        // 1.设置页码和分页大小
        PageHelper.startPage(pageNum, pageSize);

        // 2.调用service的方法
        List<User> list = userService.findAll();

        // 3.包装分页对象
        PageInfo pageInfo = new PageInfo(list);

        model.addAttribute("pagingList", pageInfo);

        // 4.包装返回体
        Map<String, Object> respMap = new HashMap();
        respMap.put("auth", "NYS");
        respMap.put("list", pageInfo);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, list);
    }

    @ResponseBody
    @RequestMapping(value = "/faceRecognition", method = RequestMethod.POST)
    @ApiOperation(value = "人脸识别特征码提取接口", notes = "参数描述", hidden = false)
    public ResponseDto faceRecognition(/*@ApiParam(value = "团契编号", required = true)
                                       @RequestParam(value = "fellowship" ,required = true) String fellowship,
                                       @ApiParam(value = "上传的人脸图片", required = true)
                                       @RequestParam(value = "file" ,required = true) MultipartFile file,*/
                                       HttpServletRequest request) {
        Map<String, String> map = new HashMap();
//        if (!file.isEmpty()) {
//            String dibPath = request.getSession().getServletContext().getRealPath("WEB-INF" + File.separator + "dib");
//            String uploadPath = request.getSession().getServletContext().getRealPath("WEB-INF/classes/");
//            String fileName = System.currentTimeMillis() + file.getOriginalFilename();
//            String filePath = uploadPath + fileName;
//            try {
//                file.transferTo(new File(filePath));
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
            String dibPath = request.getSession().getServletContext().getRealPath("WEB-INF" + File.separator + "dib");
            String fp = request.getSession().getServletContext().getRealPath("img" + File.separator + "test.png");
            map = faceRecognition.getFaceFeature(dibPath, fp);
//        }
        return new ResponseDto(ResponseStatusEnum.SUCCESS, map);
    }


    public ResponseDto Register() {


        return new ResponseDto();
    }
}
