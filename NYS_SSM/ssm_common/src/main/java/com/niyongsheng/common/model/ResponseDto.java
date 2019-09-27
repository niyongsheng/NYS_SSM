package com.niyongsheng.common.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.niyongsheng.common.enums.ResponseStatusEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@ApiModel
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ResponseDto<T> implements Serializable {

    @ApiModelProperty(value = "状态")
    private Boolean status;

    @ApiModelProperty(value = "状态信息")
    private String msg;

    @ApiModelProperty(value = "状态码")
    private Integer statusCode;

    @ApiModelProperty(value = "版本信息")
    private String version;

    @ApiModelProperty(value = "响应流信息")
    private T data;

    @Override
    public String toString() {
        return "ResponseDto{" +
                "status=" + status +
                ", msg='" + msg + '\'' +
                ", statusCode=" + statusCode +
                ", version='" + version + '\'' +
                ", data=" + data +
                '}';
    }

    public Boolean getStatus() {
        return status;
    }

    public String getMsg() {
        return msg;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public String getVersion() {
        return version;
    }

    public T getData() {
        return data;
    }

    public ResponseDto(){
        this.status = ResponseStatusEnum.FAIL.getStatus();
        this.msg = ResponseStatusEnum.FAIL.getStatusInfo();
        this.statusCode = ResponseStatusEnum.FAIL.getStatusCode();
        this.version = ResponseStatusEnum.FAIL.getVersion();
        this.data = null;
    }

    public ResponseDto(T data){
        this.status = ResponseStatusEnum.UNKNOWN.getStatus();
        this.msg = ResponseStatusEnum.UNKNOWN.getStatusInfo();
        this.statusCode = ResponseStatusEnum.UNKNOWN.getStatusCode();
        this.version = ResponseStatusEnum.UNKNOWN.getVersion();
        this.data = data;
    }

    public ResponseDto(ResponseStatusEnum statusEnum, T data) {
        this.status = statusEnum.getStatus();
        this.msg = statusEnum.getStatusInfo();
        this.statusCode = statusEnum.getStatusCode();
        this.version = statusEnum.getVersion();
        this.data = data;
    }
}
