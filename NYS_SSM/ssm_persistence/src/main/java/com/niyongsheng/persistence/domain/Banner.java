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
@ApiModel(value = "Banner")
@TableName(value = "dcd_banner")
public class Banner implements Serializable {

    // value与数据库主键列名一致，若实体类属性名与表主键列名一致可省略value
    @TableId(value = "id", type = IdType.AUTO) // 指定自增策略
    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "标题")
    private String title;

    @TableField(value = "bannerUrl")
    @ApiModelProperty(value = "轮播图URL")
    private String bannerUrl;

    @TableField(value = "targetUrl")
    @ApiModelProperty(value = "轮播图跳转URL")
    private String targetUrl;

    @ApiModelProperty(value = "发布者账号")
    private String account;

    @ApiModelProperty(value = "所属团契编号")
    private Integer fellowship;

    @TableField(value = "isTop")
    @ApiModelProperty(value = "是否置顶")
    private Boolean isTop;

    @ApiModelProperty(value = "1有效0失效")
    private Boolean status;

    @TableField(value = "expireTime")
    @ApiModelProperty(value = "过期时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime expireTime;

    @TableField(value = "gmtModify")
    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime gmtModify;

    @TableField(value = "gmtCreate")
    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime gmtCreate;

    @TableField(value = "fellowshipName", exist = false)
    @ApiModelProperty(value = "所属团契名称")
    private String fellowshipName;
}
