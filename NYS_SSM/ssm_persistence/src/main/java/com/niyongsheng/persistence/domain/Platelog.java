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
@ApiModel(value ="Platelog")
@TableName(value = "dcd_platelog")
public class Platelog implements Serializable {

  @ApiModelProperty(value = "车牌记录ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "车牌信息")
  @TableField(value = "plate")
  private String plate;

  @ApiModelProperty(value = "道闸名称")
  @TableField(value = "deviceName")
  private String deviceName;

  @ApiModelProperty(value = "设备序列号")
  @TableField(value = "serialno")
  private String serialno;

  @ApiModelProperty(value = "车牌类型 0：未知车牌:、1：蓝牌小汽车、2：:黑牌小汽车、3：单排黄牌、4：双排黄牌、 5：警车车牌、6：武警车牌、7：个性化车牌、8：单排军车牌、9：双排军车牌、10：使馆车牌、11：香港进出中国大陆车牌、12：农用车牌、13：教练车牌、14：澳门进出中国大陆车牌、15：双层武警车牌、16：武警总队车牌、17：双层武警总队车牌、18：民航车牌、19：新能源车牌")
  @TableField(value = "plateType")
  private Integer plateType;

  @ApiModelProperty(value = "车辆品牌")
  @TableField(value = "carType")
  private String carType;

  @ApiModelProperty(value = "车牌大图")
  @TableField(value = "bigImage")
  private String bigImage;

  @ApiModelProperty(value = "车牌小图")
  @TableField(value = "smallImage")
  private String smallImage;

  @ApiModelProperty(value = "记录状态 0异常 1正常")
  @TableField(value = "status")
  private Boolean status;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "备注")
  @TableField(value = "remark")
  private String remark;

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

  @TableField(value = "plateTypeName", exist = false)
  @ApiModelProperty(value = "车牌类型名称")
  private String plateTypeName;
}
