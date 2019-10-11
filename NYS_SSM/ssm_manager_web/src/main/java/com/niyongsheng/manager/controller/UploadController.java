package com.niyongsheng.manager.controller;

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
    // 七牛云账号的ACCESS_KEY和SECRET_KEY
    @Value("${Qiniu.accessKey}")
    private String ACCESS_KEY;

    @Value("${Qiniu.secretKey}")
    private String SECRET_KEY;

    // 存储空间
    @Value("${Qiniu.bucketname}")
    private String bucketname;

    @Autowired
    private QiniuUploadFileUtil qiniuUploadFileUtil;

    @RequestMapping("/uploadPage")
    public String javaUpload() {
        return "uploadFile";
    }

    @RequestMapping("/qiniuUploadFile")
    @ResponseBody
    public Map<String, String> qiniuUploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
        // 获取当前路径
        String uploadPath = request.getSession().getServletContext().getRealPath("WEB-INF/classes/upload");
        return qiniuUploadFileUtil.qiniuUpload(file, uploadPath);
    }

    @RequestMapping("/qiniuUpload")
    @ResponseBody
    public Map<String, String> qiniuUpload(MultipartFile file, HttpServletRequest request) throws IOException {

        Map<String, String> map = new HashMap<String, String>();
        if (!file.isEmpty()) {
            // 获取当前路径
            String uploadPath = request.getSession().getServletContext().getRealPath("WEB-INF/classes/upload");
            String fileName = System.currentTimeMillis() + file.getOriginalFilename();
            String path = uploadPath + "\\" + fileName;
            file.transferTo(new File(path));
            map = qiniuUploadFileUtil.qiniuUpload(fileName, path);
        }
        return map;
    }
}
