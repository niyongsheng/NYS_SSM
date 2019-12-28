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
@ApiModel(value ="Music")
@TableName(value = "dcd_music")
public class Music implements Serializable {

  @ApiModelProperty(value = "ID主键")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "歌名")
  @TableField(value = "name")
  private String name;

  @ApiModelProperty(value = "歌手")
  @TableField(value = "singer")
  private String singer;

  @ApiModelProperty(value = "词作者")
  @TableField(value = "wordAuthor")
  private String wordAuthor;

  @ApiModelProperty(value = "曲作者")
  @TableField(value = "anAuthor")
  private String anAuthor;

  @ApiModelProperty(value = "封面")
  @TableField(value = "icon")
  private String icon;

  @ApiModelProperty(value = "歌词")
  @TableField(value = "lyric")
  private String lyric;

  @ApiModelProperty(value = "歌曲URL")
  @TableField(value = "musicUrl")
  private String musicUrl;

  @ApiModelProperty(value = "发布者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "歌曲状态 0不可用 1可用")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "是否置顶")
  @TableField(value = "isTop")
  private Boolean isTop;

  @ApiModelProperty(value = "歌曲类型 ")
  @TableField(value = "musicType")
  private Integer musicType;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

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
