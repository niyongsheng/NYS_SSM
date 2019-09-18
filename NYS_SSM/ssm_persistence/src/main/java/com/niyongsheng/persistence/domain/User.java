package com.niyongsheng.persistence.domain;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable{

    /** ID */
    private Integer id;
    /** 账号 */
    private String account;
    /** 真实姓名 */
    private String truename;
    /** 头像 */
    private String icon;
    /** 等级 */
    private Integer grade;
    /** 积分 */
    private Double score;
    /** 性别 */
    private String gender;
    /** 手机号 */
    private String phone;
    /** 密码 */
    private String password;
    /** 登录令牌 */
    private String token;
    /** IM令牌 */
    private String imToken;
    /** 昵称 */
    private String nickname;
    /** 简介 */
    private String introduction;
    /** 邮箱 */
    private String email;
    /** 地址 */
    private String address;
    /** 团契 */
    private Integer fellowship;
    /** 身份类型 */
    private Integer profession;
    /** QQ */
    private String qqOpenid;
    /** 微信 */
    private String wcOpenid;
    /** 1有效 0失效 */
    private String status;
    /** 修改时间 */
/*    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss") // 后->前
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") // 前端->后台的时间格式的转换
    @JsonSerialize(using = CustomDateSerializer.class)*/
    private Date gmtModify;
    /** 创建时间 */
/*    @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss") // 后->前
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") // 前端->后台的时间格式的转换
    @JsonSerialize(using = CustomDateSerializer.class)*/
    private Date gmtCreate;

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
                ", status='" + status + '\'' +
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getGmtModify() {
        return gmtModify;
    }

    public void setGmtModify(Date gmtModify) {
        this.gmtModify = gmtModify;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }
}
