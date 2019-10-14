package com.niyongsheng.application.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.MediaType;
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
public class FileController {
    
    @Autowired
    private QiniuUploadFileService qiniuUploadFileService;

    @ResponseBody
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ApiOperation(value = "上传文件接口", notes = "参数描述", hidden = false)
    public ResponseDto uploadFile(HttpServletRequest request,
                                            @ApiParam(value = "团契编号", required = true)
                                            @RequestParam(value = "fellowship", required = true) String fellowship,
                                            @ApiParam(value = "上传的文件", required = true)
                                            @RequestParam(value = "file", required = true) MultipartFile file
    ) throws ResponseException {

        // 文件本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        // 上传文件
        Map<String, Object> resultMap = qiniuUploadFileService.qiniuUpload(file, uploadPath, false);

        return new ResponseDto(ResponseStatusEnum.SUCCESS, resultMap);
    }
}
