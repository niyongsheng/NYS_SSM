package com.niyongsheng.application.arcSoft;

import com.arcsoft.face.*;
import com.arcsoft.face.enums.DetectMode;
import com.arcsoft.face.enums.DetectOrient;
import com.arcsoft.face.enums.ErrorInfo;
import com.arcsoft.face.enums.ImageFormat;
import com.arcsoft.face.toolkit.ImageFactory;
import com.arcsoft.face.toolkit.ImageInfo;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import com.niyongsheng.common.utils.FileUtils;
import com.niyongsheng.persistence.domain.Face;
import org.springframework.beans.factory.annotation.Value;

import java.io.File;
import java.time.LocalDateTime;
import java.util.*;

/**
 * @author niyongsheng.com
 * @version $
 * @des 虹软人脸识别
 * @updateAuthor $
 * @updateDes
 */
public class ArcSoftFaceRecognition {

    // 虹软APP_KEY
    @Value("${ArcSoft.appID}")
    private String appId;

    // 虹软APP_KEY(windows)
    @Value("${ArcSoft.appKeyWindows}")
    private String appKeyWindows;

    // 虹软APP_KEY(linux)
    @Value("${ArcSoft.appKeyLinux}")
    private String appKeyLinux;

    // RGB活体检测阈值
    @Value("${ArcSoft.rgbThreshold}")
    private float rgbThreshold;

    // IR活体检测阈值
    @Value("${ArcSoft.irThreshold}")
    private float irThreshold;

    /**
     * 初始化人脸引擎
     *
     * @param dibPath
     * @return
     */
    private FaceEngine initFaceEngine(String dibPath) throws ResponseException {
        // 0.系统环境判断
        String os = System.getProperty("os.name");
        if (!os.toLowerCase().startsWith("win") && !os.toLowerCase().startsWith("lin")) {
            throw new ResponseException(ResponseStatusEnum.ASFR_SYS_ERROR);
        }

        // 1.创建引擎
        FaceEngine faceEngine = new FaceEngine(dibPath);

        // 2.激活引擎
        String appKey = null;
        if (os.toLowerCase().startsWith("win")) {
            appKey = appKeyWindows;
        } else if (os.toLowerCase().startsWith("lin")) {
            appKey = appKeyLinux;
        }
        int activeCode = faceEngine.activeOnline(appId, appKey);

        if (activeCode != ErrorInfo.MOK.getValue() && activeCode != ErrorInfo.MERR_ASF_ALREADY_ACTIVATED.getValue()) {
            System.out.println("引擎激活失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_ACTIVE_ERROR);
        }

        // 3.引擎配置
        EngineConfiguration engineConfiguration = new EngineConfiguration();
        engineConfiguration.setDetectMode(DetectMode.ASF_DETECT_MODE_IMAGE);
        engineConfiguration.setDetectFaceOrientPriority(DetectOrient.ASF_OP_0_ONLY);

        // 4.功能配置
        FunctionConfiguration functionConfiguration = new FunctionConfiguration();
        functionConfiguration.setSupportAge(true);
        functionConfiguration.setSupportFace3dAngle(true);
        functionConfiguration.setSupportFaceDetect(true);
        functionConfiguration.setSupportFaceRecognition(true);
        functionConfiguration.setSupportGender(true);
        functionConfiguration.setSupportLiveness(true);
        functionConfiguration.setSupportIRLiveness(true);
        engineConfiguration.setFunctionConfiguration(functionConfiguration);

        // 5.初始化引擎
        int initCode = faceEngine.init(engineConfiguration);
        if (initCode != ErrorInfo.MOK.getValue()) {
            System.out.println("初始化引擎失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_INIT_ERROR);
        }

        return faceEngine;
    }

    /**
     * 人脸信息检测
     * @param dibPath
     * @param faceImagePath
     * @return
     * @throws ResponseException
     */
    public List<Face> getFaceFeature(String dibPath, String faceImagePath) throws ResponseException {
        // 1.初始化引擎
        FaceEngine faceEngine = this.initFaceEngine(dibPath);

        // 2.获取人脸特征
        List<Face> faceList = this.getSigleFaceFeature(faceEngine, faceImagePath);

        // 4.引擎卸载
        int unInitCode = faceEngine.unInit();
        if (unInitCode != ErrorInfo.MOK.getValue()) {
            throw new ResponseException(ResponseStatusEnum.ASFR_UNINIT_ERROR);
        }

        // 5.人脸特征信息列表
        return faceList;
    }

    /**
     * 对比两张人脸相似度
     * @param dibPath
     * @param faceImagePath1
     * @param faceImagePath2
     * @return
     * @throws ResponseException
     */
    public Map compareFaceFeature(String dibPath, String faceImagePath1, String faceImagePath2) throws ResponseException {
        // 1.初始化引擎
        FaceEngine faceEngine = this.initFaceEngine(dibPath);
        Map<Object, Object> map = new HashMap<>();

        // 2.获取人脸特征
        List<Face> faceList1 = this.getSigleFaceFeature(faceEngine, faceImagePath1);
        List<Face> faceList2 = this.getSigleFaceFeature(faceEngine, faceImagePath2);
        map.put("faceList1", faceList1);
        map.put("faceList2", faceList2);

        // 2.获取人脸特征码(如果图片中存在多张人脸默认对比最前的人脸)
        byte[] featureData1 = Base64.getDecoder().decode(faceList1.get(0).getFaceCode());
        byte[] featureData2 = Base64.getDecoder().decode(faceList2.get(0).getFaceCode());

        // 特征比对
        FaceFeature targetFaceFeature = new FaceFeature();
        targetFaceFeature.setFeatureData(featureData1);
        FaceFeature sourceFaceFeature = new FaceFeature();
        sourceFaceFeature.setFeatureData(featureData2);
        FaceSimilar faceSimilar = new FaceSimilar();
        int compareCode = faceEngine.compareFaceFeature(targetFaceFeature, sourceFaceFeature, faceSimilar);
        if (compareCode != ErrorInfo.MOK.getValue()) {
            throw new ResponseException(ResponseStatusEnum.ASFR_COMPARE_ERROR);
        }
        map.put("similarity", faceSimilar.getScore());
        System.out.println("相似度：" + faceSimilar.getScore());

        // 7.引擎卸载
        int unInitCode = faceEngine.unInit();
        if (unInitCode != ErrorInfo.MOK.getValue()) {
            throw new ResponseException(ResponseStatusEnum.ASFR_UNINIT_ERROR);
        }

        // 8.返回结果
        return map;
    }

    /**
     * 对比两个人脸特征码相似度
     * @param dibPath
     * @param faceCode1
     * @param faceCode2
     * @return
     * @throws ResponseException
     */
    public Map compareFaceFeatureCode(String dibPath, String faceCode1, String faceCode2) throws ResponseException {
        // 1.初始化引擎
        FaceEngine faceEngine = this.initFaceEngine(dibPath);

        // 2.特征码
        byte[] featureData1 = Base64.getDecoder().decode(faceCode1);
        byte[] featureData2 = Base64.getDecoder().decode(faceCode2);

        // 3.特征比对
        FaceFeature targetFaceFeature = new FaceFeature();
        targetFaceFeature.setFeatureData(featureData1);
        FaceFeature sourceFaceFeature = new FaceFeature();
        sourceFaceFeature.setFeatureData(featureData2);
        FaceSimilar faceSimilar = new FaceSimilar();
        int compareCode = faceEngine.compareFaceFeature(targetFaceFeature, sourceFaceFeature, faceSimilar);
        if (compareCode != ErrorInfo.MOK.getValue()) {
            throw new ResponseException(ResponseStatusEnum.ASFR_COMPARE_ERROR);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("similarity", faceSimilar.getScore());
        System.out.println("相似度：" + faceSimilar.getScore());

        // 4.引擎卸载
        int unInitCode = faceEngine.unInit();
        if (unInitCode != ErrorInfo.MOK.getValue()) {
            throw new ResponseException(ResponseStatusEnum.ASFR_UNINIT_ERROR);
        }

        // 5.返回相似度
        return map;
    }

    /**
     * IR人脸特征和活体检测
     * @param dibPath
     * @param IRFaceImagePath
     * @return
     * @throws ResponseException
     */
    public List<Face> getIRFaceFeature(String dibPath, String IRFaceImagePath) throws ResponseException {
        // 1.初始化引擎
        FaceEngine faceEngine = this.initFaceEngine(dibPath);

        // 2.IR属性处理
        File IRFaceImageFile = new File(IRFaceImagePath);
        if (!FileUtils.isImage(IRFaceImageFile)) {
            throw new ResponseException(ResponseStatusEnum.IO_IMGFORMAT_ERROR);
        }
        ImageInfo imageInfoGray = ImageFactory.getGrayData(IRFaceImageFile);
        List<FaceInfo> faceInfoListGray = new ArrayList<FaceInfo>();
        int detectCodeGray = faceEngine.detectFaces(imageInfoGray.getImageData(), imageInfoGray.getWidth(), imageInfoGray.getHeight(), ImageFormat.CP_PAF_GRAY, faceInfoListGray);
        if (detectCodeGray != ErrorInfo.MOK.getValue()) {
            System.out.println("识别人脸信息失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_RECOGNITION_ERROR);
        }
        if (faceInfoListGray.size() == 0) {
            System.out.println("未检测出有效的人脸信息");
            throw new ResponseException(ResponseStatusEnum.ASFR_DETECT_ERROR);
        }

        // 3.IR属性检测配置
        FunctionConfiguration configuration = new FunctionConfiguration();
        configuration.setSupportIRLiveness(true);
        int processCode = faceEngine.processIr(imageInfoGray.getImageData(), imageInfoGray.getWidth(), imageInfoGray.getHeight(), ImageFormat.CP_PAF_GRAY, faceInfoListGray, configuration);
        if (processCode != ErrorInfo.MOK.getValue()) {
            System.out.println("IR:人脸属性检测失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_PROCESS_ERROR);
        }

        // 4.IR设置活体检测参数
        int paramCode = faceEngine.setLivenessParam(rgbThreshold, irThreshold);
        if (paramCode != ErrorInfo.MOK.getValue()) {
            System.out.println("IR:设置活体检测参数失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_LIVENESS_ERROR);
        }

        // 5..检测人脸信息
        List<Face> faceList = new ArrayList<Face>();
        for (int i = 0; i < faceInfoListGray.size(); i++) {
            FaceInfo faceInfoGray = faceInfoListGray.get(i);
            Face face = new Face();
            face.setId(i);
            face.setFaceRect(faceInfoGray.getRect().toString());
            face.setFaceOrient(faceInfoGray.getOrient());
            face.setGmtCreate(LocalDateTime.now());

            // 5.1特征码提取
            FaceFeature faceFeature = new FaceFeature();
            int extractCode = faceEngine.extractFaceFeature(imageInfoGray.getImageData(), imageInfoGray.getWidth(), imageInfoGray.getHeight(), ImageFormat.CP_PAF_GRAY, faceInfoGray, faceFeature);
            if (extractCode == ErrorInfo.MOK.getValue()) {
                String faceCode = Base64.getEncoder().encodeToString(faceFeature.getFeatureData());
                System.out.println("特征值大小：" + faceFeature.getFeatureData().length + "\n" + "特征值：" + faceCode);
                face.setFaceCode(faceCode);
            }

            // 5.2IR活体检测
            List<IrLivenessInfo> irLivenessInfo = new ArrayList<>();
            int livenessIr = faceEngine.getLivenessIr(irLivenessInfo);
            if (livenessIr == ErrorInfo.MOK.getValue()) {
                Integer liveness = irLivenessInfo.get(i).getLiveness();
                System.out.println("IR活体：" + liveness);
                Boolean livenessBool = (liveness == 1) ? true : false;
                face.setLiveness(livenessBool);
            }

            faceList.add(face);
        }

        // 6.引擎卸载
        int unInitCode = faceEngine.unInit();
        if (unInitCode != ErrorInfo.MOK.getValue()) {
            throw new ResponseException(ResponseStatusEnum.ASFR_UNINIT_ERROR);
        }

        // 7.IR人脸信息列表
        return faceList;
    }

    /**
     * RGB获取单张人脸特征信息
     * @param faceEngine
     * @param faceImagePath
     * @return
     * @throws ResponseException
     */
    private List<Face> getSigleFaceFeature(FaceEngine faceEngine, String faceImagePath) throws ResponseException {
        // 1.获取人脸信息
        System.out.println("--++imagePath1++--:" + faceImagePath);
        File faceImageFile = new File(faceImagePath);
        if (!FileUtils.isImage(faceImageFile)) {
            throw new ResponseException(ResponseStatusEnum.IO_IMGFORMAT_ERROR);
        }
        ImageInfo imageInfo = ImageFactory.getRGBData(faceImageFile);

        // 2.人脸检测
        List<FaceInfo> faceInfoList = new ArrayList<FaceInfo>();
        int detectCode = faceEngine.detectFaces(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList);
        if (detectCode != ErrorInfo.MOK.getValue()) {
            System.out.println("识别人脸信息失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_RECOGNITION_ERROR);
        }
        if (faceInfoList.size() == 0) {
            System.out.println("未检测出有效的人脸信息");
            throw new ResponseException(ResponseStatusEnum.ASFR_DETECT_ERROR);
        }

        // 3.人脸属性检测配置
        FunctionConfiguration configuration = new FunctionConfiguration();
        configuration.setSupportAge(true);
        configuration.setSupportFace3dAngle(true);
        configuration.setSupportGender(true);
        configuration.setSupportLiveness(true);
        int processCode = faceEngine.process(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList, configuration);
        if (processCode != ErrorInfo.MOK.getValue()) {
            System.out.println("人脸属性检测失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_PROCESS_ERROR);
        }

        // 4.设置活体检测参数
        int paramCode = faceEngine.setLivenessParam(rgbThreshold, irThreshold);
        if (paramCode != ErrorInfo.MOK.getValue()) {
            System.out.println("设置活体检测参数失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_LIVENESS_ERROR);
        }

        // 5.获取激活文件信息
        ActiveFileInfo activeFileInfo = new ActiveFileInfo();
        int activeFileCode = faceEngine.getActiveFileInfo(activeFileInfo);
        if (activeFileCode != ErrorInfo.MOK.getValue()) {
            System.out.println("获取激活文件信息失败");
            throw new ResponseException(ResponseStatusEnum.ASFR_ACTIVEFILE_ERROR);
        }

        // 6.检测人脸信息
        List<Face> faceList = new ArrayList<Face>();
        for (int i = 0; i < faceInfoList.size(); i++) {
            FaceInfo faceInfo = faceInfoList.get(i);
            Face face = new Face();
            face.setId(i);
            face.setFaceRect(faceInfo.getRect().toString());
            face.setFaceOrient(faceInfo.getOrient());
            face.setGmtCreate(LocalDateTime.now());

            // 6.1特征码提取
            FaceFeature faceFeature = new FaceFeature();
            int extractCode = faceEngine.extractFaceFeature(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfo, faceFeature);
            if (extractCode == ErrorInfo.MOK.getValue()) {
                String faceCode = Base64.getEncoder().encodeToString(faceFeature.getFeatureData());
                System.out.println("特征值大小：" + faceFeature.getFeatureData().length + "\n" + "特征值：" + faceCode);
                face.setFaceCode(faceCode);
            }

            // 6.2性别检测
            List<GenderInfo> genderInfoList = new ArrayList<GenderInfo>();
            int genderCode = faceEngine.getGender(genderInfoList);
            if (genderCode == ErrorInfo.MOK.getValue()) {
                Integer gender = genderInfoList.get(i).getGender();
                String genderStr = (gender == 0) ? "male" : "female";
                System.out.println("性别：" + genderStr);
                face.setGender(genderStr);
            }

            // 6.3年龄检测
            List<AgeInfo> ageInfoList = new ArrayList<AgeInfo>();
            int ageCode = faceEngine.getAge(ageInfoList);
            if (ageCode == ErrorInfo.MOK.getValue()) {
                Integer age = ageInfoList.get(i).getAge();
                System.out.println("年龄：" + age);
                face.setAge(age);
            }

            // 6.43D信息检测
            List<Face3DAngle> face3DAngleList = new ArrayList<Face3DAngle>();
            int face3dCode = faceEngine.getFace3DAngle(face3DAngleList);
            if (face3dCode == ErrorInfo.MOK.getValue()) {
                String face3D = face3DAngleList.get(i).getPitch() + "," + face3DAngleList.get(i).getRoll() + "," + face3DAngleList.get(i).getYaw();
                System.out.println("3D角度：" + face3D);
                face.setFace3D(face3D);
            }

            // 6.5活体检测
            List<LivenessInfo> livenessInfoList = new ArrayList<LivenessInfo>();
            int livenessCode = faceEngine.getLiveness(livenessInfoList);
            if (livenessCode == ErrorInfo.MOK.getValue()) {
                Integer liveness = livenessInfoList.get(i).getLiveness();
                System.out.println("活体：" + liveness);
                Boolean livenessBool = (liveness == 1) ? true : false;
                face.setLiveness(livenessBool);
            }

            faceList.add(face);
        }

        // 7.返回人脸信息列表
        return faceList;
    }

}
