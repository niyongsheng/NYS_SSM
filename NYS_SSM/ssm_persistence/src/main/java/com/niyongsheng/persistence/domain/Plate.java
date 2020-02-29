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
@ApiModel(value ="Plate")
@TableName(value = "dcd_plate")
public class Plate implements Serializable {

  @ApiModelProperty(value = "车牌ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "车牌信息")
  @TableField(value = "plate")
  private String plate;

  @ApiModelProperty(value = "车牌照片")
  @TableField(value = "plateImage")
  private String plateImage;

  @ApiModelProperty(value = "车牌类型 0：未知车牌:、1：蓝牌小汽车、2：:黑牌小汽车、3：单排黄牌、4：双排黄牌、 5：警车车牌、6：武警车牌、7：个性化车牌、8：单排军车牌、9：双排军车牌、10：使馆车牌、11：香港进出中国大陆车牌、12：农用车牌、13：教练车牌、14：澳门进出中国大陆车牌、15：双层武警车牌、16：武警总队车牌、17：双层武警总队车牌、18：民航车牌、19：新能源车牌")
  @TableField(value = "plateType")
  private Integer plateType;

  @ApiModelProperty(value = "车辆品牌")
  @TableField(value = "carType")
  private String carType;

  @ApiModelProperty(value = "创建人")
  @TableField(value = "creator")
  private String creator;

  @ApiModelProperty(value = "简介")
  @TableField(value = "introduction")
  private String introduction;

  @ApiModelProperty(value = "车牌状态 0不可用 1可用")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "备注")
  @TableField(value = "remark")
  private String remark;

  @ApiModelProperty(value = "vip类型 0：普通车牌 1：月租车 2：星租车 3：季租车 4：年租车5：访客车")
  @TableField(value = "vipType")
  private Integer vipType;

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
