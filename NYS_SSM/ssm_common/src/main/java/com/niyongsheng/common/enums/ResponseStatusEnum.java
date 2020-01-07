package com.niyongsheng.common.enums;

import com.google.common.collect.Lists;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /* 成功 */
    AUTH_LOGIN_SUCESS(true,2001,"登陆成功"),
    AUTH_LOGOUT_SUCESS(true,2001,"登出成功"),
    AUTH_REGISTER_SUCESS(true,2001,"注册成功"),
    AUTH_RESET_SUCESS(true,2001,"重置成功"),
    AUTH_UPDATE_SUCESS(true,2001,"修改成功"),
    AUTH_ONCECODE_SUCESS(true,2001,"验证码已发送"),

    /* 文件读写错误 */
    IO_EMPTY_ERROR(false,1001,"空文件"),
    IO_TRANSFER_ERROR(false,1002,"文件转存失败"),
    IO_QNUPLOAD_ERROR(false,1003,"文件上传云服务器失败"),
    IO_IMGFORMAT_ERROR(false,1004,"非图片文件类型"),
    IO_QNDELETE_ERROR(false,1005,"删除云服务器文件失败"),

    /* 数据库 */
    DB_TR_ERROR(false,2111,"数据库事务管理出错"),
    DB_INSERT_ERROR(false,2011,"数据库写入出错"),
    DB_DELETE_ERROR(false,2012,"数据库删除出错"),
    DB_UPDATE_ERROR(false,2013,"数据库更新出错"),
    DB_SELECT_ERROR(false,2014,"数据库查询出错"),

    /* Redis */
    REDIS_INSERT_ERROR(false,2015,"Redis写入出错"),
    REDIS_DELETE_ERROR(false,2016,"Redis删除出错"),
    REDIS_UPDATE_ERROR(false,2017,"Redis更新出错"),
    REDIS_SELECT_ERROR(false,2018,"Redis查询出错"),

    /* 参数错误 */
    PARAM_EMPTY_ERROR(false,3001,"参数为空"),
    PARAM_FORMAT_ERROR(false,3002,"参数格式不正确"),
    PARAM_CONVERSION_ERROR(false,3003,"参数格式转换失败"),

    /* Auth错误 */
    AUTH_UNEXISTENT_ERROR(false,6001,"用户不存在"),
    AUTH_PASSWORD_ERROR(false,6002,"密码错误"),
    AUTH_ONCECODE_ERROR(false,6003,"验证码错误"),
    AUTH_2PASSWORD_ERROR(false,6004,"密码不一致"),
    AUTH_EXPIRE_ERROR(false,6005,"Token已失效"),
    AUTH_NULL_ERROR(false,6006,"Token或Account为空"),
    AUTH_VERIFY_ERROR(false,6007,"Token与Account不匹配"),
    AUTH_STATUS_ERROR(false,6008,"用户已禁用,请联系管理员!"),
    AUTH_REPEAT_ERROR(false,6009,"该手机号已注册"),
    AUTH_UNLOGIN_ERROR(false,6010,"未登录"),
//    AUTH_ACCOUNTDIFFER_ERROR(false,6011,"Token与不匹配"),

    /* 群组错误 */
    GROUP_UNEXISTENT_ERROR(false,6011,"群组不存在"),


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

    /* 七牛云错误 */
    QINIU_GETSMS_ERROR(false,8001,"获取验证码失败"),

    /* 融云错误 */
    RONGCLOUD_GET_TOKEN_ERROR(false,9001,"获取IMToken失败"),
    RONGCLOUD_CREATE_GROUP_ERROR(false,9002,"创建群组失败"),
    RONGCLOUD_DISMISS_GROUP_ERROR(false,9003,"解散群组失败"),
    RONGCLOUD_JOIN_GROUP_ERROR(false,9004,"加入群组失败"),
    RONGCLOUD_QUIT_GROUP_ERROR(false,9005,"退出群组失败"),
    RONGCLOUD_DISMISS_GROUP_OWNER_ERROR(false,9006,"非群主不能结束活动"),

    RONGCLOUD_STATUS_CODE_GROUP_ERROR(false,9010,"群组状态码错误"),
    RONGCLOUD_STATUS_CODE_CREATE_GROUP_ERROR(false,9011,"创建群组出错"),
    RONGCLOUD_STATUS_CODE_DISMISS_GROUP_ERROR(false,9012,"解散群组出错"),
    RONGCLOUD_STATUS_CODE_JOIN_GROUP_ERROR(false,9013,"加入群组出错"),
    RONGCLOUD_STATUS_CODE_QUIT_GROUP_ERROR(false,9014,"退出群组出错"),

    /* 活动错误 */
    ACTIVITY_STATUS_MEMBER_ERROR(false,10001,"您还不是活动成员，请先报名！"),
    ACTIVITY_STATUS_RECLOCK_ERROR(false,10002,"您今天已经打卡，明天再来吧！"),

    /* 签到错误 */
    SCORE_STATUS_RESIGN_ERROR(false,20001,"您今天已经签到，明天再来吧！"),

    /* 系统错误❌ */
    SYS_ERROR(null,0,"系统错误");

    // *版本*
    private static String version = "NYS_SSM_DCD#1.0.0";
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

/*    ResponseStatusEnum(String statusInfo) {
        this.status = false;
        this.statusCode = 0000;
        this.statusInfo = statusInfo;
    }*/

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

    /**
     * 遍历枚举
     * @return
     */
    public static List toList() {
        List list = Lists.newArrayList();
        for (ResponseStatusEnum responseStatusEnum : ResponseStatusEnum.values()) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("status", responseStatusEnum.getStatus());
            map.put("code", responseStatusEnum.getStatusCode());
            map.put("info", responseStatusEnum.getStatusInfo());
            map.put("version", responseStatusEnum.getVersion());
            list.add(map);
        }
        return list;
    }
}
