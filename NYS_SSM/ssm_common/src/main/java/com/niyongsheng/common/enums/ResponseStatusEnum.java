package com.niyongsheng.common.enums;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public enum ResponseStatusEnum {

    SUCCESS(true,7001,"成功"),
    FAIL(false,7002,"失败"),
    UNKNOWN(null,7000,"未知");

    // 版本*
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
     * 根据索引查询异常信息对象
     * @param index
     * @return
     */
    public static ResponseStatusEnum statusOfCode(Integer index) {
        for (ResponseStatusEnum status : values()) {
            if (status.getStatusCode() == index) {
                return status;
            }
        }
        return null;
    }
}
