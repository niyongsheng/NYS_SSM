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
@ApiModel(value ="Filelog")
@TableName(value = "dcd_filelog")
public class Filelog implements Serializable {

  @ApiModelProperty(value = "ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "文件URL")
  @TableField(value = "fileUrl")
  private String fileUrl;

  @ApiModelProperty(value = "1上传 0删除")
  @TableField(value = "type")
  private Boolean type;

  @ApiModelProperty(value = "发布者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "备注")
  @TableField(value = "remark")
  private String remark;

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
