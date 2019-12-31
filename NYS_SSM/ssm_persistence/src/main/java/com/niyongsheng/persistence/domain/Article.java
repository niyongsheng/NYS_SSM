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
@ApiModel(value ="Article")
@TableName(value = "dcd_article")
public class Article implements Serializable {

    @ApiModelProperty(value = "ID主键")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "标题")
    @TableField(value = "title")
    private String title;

    @ApiModelProperty(value = "副标题")
    @TableField(value = "subtitle")
    private String subtitle;

    @ApiModelProperty(value = "作者")
    @TableField(value = "author")
    private String author;

    @ApiModelProperty(value = "发布者账号")
    @TableField(value = "account")
    private String account;

    @ApiModelProperty(value = "主图")
    @TableField(value = "icon")
    private String icon;

    @ApiModelProperty(value = "文章内容")
    @TableField(value = "content")
    private String content;

    @ApiModelProperty(value = "文章URL")
    @TableField(value = "articleUrl")
    private String articleUrl;

    @ApiModelProperty(value = "文章状态 0不可用 1可用")
    @TableField(value = "status")
    private Boolean status;

    @ApiModelProperty(value = "是否置顶")
    @TableField(value = "isTop")
    private Boolean isTop;

    @ApiModelProperty(value = "文章类型 ：1普通 2转载")
    @TableField(value = "articleType")
    private Integer articleType;

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

    @TableField(value = "collectionUserList", exist = false)
    @ApiModelProperty(value = "收藏用户列表")
    private List<User> collectionUserList;
}
