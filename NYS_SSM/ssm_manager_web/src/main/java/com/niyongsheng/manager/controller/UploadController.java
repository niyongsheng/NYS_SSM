package com.niyongsheng.manager.controller;

import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.qiniu.QiniuUploadFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
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
    private QiniuUploadFileService qiniuUploadFileService;

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
        Map<String, Object> resultMap = qiniuUploadFileService.qiniuUpload(file, uploadPath, true);

        return resultMap;
    }

    @RequestMapping("/serviceUpload")
    @ResponseBody
    public Map<String, Object> serviceUpload(MultipartFile file, HttpServletRequest request) throws ResponseException {

        // 文件本地暂存绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("file");
        
        // 上传文件
        Map<String, Object> resultMap = qiniuUploadFileService.serviceUpload(file, uploadPath);

        return resultMap;
    }
}
