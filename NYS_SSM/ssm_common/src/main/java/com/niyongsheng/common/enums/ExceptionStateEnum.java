package com.niyongsheng.common.enums;

/**
 * @author niyongsheng.com
 * @version $
 * @des 异常状态枚举表述常量数据字典
 * @updateAuthor $
 * @updateDes
 */
public enum ExceptionStateEnum {

    SUCCESS(70001,"成功"),
    FAIL(70002,"失败"),
    UNKNOWN(70003,"未知");

    // 状态码
    private Integer stateCode;
    // 状态信息
    private String stateInfo;

    private ExceptionStateEnum(Integer stateCode, String stateInfo) {
        this.stateCode = stateCode;
        this.stateInfo = stateInfo;
    }

    public Integer getStateCode() {
        return stateCode;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    /**
     * 根据索引查询异常信息对象
     * @param index
     * @return
     */
    public static ExceptionStateEnum stateOf(int index) {
        for (ExceptionStateEnum state : values()) {
            if (state.getStateCode() == index) {
                return state;
            }
        }
        return null;
    }
}
