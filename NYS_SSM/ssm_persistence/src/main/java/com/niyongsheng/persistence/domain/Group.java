package com.niyongsheng.persistence.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
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
@Data
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

    @ApiModelProperty(value = "群组类型 1公开群  2私人群")
    private Integer groupType;

    @ApiModelProperty(value = "所属团契编号")
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

    @TableField(value = "fellowshipName", exist = false)
    @ApiModelProperty(value = "所属团契名称")
    private String fellowshipName;
}