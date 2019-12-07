package com.niyongsheng.persistence.domain;

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
@ApiModel(value = "Article")
public class Article implements Serializable {

    @ApiModelProperty(value = "ID主键")
    private Integer id;

    @ApiModelProperty(value = "标题")
    private String title;

    @ApiModelProperty(value = "副标题")
    private String subtitle;

    @ApiModelProperty(value = "作者")
    private String author;

    @ApiModelProperty(value = "发布者账号")
    private String account;

    @ApiModelProperty(value = "主图")
    private String icon;

    @ApiModelProperty(value = "文章内容")
    private String content;

    @ApiModelProperty(value = "文章URL")
    private String articleUrl;

    @ApiModelProperty(value = "文章状态 0不可用 1可用")
    private Boolean status;

    @ApiModelProperty(value = "是否置顶")
    private Boolean isTop;

    @ApiModelProperty(value = "文章类型 ：1普通 2转载")
    private Integer articleType;

    @ApiModelProperty(value = "所属团契编号")
    private Integer fellowship;

    @ApiModelProperty(value = "过期时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date expireTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date gmtModify;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private java.util.Date gmtCreate;
}
