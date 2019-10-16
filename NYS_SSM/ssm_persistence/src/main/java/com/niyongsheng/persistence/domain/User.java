package com.niyongsheng.persistence.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

@ApiModel(value ="User")
public class User implements Serializable{

    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "真实姓名")
    private String truename;

    @ApiModelProperty(value = "头像")
    private String icon;

    @ApiModelProperty(value = "等级")
    private Integer grade;

    @ApiModelProperty(value = "积分")
    private Double score;

    @ApiModelProperty(value = "性别")
    private String gender;

    @ApiModelProperty(value = "手机号")
    private String phone;

    @ApiModelProperty(value = "密码")
    private String password;

    @ApiModelProperty(value = "登录令牌")
    private String token;

    @ApiModelProperty(value = "IM令牌")
    private String imToken;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "简介")
    private String introduction;

    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "地址")
    private String address;

    @ApiModelProperty(value = "团契")
    private Integer fellowship;

    @ApiModelProperty(value = "身份类型")
    private Integer profession;

    @ApiModelProperty(value = "QQ")
    private String qqOpenid;

    @ApiModelProperty(value = "微信")
    private String wcOpenid;

    @ApiModelProperty(value = "1有效0失效")
    private Boolean status;

    @ApiModelProperty(value = "生日")
    private java.util.Date birthday;

    @ApiModelProperty(value = "修改时间")
    private java.util.Date gmtModify;

    @ApiModelProperty(value = "创建时间")
    private java.util.Date gmtCreate;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", account='" + account + '\'' +
                ", truename='" + truename + '\'' +
                ", icon='" + icon + '\'' +
                ", grade=" + grade +
                ", score=" + score +
                ", gender='" + gender + '\'' +
                ", phone='" + phone + '\'' +
                ", password='" + password + '\'' +
                ", token='" + token + '\'' +
                ", imToken='" + imToken + '\'' +
                ", nickname='" + nickname + '\'' +
                ", introduction='" + introduction + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", fellowship=" + fellowship +
                ", profession=" + profession +
                ", qqOpenid='" + qqOpenid + '\'' +
                ", wcOpenid='" + wcOpenid + '\'' +
                ", status=" + status +
                ", birthday=" + birthday +
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


    public String getTruename() {
        return truename;
    }

    public void setTruename(String truename) {
        this.truename = truename;
    }


    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }


    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }


    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }


    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }


    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }


    public String getImToken() {
        return imToken;
    }

    public void setImToken(String imToken) {
        this.imToken = imToken;
    }


    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }


    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


    public Integer getFellowship() {
        return fellowship;
    }

    public void setFellowship(Integer fellowship) {
        this.fellowship = fellowship;
    }


    public Integer getProfession() {
        return profession;
    }

    public void setProfession(Integer profession) {
        this.profession = profession;
    }


    public String getQqOpenid() {
        return qqOpenid;
    }

    public void setQqOpenid(String qqOpenid) {
        this.qqOpenid = qqOpenid;
    }


    public String getWcOpenid() {
        return wcOpenid;
    }

    public void setWcOpenid(String wcOpenid) {
        this.wcOpenid = wcOpenid;
    }


    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }


    public java.util.Date getBirthday() {
        return birthday;
    }

    public void setBirthday(java.util.Date birthday) {
        this.birthday = birthday;
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
