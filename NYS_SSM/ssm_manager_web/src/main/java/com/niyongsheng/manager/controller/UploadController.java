package com.niyongsheng.manager.controller;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.model.ResponseDto;
import com.niyongsheng.common.qiniu.QiniuUploadFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Controller
@RequestMapping("/upload")
public class UploadController {

    @Autowired
    private QiniuUploadFileUtil qiniuUploadFileUtil;

    @RequestMapping("/uploadPage")
    public String javaUpload() {
        return "uploadFile";
    }

    @RequestMapping("/qiniuUploadFile")
    @ResponseBody
    public Map<String, Object> qiniuUploadFile(MultipartFile file, HttpServletRequest request) throws ResponseException {
        
        // 文件本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        
        // 上传文件
        Map<String, Object> resultMap = qiniuUploadFileUtil.qiniuUpload(file, uploadPath, true);

        return resultMap;
    }

    @RequestMapping("/serviceUpload")
    @ResponseBody
    public Map<String, Object> serviceUpload(MultipartFile file, HttpServletRequest request) throws ResponseException {

        // 文件本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        
        // 上传文件
        Map<String, Object> resultMap = qiniuUploadFileUtil.serviceUpload(file, uploadPath);

        return resultMap;
    }
}
