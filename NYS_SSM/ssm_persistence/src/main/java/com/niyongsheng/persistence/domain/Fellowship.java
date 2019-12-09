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

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Data
@ApiModel(value ="Fellowship")
@TableName(value = "dcd_fellowship")
public class Fellowship implements Serializable {

  @ApiModelProperty(value = "ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "团契名称")
  @TableField(value = "fellowshipName")
  private String fellowshipName;

  @ApiModelProperty(value = "团契logo")
  @TableField(value = "fellowshipLogo")
  private String fellowshipLogo;

  @ApiModelProperty(value = "用户默认头像")
  @TableField(value = "userIcon")
  private String userIcon;

  @ApiModelProperty(value = "团契等级")
  @TableField(value = "grade")
  private Integer grade;

  @ApiModelProperty(value = "简介")
  @TableField(value = "introduction")
  private String introduction;

  @ApiModelProperty(value = "定位")
  @TableField(value = "gps")
  private String gps;

  @ApiModelProperty(value = "地址")
  @TableField(value = "address")
  private String address;

  @ApiModelProperty(value = "1有效0失效")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "纪念日")
  @TableField(value = "commemorationDay")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private java.util.Date commemorationDay;

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
