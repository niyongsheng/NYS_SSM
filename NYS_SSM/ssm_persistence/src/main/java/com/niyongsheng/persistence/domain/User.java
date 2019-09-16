package com.niyongsheng.persistence.domain;

import com.sun.org.apache.xpath.internal.operations.Bool;

import java.io.Serializable;
import java.util.Date;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class User implements Serializable {

    private Integer id;
    private String account;
    private String username;
    private String icon;
    private Integer grade;
    private String gender;
    private String password;
    private String token;
    private String imToken;
    private String nickname;
    private String introduction;
    private String email;
    private String address;
    private Integer profession;
    private String qqOpenid;
    private String wcOpenid;
    private Bool status;
    private Date gmtModify;
    private Date gmtCreate;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", account='" + account + '\'' +
                ", username='" + username + '\'' +
                ", icon='" + icon + '\'' +
                ", grade=" + grade +
                ", gender='" + gender + '\'' +
                ", password='" + password + '\'' +
                ", token='" + token + '\'' +
                ", imToken='" + imToken + '\'' +
                ", nickname='" + nickname + '\'' +
                ", introduction='" + introduction + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", profession=" + profession +
                ", qqOpenid='" + qqOpenid + '\'' +
                ", wcOpenid='" + wcOpenid + '\'' +
                ", status=" + status +
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public Bool getStatus() {
        return status;
    }

    public void setStatus(Bool status) {
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
