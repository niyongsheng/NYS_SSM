package com.niyongsheng.application.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
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
@RequestMapping(value = "/file", produces = MediaType.APPLICATION_JSON)
@Api(value = "文件处理", produces = MediaType.APPLICATION_JSON)
@Validated
public class FileController {
    
    @Autowired
    private QiniuUploadFileService qiniuUploadFileService;

    @ResponseBody
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ApiOperation(value = "单文件上传接口", notes = "参数描述", hidden = false)
    public ResponseDto<Map> uploadFile(HttpServletRequest request,
                                            @NotBlank
                                            @ApiParam(value = "团契编号", required = true)
                                            @RequestParam(value = "fellowship", required = true) String fellowship,
                                            @ApiParam(value = "上传的文件(file)", required = true)
                                            @RequestParam(value = "file", required = true) MultipartFile file
    ) throws ResponseException {

        // 文件本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        // 上传文件
        String prefix = request.getHeader("Account") + "_";
        Map<String, Object> resultMap = qiniuUploadFileService.qiniuUpload(prefix, file, uploadPath, false);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, resultMap);
    }

    @ResponseBody
    @RequestMapping(value = "/uploadFiles", method = RequestMethod.POST)
    @ApiOperation(value = "多文件上传接口", notes = "参数描述", hidden = false)
    public ResponseDto<List> uploadFiles(HttpServletRequest request,
                                  @NotBlank
                                  @ApiParam(value = "团契编号", required = true)
                                  @RequestParam(value = "fellowship", required = true) String fellowship,
                                  @ApiParam(value = "上传的文件数组(file)", required = true)
                                  @RequestParam(value = "files", required = true) MultipartFile[] files
    ) throws ResponseException {

        // 文件本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");

        // 循环上传
        List<Map> fileList = new ArrayList<Map>();
        for (MultipartFile multipartFile : files) {
            // 上传文件
            String prefix = request.getHeader("Account") + "_";
            fileList.add(qiniuUploadFileService.qiniuUpload(prefix, multipartFile, uploadPath, false));
        }

        return new ResponseDto(ResponseStatusEnum.SUCCESS, fileList);
    }
}
