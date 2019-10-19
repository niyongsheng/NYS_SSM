package com.niyongsheng.common.config;

/**
 * @author niyongsheng.com
 * @version $
 * @des 全局配置参数
 * @updateAuthor $
 * @updateDes
 */
public class AppRegularConfig {

    /**
     * 手机号正则表达式
     */
    public static final String REGEXP_PHONE = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";

    /**
     * 电话正则表达式
     */
    public final static String REGEXP_TELL = "^\\d{3}-\\d{8}|\\d{4}-\\d{7,8}$";

    /**
     * 中文正则表达式
     */
    public final static String REGEXP_CHINESE = "^[\u4e00-\u9fa5]+$";

    /**
     * 中英文+数字正则表达式
     */
    public final static String REGEXP_ABC_NUM_CN = "^[a-zA-Z0-9\u4e00-\u9fa5]+$";

    /**
     * 密码正则表达式，6-21字母和数字
     */
    public final static String REGEXP_PASSWORD = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";

    /**
     * 身份证正则表达式
     */
    public final static String REGEXP_IDCARD = "^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X)$";

    /**
     * 银行卡正则表达式
     */
    public final static String REGEXP_BANK = "^\\d{16,19}$";

    /**
     * QQ号码正则表达式
     */
    public final static String REGEXP_QQ = "^[1-9][0-9]{4,}$";

    /**
     * 日期正则表达式，2019-10-19
     */
    public final static String REGEXP_DATE = "^\\d{4}-\\d{1,2}-\\d{1,2}";

}
