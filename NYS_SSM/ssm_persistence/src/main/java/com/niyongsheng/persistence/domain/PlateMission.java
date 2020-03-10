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
@ApiModel(value ="PlateMission")
@TableName(value = "dcd_plateMission")
public class PlateMission implements Serializable {

  @ApiModelProperty(value = "车牌ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "任务类型 0:数据透传 1:开门 2:截屏 3:增加白名单 4:删除白名单 5:删除全部白名单 6:手动触发识别")
  @TableField(value = "missionType")
  private Integer missionType;

  @ApiModelProperty(value = "设备序列号")
  @TableField(value = "serialno")
  private String serialno;

  @ApiModelProperty(value = "串口数据")
  @TableField(value = "serialData")
  private String serialData;

  @ApiModelProperty(value = "是否开门 0否 1是")
  @TableField(value = "info")
  private Boolean info;

  @ApiModelProperty(value = "任务状态 0待处理 1已处理")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "任务创建者")
  @TableField(value = "creator")
  private String creator;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "备注")
  @TableField(value = "remark")
  private String remark;

  @ApiModelProperty(value = "车牌号")
  @TableField(value = "plate")
  private String plate;

  @ApiModelProperty(value = "车牌是否有效（0：无效， 1,：有效）")
  @TableField(value = "enable")
  private Boolean enable;

  @ApiModelProperty(value = "车牌是否为黑名单（0：否，1：黑名单）")
  @TableField(value = "needAlarm")
  private Boolean needAlarm;

  @ApiModelProperty(value = "开始时间")
  @TableField(value = "startTime")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime startTime;

  @ApiModelProperty(value = "过期时间")
  @TableField(value = "endTime")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime endTime;

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
