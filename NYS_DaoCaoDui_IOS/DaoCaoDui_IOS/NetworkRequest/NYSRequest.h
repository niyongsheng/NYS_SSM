//
//  NYSRequest.h
//  NYSUtils
//
//  Created by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NYSRequestSuccess)(id response);

typedef void(^NYSRequestFailure)(NSError *error);

@interface NYSRequest : NSObject

/** 登录*/
+ (NSURLSessionTask *)getLoginWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 退出*/
+ (NSURLSessionTask *)getLogoutWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 注册*/
+ (NSURLSessionTask *)RegistWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 忘记密码*/
+ (NSURLSessionTask *)ResetWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 验证码*/
+ (NSURLSessionTask *)SendOneTimeCodeWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取个人信息*/
+ (NSURLSessionTask *)GetUserInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 更新个人信息*/
+ (NSURLSessionTask *)UpdateUserInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 签到*/
+ (NSURLSessionTask *)DosignWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 签到详情*/
+ (NSURLSessionTask *)GetDosignRecordWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 个人信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForUserWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 群信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForTeamWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 创建群组*/
+ (NSURLSessionTask *)CreateGroupWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 修改群组资料*/
+ (NSURLSessionTask *)UpdateGroupInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 解散群组*/
+ (NSURLSessionTask *)RemoveGroupInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取群列表*/
+ (NSURLSessionTask *)GetGroupListWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** QQ登录*/
+ (NSURLSessionTask *)QQLogoinWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 微信登录*/
+ (NSURLSessionTask *)WCLogoinWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 付费验证*/
+ (NSURLSessionTask *)VipValidateWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 更新提醒*/
+ (NSURLSessionTask *)UpdateTipWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 绑定QQ*/
+ (NSURLSessionTask *)BindQQWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 绑定微信*/
+ (NSURLSessionTask *)BindWeChatWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** VIP详情*/
+ (NSURLSessionTask *)VIPDetailstWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;

@end

