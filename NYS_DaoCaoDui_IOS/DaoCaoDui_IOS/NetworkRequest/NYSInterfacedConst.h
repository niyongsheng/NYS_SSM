//
//  NYSInterfacedConst.h
//  NYSUtils
//
//  CMeated by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DevelopSever 1
#define TestSever    0
#define ProductSever 0

/** 接口前缀-服务器*/
UIKIT_EXTERN NSString *const CR_ApiPrefix;

#pragma mark - 详细接口地址
/** 登录*/
UIKIT_EXTERN NSString *const CR_Login;
/** 退出*/
UIKIT_EXTERN NSString *const CR_Logout;
/** 验证码*/
UIKIT_EXTERN NSString *const CR_SendOneTimeCode;
/** 注册*/
UIKIT_EXTERN NSString *const CR_Regist;
/** 忘记密码*/
UIKIT_EXTERN NSString *const CR_Reset;
/** 获取个人信息*/
UIKIT_EXTERN NSString *const CR_GetUserInfo;
/** 修改个人信息*/
UIKIT_EXTERN NSString *const CR_UpdateUserInfo;
/** 签到*/
UIKIT_EXTERN NSString *const CR_DoSign;
/** 积分记录*/
UIKIT_EXTERN NSString *const CR_SignRecord;
/** 个人信息提供者*/
UIKIT_EXTERN NSString *const CR_ProviderUserInfo;
/** 群信息提供者*/
UIKIT_EXTERN NSString *const CR_ProviderTeamInfo;
/** 单文件上传*/
UIKIT_EXTERN NSString *const CR_UploadFile;
/** 多图上传*/
UIKIT_EXTERN NSString *const CR_UploadiImages;


/** 创建群组*/
UIKIT_EXTERN NSString *const CR_CreateGroup;
/** 修改群组资料*/
UIKIT_EXTERN NSString *const CR_UpdateGroupInfo;
/** 解散群组*/
UIKIT_EXTERN NSString *const CR_RemoveGroup;
/** 群列表*/
UIKIT_EXTERN NSString *const CR_GroupList;
/** 用户列表*/
UIKIT_EXTERN NSString *const CR_UserList;
/** QQ登录*/
UIKIT_EXTERN NSString *const CR_QQLogoin;
/** 微信登录*/
UIKIT_EXTERN NSString *const CR_WCLogoin;
/** 付费验证*/
UIKIT_EXTERN NSString *const CR_VipValidate;
/** 更新提醒*/
UIKIT_EXTERN NSString *const CR_UpdateTip;
/** 绑定QQ*/
UIKIT_EXTERN NSString *const CR_BindQQ;
/** 绑定微信*/
UIKIT_EXTERN NSString *const CR_BindWeChat;
/** VIP详情*/
UIKIT_EXTERN NSString *const CR_VIPDetails;
