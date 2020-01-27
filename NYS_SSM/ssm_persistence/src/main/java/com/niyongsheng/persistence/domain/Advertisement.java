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

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Data
@ApiModel(value ="Advertisement")
@TableName(value = "dcd_ advertisement")
public class Advertisement implements Serializable {

  @ApiModelProperty(value = "ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "广告标题")
  @TableField(value = "title")
  private String title;

  @ApiModelProperty(value = "广告副标题")
  @TableField(value = "subtitle")
  private String subtitle;

  @ApiModelProperty(value = "广告内容")
  @TableField(value = "content")
  private String content;

  @ApiModelProperty(value = "AD_URL")
  @TableField(value = "advertisementUrl")
  private String advertisementUrl;

  @ApiModelProperty(value = "广告跳转目标URL")
  @TableField(value = "targetUrl")
  private String targetUrl;

  @ApiModelProperty(value = "发布者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "广告类型：1.启动广告 2.弹框广告")
  @TableField(value = "type")
  private Integer type;

  @ApiModelProperty(value = "展示时长")
  @TableField(value = "duration")
  private Double duration;

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
}
