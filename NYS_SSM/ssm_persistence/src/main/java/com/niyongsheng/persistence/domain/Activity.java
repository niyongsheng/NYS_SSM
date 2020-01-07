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
import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Data
@ApiModel(value ="Activity")
@TableName(value = "dcd_activity")
public class Activity implements Serializable {

  @ApiModelProperty(value = "ID")
  @TableId(value = "id", type = IdType.AUTO)
  private Integer id;

  @ApiModelProperty(value = "活动名称")
  @TableField(value = "name")
  private String name;

  @ApiModelProperty(value = "活动封面URL")
  @TableField(value = "icon")
  private String icon;

  @ApiModelProperty(value = "活动简介")
  @TableField(value = "introduction")
  private String introduction;

  @ApiModelProperty(value = "关联群组ID")
  @TableField(value = "groupId")
  private Integer groupId;

  @ApiModelProperty(value = "发布者账号")
  @TableField(value = "account")
  private String account;

  @ApiModelProperty(value = "所属团契编号")
  @TableField(value = "fellowship")
  private Integer fellowship;

  @ApiModelProperty(value = "活动类型 1普通活动  2打卡活动")
  @TableField(value = "activityType")
  private Integer activityType;

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

  @TableField(value = "isInGroup", exist = false)
  @ApiModelProperty(value = "是否为活动成员")
  private Boolean isInGroup;

  @TableField(value = "isClockedToday", exist = false)
  @ApiModelProperty(value = "今天是否已打卡")
  private Boolean isClockedToday;

  @TableField(value = "membersNum", exist = false)
  @ApiModelProperty(value = "活动成员数量")
  private Integer membersNum;

  @TableField(value = "userList", exist = false)
  @ApiModelProperty(value = "活动成员列表")
  private List<User> userList;

  @TableField(value = "clockedUserList", exist = false)
  @ApiModelProperty(value = "已打卡活动成员列表")
  private List<User> clockedUserList;

  @TableField(value = "unclockUserList", exist = false)
  @ApiModelProperty(value = "未打卡活动成员列表")
  private List<User> unclockUserList;
}
