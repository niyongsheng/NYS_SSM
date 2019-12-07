package com.niyongsheng.persistence.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
//@JsonIgnoreProperties({ "handler","hibernateLazyInitializer" }) // 忽略参数
@ApiModel(value ="Face")
public class Face implements Serializable{

    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "团契")
    private Integer fellowship;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "1活体0非活体")
    private Boolean liveness;

    @ApiModelProperty(value = "脸部位置(x,y,w,h)")
    private String faceRect;

    @ApiModelProperty(value = "脸部方向")
    private Integer faceOrient;

    @ApiModelProperty(value = "3D角度信息(x,z,y)(点头,歪头,摇头)")
    private String face3D;

    @ApiModelProperty(value = "脸部特征码")
    private String faceCode;

    @ApiModelProperty(value = "网络位置")
    private String faceUrl;

    @ApiModelProperty(value = "脸部图像base64")
    private String faceBase64;

    @ApiModelProperty(value = "脸部图像")
    private String facePhoto;

    @ApiModelProperty(value = "年龄")
    private Integer age;

    @ApiModelProperty(value = "性别性别:male/female")
    private String gender;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date gmtModify;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date gmtCreate;
}