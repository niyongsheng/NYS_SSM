package com.niyongsheng.application.controller;

import com.niyongsheng.application.arcSoft.ArcSoftFaceRecognition;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.persistence.domain.Face;
import com.niyongsheng.persistence.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.MediaType;
import java.io.File;
import java.io.IOException;
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
@RequestMapping(value = "/face", produces = MediaType.APPLICATION_JSON)
@Api(value = "人脸识别", produces = MediaType.APPLICATION_JSON)
public class FaceController {

    @Autowired
    private UserService userService;

    @Autowired
    private ArcSoftFaceRecognition arcSoftFaceRecognition;

    @ResponseBody
    @RequestMapping(value = "/getFaceFeature", method = RequestMethod.POST)
    @ApiOperation(value = "获取RGB人脸识别特征信息接口", notes = "参数描述", hidden = false)
    public ResponseDto<Face> getFaceFeature(HttpServletRequest request,
                                             @ApiParam(value = "团契编号", required = true)
                                             @RequestParam(value = "fellowship", required = true) String fellowship,
                                             @ApiParam(value = "上传的人脸图片", required = true)
                                             @RequestParam(value = "file", required = true) MultipartFile file
    ) throws ResponseException {
        if (file.isEmpty()) {
            throw new ResponseException(ResponseStatusEnum.IO_EMPTY_ERROR);
        }
        // 动态运行库绝对路径
        String dibPath = request.getSession().getServletContext().getRealPath("WEB-INF" + File.separator + "dib");
        // 图片本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        // 时间戳重命名图片
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        String filePath = uploadPath + File.separator + fileName;
        try {
            // 转存
            file.transferTo(new File(filePath));
        } catch (IOException e) {
            throw new ResponseException(ResponseStatusEnum.IO_TRANSFER_ERROR);
        }
        // 调用人脸识别方法
        List<Face> faceList = arcSoftFaceRecognition.getFaceFeature(dibPath, filePath);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, faceList);
    }

    @ResponseBody
    @RequestMapping(value = "/getIRFaceFeature", method = RequestMethod.POST)
    @ApiOperation(value = "获取IR人脸识别特征信息接口", notes = "参数描述", hidden = false)
    public ResponseDto<Face> getIRFaceFeature(HttpServletRequest request,
                                            @ApiParam(value = "团契编号", required = true)
                                            @RequestParam(value = "fellowship", required = true) String fellowship,
                                            @ApiParam(value = "上传的IR人脸图片", required = true)
                                            @RequestParam(value = "file", required = true) MultipartFile file
    ) throws ResponseException {
        if (file.isEmpty()) {
            throw new ResponseException(ResponseStatusEnum.IO_EMPTY_ERROR);
        }
        // 动态运行库绝对路径
        String dibPath = request.getSession().getServletContext().getRealPath("WEB-INF" + File.separator + "dib");
        // 图片本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        // 时间戳重命名图片
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        String filePath = uploadPath + File.separator + fileName;
        try {
            file.transferTo(new File(filePath));
        } catch (IOException e) {
            throw new ResponseException(ResponseStatusEnum.IO_TRANSFER_ERROR);
        }
        // 调用人脸识别方法
        List<Face> faceList = arcSoftFaceRecognition.getIRFaceFeature(dibPath, filePath);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, faceList);
    }

    @ResponseBody
    @RequestMapping(value = "/compareFaceFeature", method = RequestMethod.POST)
    @ApiOperation(value = "对比两张人脸特征相似度接口", notes = "*如果图片中存在多张人脸默认对比最前面的人脸", hidden = false)
    public ResponseDto<Face> compareFaceFeature(HttpServletRequest request,
                                                @ApiParam(value = "团契编号", required = true)
                                                @RequestParam(value = "fellowship", required = true) String fellowship,
                                                @ApiParam(value = "上传的人脸图片1", required = true)
                                                @RequestParam(value = "file1", required = true) MultipartFile file1,
                                                @ApiParam(value = "上传的人脸图片2", required = true)
                                                @RequestParam(value = "file2", required = true) MultipartFile file2
    ) throws ResponseException {
        if (file1.isEmpty() || file2.isEmpty()) {
            throw new ResponseException(ResponseStatusEnum.IO_EMPTY_ERROR);
        }
        // 动态运行库绝对路径
        String dibPath = request.getSession().getServletContext().getRealPath("WEB-INF" + File.separator + "dib");
        // 图片本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        // 时间戳重命名图片
        String fileName1 = System.currentTimeMillis() + "_" + file1.getOriginalFilename();
        String fileName2 = System.currentTimeMillis() + "_" + file2.getOriginalFilename();
        String filePath1 = uploadPath + File.separator + fileName1;
        String filePath2 = uploadPath + File.separator + fileName2;
        try {
            file1.transferTo(new File(filePath1));
            file2.transferTo(new File(filePath2));
        } catch (IOException e) {
            throw new ResponseException(ResponseStatusEnum.IO_TRANSFER_ERROR);
        }
        // 调用人脸识别方法
        Map resultMap = arcSoftFaceRecognition.compareFaceFeature(dibPath, filePath1, filePath2);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, resultMap);
    }

    @ResponseBody
    @RequestMapping(value = "/compareFaceFeatureCode", method = RequestMethod.GET)
    @ApiOperation(value = "对比两张人脸特征码相似度接口", notes = "参数描述", hidden = false)
    public ResponseDto<Face> compareFaceFeatureCode(HttpServletRequest request,
                                                @ApiParam(value = "人脸特征码1", required = true)
                                                @RequestParam(value = "faceCode1", required = true) String faceCode1,
                                                @ApiParam(value = "人脸特征码2", required = true)
                                                @RequestParam(value = "faceCode2", required = true) String faceCode2
    ) throws ResponseException {
        // 参数格式校验
        if (faceCode1.length() < 1032 || faceCode2.length() < 1032) {
            throw new ResponseException(ResponseStatusEnum.PARAM_FORMAT_ERROR);
        }
        // 动态运行库绝对路径
        String dibPath = request.getSession().getServletContext().getRealPath("WEB-INF" + File.separator + "dib");
        // 调用人脸识别方法
        Map resultMap = arcSoftFaceRecognition.compareFaceFeatureCode(dibPath, faceCode1, faceCode2);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, resultMap);
    }
}
