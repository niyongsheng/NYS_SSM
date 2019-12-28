package com.niyongsheng.common.qiniu;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
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
public class QiniuUploadFileService {

    // 七牛云ACCESS_KEY
    @Value("${Qiniu.accessKey}")
    private String accessKey;

    // 七牛云SECRET_KEY
    @Value("${Qiniu.secretKey}")
    private String secretKey;

    // 存储空间
    @Value("${Qiniu.bucketname}")
    private String bucketname;

    // 外链域名
    @Value("${Qiniu.domain}")
    private String domain;


    /**
     * 上传文件到七牛☁
     * @param file 上传的文件
     * @param uploadPath 上传路径
     * @param isPersistSourceFile 是否保留服务器缓存文件
     * @return
     * @throws ResponseException
     */
    public Map<String, Object> qiniuUpload(String prefix, MultipartFile file, String uploadPath, Boolean isPersistSourceFile) throws ResponseException {
        // 0.文件合法性验证
        if (file.isEmpty()) {
            throw new ResponseException(ResponseStatusEnum.IO_EMPTY_ERROR);
        }

        // 1.密钥配置
        Auth auth = Auth.create(accessKey, secretKey);
        // 2.创建上传对象
        UploadManager uploadManager = new UploadManager(new Configuration());
        // 3.获取upToken
        String upToken = auth.uploadToken(bucketname);

        // 4.前缀+时间戳重命名并转存
        String fileName = prefix + System.currentTimeMillis() + "_" + file.getOriginalFilename();
        String filePath = uploadPath + File.separator + fileName;
        try {
            // 转存文件到服务器
            file.transferTo(new File(filePath));
        } catch (IOException e) {
            throw new ResponseException(ResponseStatusEnum.IO_TRANSFER_ERROR);
        }

        // 5.上传到七牛☁️
        Map<String, Object> map = new HashMap<>();
        try {
            Response response = uploadManager.put(filePath, fileName, upToken);
            System.out.println("**upload**response=" + response.bodyString());
            map.put("FileFullURL", domain + fileName);
            map.put("FileKey", fileName);
            map.put("info", response.toString());
        } catch (QiniuException e) {
            throw new ResponseException(ResponseStatusEnum.IO_QNUPLOAD_ERROR);
        } finally {
            // 上传七牛完成后判断是否删除本地缓存文件
            if (!isPersistSourceFile) {
                File deleteFile = new File(filePath);
                if (deleteFile.exists()) {
                    deleteFile.delete();
                }
            }
        }

        // 6.返回上传结果
        return map;
    }

    /**
     * 删除七牛☁单文件
     * @param key 文件key
     * @return
     * @throws ResponseException
     */
    public Integer qiniuDelete(String key) throws ResponseException {
        // 1.密钥配置
        Auth auth = Auth.create(accessKey, secretKey);
        //构造一个带指定 Region 对象的配置类
        Configuration cfg = new Configuration(Region.region0());
        // 2.文件管理器
        BucketManager bucketManager = new BucketManager(auth, cfg);

        Response delete = null;
        try {
            // 3.删除七牛☁文件
            delete = bucketManager.delete(bucketname, key);
        } catch (QiniuException e) {
            throw new ResponseException(ResponseStatusEnum.IO_QNDELETE_ERROR);
        }

        // 4.返回状态码
        return delete.statusCode;
    }


    /**
     * 文件上传到服务器
     * @param file
     * @param uploadPath
     * @return
     */
    public Map<String, Object> serviceUpload(MultipartFile file, String uploadPath) throws ResponseException {
        // 0.文件合法性验证
        if (file.isEmpty()) {
            throw new ResponseException(ResponseStatusEnum.IO_EMPTY_ERROR);
        }

        // A>开始时间
        long startTime = System.currentTimeMillis();
        System.out.println("**upload**开始时间:" + startTime);

        // 1.时间戳重命名并转存
        Map<String, Object> map = new HashMap<>();
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        String filePath = uploadPath + File.separator + fileName;

        map.put("filename", fileName);
        map.put("serviceUrl", filePath);

        try {
            // 转存文件到服务器
            file.transferTo(new File(filePath));
        } catch (IOException e) {
            throw new ResponseException(ResponseStatusEnum.IO_TRANSFER_ERROR);
        }

        // E>结束时间
        long endTime = System.currentTimeMillis();
        System.out.println("**upload**结束时间:" + endTime);
        System.out.println("**upload**用时:" + (endTime - startTime) + "ms");

        // 2.返回结果
        return map;
    }
}
