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
import java.time.LocalDateTime;

@Data
@ApiModel(value ="Publicnotice")
@TableName(value = "dcd_publicnotice")
public class Publicnotice implements Serializable {

  @ApiModelProperty(value = "ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "标题")
  @TableField(value = "title")
  private String title;

  @ApiModelProperty(value = "公告内容")
  @TableField(value = "publicnotice")
  private String publicnotice;

  @ApiModelProperty(value = "公告跳转URL")
  @TableField(value = "publicnoticeUrl")
  private String publicnoticeUrl;

  @ApiModelProperty(value = "发布者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "是否置顶")
  @TableField(value = "isTop")
  private Boolean isTop;

  @ApiModelProperty(value = "1有效0失效")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "过期时间")
  @TableField(value = "expireTime")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime expireTime;

  @ApiModelProperty(value = "修改时间")
  @TableField(value = "gmtModify")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime gmtModify;

  @ApiModelProperty(value = "创建时间")
  @TableField(value = "gmtCreate")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime gmtCreate;

  @TableField(value = "fellowshipName", exist = false)
  @ApiModelProperty(value = "所属团契名称")
  private String fellowshipName;
}
