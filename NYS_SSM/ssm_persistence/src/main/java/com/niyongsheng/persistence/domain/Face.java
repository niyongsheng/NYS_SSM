package com.niyongsheng.persistence.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
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

    @Override
    public String toString() {
        return "Face{" +
                "id=" + id +
                ", account='" + account + '\'' +
                ", fellowship=" + fellowship +
                ", nickname='" + nickname + '\'' +
                ", liveness=" + liveness +
                ", faceRect='" + faceRect + '\'' +
                ", faceOrient=" + faceOrient +
                ", face3D='" + face3D + '\'' +
                ", faceCode='" + faceCode + '\'' +
                ", faceUrl='" + faceUrl + '\'' +
                ", faceBase64='" + faceBase64 + '\'' +
                ", facePhoto='" + facePhoto + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                ", gmtModify=" + gmtModify +
                ", gmtCreate=" + gmtCreate +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }


    public Integer getFellowship() {
        return fellowship;
    }

    public void setFellowship(Integer fellowship) {
        this.fellowship = fellowship;
    }


    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }


    public Boolean getLiveness() {
        return liveness;
    }

    public void setLiveness(Boolean liveness) {
        this.liveness = liveness;
    }


    public String getFaceRect() {
        return faceRect;
    }

    public void setFaceRect(String faceRect) {
        this.faceRect = faceRect;
    }


    public Integer getFaceOrient() {
        return faceOrient;
    }

    public void setFaceOrient(Integer faceOrient) {
        this.faceOrient = faceOrient;
    }


    public String getFace3D() {
        return face3D;
    }

    public void setFace3D(String face3D) {
        this.face3D = face3D;
    }


    public String getFaceCode() {
        return faceCode;
    }

    public void setFaceCode(String faceCode) {
        this.faceCode = faceCode;
    }


    public String getFaceUrl() {
        return faceUrl;
    }

    public void setFaceUrl(String faceUrl) {
        this.faceUrl = faceUrl;
    }


    public String getFaceBase64() {
        return faceBase64;
    }

    public void setFaceBase64(String faceBase64) {
        this.faceBase64 = faceBase64;
    }


    public String getFacePhoto() {
        return facePhoto;
    }

    public void setFacePhoto(String facePhoto) {
        this.facePhoto = facePhoto;
    }


    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }


    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }


    public java.util.Date getGmtModify() {
        return gmtModify;
    }

    public void setGmtModify(java.util.Date gmtModify) {
        this.gmtModify = gmtModify;
    }


    public java.util.Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(java.util.Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

}