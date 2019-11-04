package com.niyongsheng.persistence.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@ApiModel(value ="Group")
public class Group implements Serializable {

    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "群组ID")
    private Integer groupId;

    @ApiModelProperty(value = "组群头像")
    private String groupIcon;

    @ApiModelProperty(value = "群组名称")
    private String groupName;

    @ApiModelProperty(value = "创建人")
    private String creator;

    @ApiModelProperty(value = "群成员数")
    private Integer memberCount;

    @ApiModelProperty(value = "是否禁言")
    private Boolean isBan;

    @ApiModelProperty(value = "群组状态 0不可用 1可用")
    private Boolean status;

    @ApiModelProperty(value = "是否需要验证")
    private Boolean isVerify;

    @ApiModelProperty(value = "群组类型  1官方群  2私人群")
    private Integer groupType;

    @ApiModelProperty(value = "所属团契")
    private Integer fellowship;

    @ApiModelProperty(value = "过期时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date expireTime;

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
        return "Group{" +
                "id=" + id +
                ", groupId=" + groupId +
                ", groupIcon='" + groupIcon + '\'' +
                ", groupName='" + groupName + '\'' +
                ", creator='" + creator + '\'' +
                ", memberCount='" + memberCount +
                ", isBan=" + isBan +
                ", status=" + status +
                ", isVerify=" + isVerify +
                ", groupType=" + groupType +
                ", fellowship=" + fellowship +
                ", expireTime=" + expireTime +
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

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupIcon() {
        return groupIcon;
    }

    public void setGroupIcon(String groupIcon) {
        this.groupIcon = groupIcon;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Integer getMemberCount() {
        return memberCount;
    }

    public void setMemberCount(Integer memberCount) {
        this.memberCount = memberCount;
    }

    @JsonProperty(value = "isBan")
    public Boolean getBan() {
        return isBan;
    }

    public void setBan(Boolean ban) {
        isBan = ban;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @JsonProperty(value = "isVerify")
    public Boolean getVerify() {
        return isVerify;
    }

    public void setVerify(Boolean verify) {
        isVerify = verify;
    }

    public Integer getGroupType() {
        return groupType;
    }

    public void setGroupType(Integer groupType) {
        this.groupType = groupType;
    }

    public Integer getFellowship() {
        return fellowship;
    }

    public void setFellowship(Integer fellowship) {
        this.fellowship = fellowship;
    }

    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
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