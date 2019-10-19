//
//  NYSInterfacedConst.m
//  NYSUtils
//
//  CMeated by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSInterfacedConst.h"

#if DevelopSever
/** 接口前缀-开发服务器*/
NSString *const CR_ApiPrefix = @"http://192.168.31.182:8080/api";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const CR_ApiPrefix = @"http://27j2657m01.zicp.vip:21324/api";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const CR_ApiPrefix = @"";
#endif

/** 登录*/
NSString *const CR_Login = @"/user/login";
/** 退出*/
NSString *const CR_Logout = @"/user/logout";
/** 验证码*/
NSString *const CR_SendOneTimeCode = @"/user/getOnceCode";
/** 注册*/
NSString *const CR_Regist = @"/user/phoneRegister";
/** 忘记密码*/
NSString *const CR_Reset = @"";
/** 获取个人信息*/
NSString *const CR_GetUserInfo = @"/account/getAccountInfo";
/** 修改个人信息*/
NSString *const CR_UpdateUserInfo = @"/account/updateAccountInfo";
/** 签到*/
NSString *const CR_DoSign = @"/account/doSign";
/** 积分记录*/
NSString *const CR_SignRecord = @"/account/getScoreLog";
/** 个人信息提供者*/
NSString *const CR_ProviderUserInfo = @"/user/providerInfoForUser";
/** 群信息提供者*/
NSString *const CR_ProviderTeamInfo = @"/group/providerInfoForGroup";
/** 创建群组*/
NSString *const CR_CreateGroup = @"/im/createTeam";
/** 修改群组资料*/
NSString *const CR_UpdateGroupInfo = @"/im/updateTeam";
/** 解散群组*/
NSString *const CR_RemoveGroup = @"/im/removeTeam";
/** 群列表*/
NSString *const CR_GroupList = @"/im/getTeamList";
/** QQ登录*/
NSString *const CR_QQLogoin = @"/account/qqLogin";
/** 微信登录*/
NSString *const CR_WCLogoin = @"/account/wechatLogin";
/** 付费验证*/
NSString *const CR_VipValidate = @"/account/validate";
/** 更新提醒*/
NSString *const CR_UpdateTip = @"/shelf/getReviewData";
/** 绑定QQ*/
NSString *const CR_BindQQ = @"/account/updateQQ";
/** 绑定微信*/
NSString *const CR_BindWeChat = @"/account/updateWeChat";
/** VIP详情*/
NSString *const CR_VIPDetails = @"/account/getValidateLog";
