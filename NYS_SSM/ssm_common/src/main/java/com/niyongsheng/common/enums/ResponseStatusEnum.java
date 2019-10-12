package com.niyongsheng.common.enums;

/**
 * @author niyongsheng.com
 * @version $
 * @des 响应体参数枚举类
 * @updateAuthor $
 * @updateDes
 */
public enum ResponseStatusEnum {

    /* 主要响应类型 */
    SUCCESS(true,2001,"成功"),
    FAIL(false,5001,"失败"),
    UNKNOWN(null,4001,"未知"),

    /* 人脸识别错误ASFR：ArcSoftFaceRecognition */
    ASFR_SYS_ERROR(false,7001,"人脸识别动态库不支持当前服务器系统环境,请部署到Linux或Windows环境。"),
    ASFR_ACTIVE_ERROR(false,7002,"人脸识别引擎激活失败"),
    ASFR_INIT_ERROR(false,7003,"人脸识别引擎初始化失败"),
    ASFR_DETECT_ERROR(false,7004,"未检测出有效的人脸信息"),
    ASFR_RECOGNITION_ERROR(false,7004,"识别人脸信息失败"),
    ASFR_PROCESS_ERROR(false,7005,"人脸属性检测失败"),
    ASFR_LIVENESS_ERROR(false,7006,"设置活体检测参数失败"),
    ASFR_ACTIVEFILE_ERROR(false,7007,"获取激活文件信息失败"),
    ASFR_UNINIT_ERROR(false,7008,"人脸识别引擎卸载失败"),
    ASFR_COMPARE_ERROR(false,7009,"人脸相似度对比失败"),

    ASFR_PARAM_ERROR(false,7010,"特征码格式不正确"),

    /* 文件读写错误 */
    IO_EMPTY_ERROR(false,1001,"空文件"),
    IO_TRANSFER_ERROR(false,1002,"文件转存失败"),
    IO_QNUPLOAD_ERROR(false,1003,"文件上传云服务器失败"),
    IO_IMGFORMAT_ERROR(false,1004,"非图片文件类型"),

    /* 参数错误 */
    PARAM_EMPTY_ERROR(false,2001,"参数为空"),
    PARAM_FORMAT_ERROR(false,2001,"参数格式不正确"),


    /* 系统错误❌ */
    SYS_ERROR(null,0,"系统错误");

    // *版本*
    private static String version = "1.0.0";
    // 状态
    private Boolean status;
    // 状态码
    private Integer statusCode;
    // 状态信息
    private String statusInfo;

    private ResponseStatusEnum(Boolean status, Integer statusCode, String statusInfo) {
        this.status = status;
        this.statusCode = statusCode;
        this.statusInfo = statusInfo;
    }

    public Boolean getStatus() {
        return status;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public String getStatusInfo() {
        return statusInfo;
    }

    public String getVersion() {
        return version;
    }

    /**
     * 根据状态码查询枚举对象
     * @param statusCode 状态码
     * @return
     */
    public static ResponseStatusEnum getResponseStatusEnumOfCode(Integer statusCode) {
        for (ResponseStatusEnum status : values()) {
            if (status.getStatusCode() == statusCode) {
                return status;
            }
        }
        return null;
    }
}
