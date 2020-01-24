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
@ApiModel(value ="Report")
@TableName(value = "dcd_report")
public class Report implements Serializable {

  @ApiModelProperty(value = "ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "举报类型：1.广告信息 2.垃圾信息 3.不感兴趣")
  @TableField(value = "type")
  private Integer type;

  @ApiModelProperty(value = "举报内容")
  @TableField(value = "content")
  private String content;

  @ApiModelProperty(value = "举报项目id")
  @TableField(value = "reportId")
  private Integer reportId;

  @ApiModelProperty(value = "id类型： 1.分享 2.代祷 3.音频 4.活动")
  @TableField(value = "idType")
  private Integer idType;

  @ApiModelProperty(value = "举报者者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

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
