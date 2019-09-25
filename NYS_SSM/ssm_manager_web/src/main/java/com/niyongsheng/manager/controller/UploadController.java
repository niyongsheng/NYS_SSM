package com.niyongsheng.manager.controller;

import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
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

    @RequestMapping("/uploadPage")
    public String javaUpload() {
        return "qiniujavaupload";
    }

    @RequestMapping("/qiniuUpload")
    @ResponseBody
    public Map<String, String> qiniuUpload(MultipartFile file, HttpServletRequest request) throws IOException {
        // 设置好账号的ACCESS_KEY和SECRET_KEY
        String ACCESS_KEY = "kT93RyyRfkVBgned_N-xLjAlB3kobwGyt2aykgx2";
        String SECRET_KEY = "MVOQB-Nz2q55UA7p6H_MSJ3XkJrGrPyv_oSnbJtX";
        // 要上传的空间
        String bucketname = "daocaodui";
        // 上传到七牛后保存的文件名
        String key;
        // 上传文件的路径
        String FilePath;
        // 密钥配置
        Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
        // 自动识别要上传的空间的初村区域是华东、华北、华南
        Zone z = Zone.autoZone();
        com.qiniu.storage.Configuration c = new com.qiniu.storage.Configuration(z);
        // 创建上传对象
        UploadManager uploadManager = new UploadManager(c);
        // 外链域名
        String domian = "http://daocaodui.org";
        // 获取upToken
        String upToken = auth.uploadToken(bucketname);
        // 开始时间
        long startTime = System.currentTimeMillis();
        String timeString = String.valueOf(startTime);
        System.out.println("______________开始时间:" + startTime);
        Map<String, String> map = new HashMap<String, String>();
        System.out.println("______________文件名:" + file.getOriginalFilename());
        // 获取当前路径
        String uploadPath = request.getSession().getServletContext().getRealPath("WEB-INF/classes/upload");
        System.out.println("______________路径:" + uploadPath);

        if (!file.isEmpty()) {
            String fileName = timeString + file.getOriginalFilename();
            String path = uploadPath + "\\" + fileName;
            file.transferTo(new File(path));
            key = fileName;
            FilePath = path;
            // 上传到七牛
            // 调用put方法
            try {
                Response response = uploadManager.put(FilePath, key, upToken);
                System.out.println("___________________response=" + response.bodyString());
                map.put("state", "1");
                map.put("info", "上传七牛成功");
                map.put("fileName", fileName);
                map.put("qiniuUrl", domian + "/" + fileName);

            } catch (QiniuException e) {
                map.put("state", "0");
                map.put("info", "上传七牛失败");
                Response r = e.response;
                System.out.println("上传七牛异常=" + r.toString());

            } finally {
                // 上传七牛完成后删除本地文件
                File deleteFile = new File(path, fileName);
                if (deleteFile.exists()) {
                    deleteFile.delete();
                }
            }
        }
        // 结束时间
        long endTime = System.currentTimeMillis();
        System.out.println("______________用时:" + (endTime - startTime) + "ms");
        return map;
    }
}
