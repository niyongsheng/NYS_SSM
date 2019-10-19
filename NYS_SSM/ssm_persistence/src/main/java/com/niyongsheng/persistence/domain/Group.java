package com.niyongsheng.persistence.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
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
@ApiModel(value ="Group")
public class Group implements Serializable {

    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "群组ID")
    private Integer groupId;

    @ApiModelProperty(value = "融云上的群组id")
    private String rongCloudGroupId;

    @ApiModelProperty(value = "组群头像")
    private String groupIcon;

    @ApiModelProperty(value = "群组名称")
    private String groupName;

    @ApiModelProperty(value = "创建人")
    private String creator;

    @ApiModelProperty(value = "群组状态 0不可用 1可用")
    private Boolean status;

    @ApiModelProperty(value = "是否需要验证")
    private Boolean isneedVerify;

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


    public String getRongCloudGroupId() {
        return rongCloudGroupId;
    }

    public void setRongCloudGroupId(String rongCloudGroupId) {
        this.rongCloudGroupId = rongCloudGroupId;
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


    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }


    public Boolean getIsneedVerify() {
        return isneedVerify;
    }

    public void setIsneedVerify(Boolean isneedVerify) {
        this.isneedVerify = isneedVerify;
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


    public java.util.Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(java.util.Date expireTime) {
        this.expireTime = expireTime;
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