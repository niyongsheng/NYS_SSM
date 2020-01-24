package com.niyongsheng.persistence.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.Valid;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Valid
@Data
@ApiModel(value ="User")
public class User implements Serializable{

    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "真实姓名")
    private String truename;

    @ApiModelProperty(value = "头像")
    private String icon;

    @ApiModelProperty(value = "等级")
    private Integer grade;

    @ApiModelProperty(value = "积分")
    private Double score;

    @ApiModelProperty(value = "性别:unknown默认未知 male男 female女 secret保密")
    private String gender;

    @ApiModelProperty(value = "手机号")
    @Pattern(regexp = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$", message = "{Pattern.user.phone}")
    private String phone;

    @ApiModelProperty(value = "密码")
    private String password;

    @ApiModelProperty(value = "登录令牌")
    private String token;

    @ApiModelProperty(value = "IM令牌")
    private String imToken;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "简介")
    private String introduction;

    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "地址")
    private String address;

    @ApiModelProperty(value = "团契编号")
    private Integer fellowship;

    @ApiModelProperty(value = "身份类型:0特殊用户 1普通用户 2管理员 3敬拜 4服侍 5牧者")
    private Integer profession;

    @ApiModelProperty(value = "QQ")
    private String qqOpenid;

    @ApiModelProperty(value = "微信")
    private String wcOpenid;

    @ApiModelProperty(value = "Apple登录")
    private String appleUserId;

    @ApiModelProperty(value = "账号状态:1有效 0失效")
    private Boolean status;

    @ApiModelProperty(value = "生日")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime gmtModify;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime gmtCreate;

    @TableField(value = "remark", exist = false)
    @ApiModelProperty(value = "备注信息")
    private String remark;

    @TableField(value = "fellowshipName", exist = false)
    @ApiModelProperty(value = "所属团契名称")
    private String fellowshipName;
}
