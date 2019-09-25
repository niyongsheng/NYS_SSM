package com.niyongsheng.common.utils;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

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
@Component
public class QiniuUploadFileUtil {

    // 七牛云ACCESS_KEY
    @Value("${qiniu.accessKey}")
    private String accessKey;

    // 七牛云SECRET_KEY
    @Value("${qiniu.secretKey}")
    private String secretKey;

    // 存储空间
    @Value("${qiniu.bucketname}")
    private String bucketname;

    // 外链域名
    @Value("${qiniu.domain}")
    private String domain;

    /**
     * 上传文件
     *
     * @param file 文件
     * @param uploadPath 当前路径
     * @return
     * @throws IOException
     */
    public Map<String, String> qiniuUpload(MultipartFile file, String uploadPath) throws IOException {
        // 上传到七牛后保存的文件名
        String key;
        // 上传文件的路径
        String FilePath;
        // 密钥配置
        Auth auth = Auth.create(accessKey, secretKey);
        // 创建上传对象
        UploadManager uploadManager = new UploadManager(new Configuration());
        // 获取upToken
        String upToken = auth.uploadToken(bucketname);
        // 开始时间
        long startTime = System.currentTimeMillis();
        String timeString = String.valueOf(startTime);
        System.out.println("**upload**开始时间:" + startTime);
        Map<String, String> map = new HashMap<String, String>();
        System.out.println("**upload**文件名:" + file.getOriginalFilename());
        System.out.println("**upload**路径:" + uploadPath);

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
                System.out.println("**upload**response=" + response.bodyString());
                map.put("state", "1");
                map.put("info", "上传七牛成功");
                map.put("fileName", fileName);
                map.put("qiniuUrl", domain + "/" + fileName);
                map.put("msg", response.toString());
            } catch (QiniuException e) {
                map.put("state", "0");
                map.put("info", "上传七牛失败");
                Response r = e.response;
                map.put("msg", r.toString());
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
        System.out.println("**upload**结束时间:" + endTime);
        System.out.println("**upload**用时:" + (endTime - startTime) + "ms");
        return map;
    }

    /**
     * 文件上传
     * @param key 文件名
     * @param FilePath 路径
     * @return
     */
    public Map<String, String> qiniuUpload(String key, String FilePath) {

        // 密钥配置
        Auth auth = Auth.create(accessKey, secretKey);
        // 创建上传对象
        UploadManager uploadManager = new UploadManager(new Configuration());
        // 获取upToken
        String upToken = auth.uploadToken(bucketname);
        // 开始时间
        long startTime = System.currentTimeMillis();
        String timeString = String.valueOf(startTime);
        System.out.println("**upload**开始时间:" + startTime);
        Map<String, String> map = new HashMap<String, String>();
        System.out.println("**upload**文件名:" + key);
        System.out.println("**upload**路径:" + FilePath);

        // 调用put方法上传到七牛云
        try {
            Response response = uploadManager.put(FilePath, key, upToken);
            System.out.println("**upload**response=" + response.bodyString());
            map.put("state", "1");
            map.put("info", "上传七牛成功");
            map.put("fileName", key);
            map.put("qiniuUrl", domain + "/" + key);
            map.put("msg", response.toString());
        } catch (QiniuException e) {
            map.put("state", "0");
            map.put("info", "上传七牛失败");
            Response r = e.response;
            map.put("msg", r.toString());
            System.out.println("上传七牛异常=" + r.toString());
        } finally {
            // 上传七牛完成后删除本地文件
            File deleteFile = new File(FilePath, key);
            if (deleteFile.exists()) {
                deleteFile.delete();
            }
        }

        // 结束时间
        long endTime = System.currentTimeMillis();
        System.out.println("**upload**结束时间:" + endTime);
        System.out.println("**upload**用时:" + (endTime - startTime) + "ms");
        return map;
    }
}
