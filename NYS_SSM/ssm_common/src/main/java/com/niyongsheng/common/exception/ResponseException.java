package com.niyongsheng.common.exception;

import com.niyongsheng.common.enums.ResponseStatusEnum;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class ResponseException extends Exception {

    // 请求响应体状态枚举对象
    private ResponseStatusEnum responseStatusEnum;

    @Override
    public String toString() {
        return "ResponseException{" +
                "responseStatusEnum=" + responseStatusEnum +
                '}';
    }

    public ResponseStatusEnum getResponseStatusEnum() {
        return responseStatusEnum;
    }

    public ResponseException(ResponseStatusEnum responseStatusEnum) {
        this.responseStatusEnum = responseStatusEnum;
    }
}
