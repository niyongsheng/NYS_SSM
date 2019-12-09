package com.niyongsheng.persistence.domain;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

@Data
@ApiModel(value ="Pray")
@TableName(value = "dcd_pray")
public class Pray implements Serializable {

  @ApiModelProperty(value = "ID主键")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "标题")
  @TableField(value = "title")
  private String title;

  @ApiModelProperty(value = "副标题")
  @TableField(value = "subtitle")
  private String subtitle;

  @ApiModelProperty(value = "发布者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "主图")
  @TableField(value = "icon")
  private String icon;

  @ApiModelProperty(value = "代祷内容")
  @TableField(value = "content")
  private String content;

  @ApiModelProperty(value = "代祷URL")
  @TableField(value = "prayUrl")
  private String prayUrl;

  @ApiModelProperty(value = "代祷状态 0不可用 1可用")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "是否置顶")
  @TableField(value = "isTop")
  private Boolean isTop;

  @ApiModelProperty(value = "代祷类型 ")
  @TableField(value = "prayType")
  private Integer prayType;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "过期时间")
  @TableField(value = "expireTime")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private java.util.Date expireTime;

  @ApiModelProperty(value = "修改时间")
  @TableField(value = "gmtModify")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private java.util.Date gmtModify;

  @ApiModelProperty(value = "创建时间")
  @TableField(value = "gmtCreate")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private java.util.Date gmtCreate;
}
