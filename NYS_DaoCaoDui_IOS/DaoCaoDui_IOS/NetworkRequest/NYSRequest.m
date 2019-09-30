//
//  NYSRequest.m
//  NYSUtils
//
//  Created by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSRequest.h"
#import "PPNetworkHelper.h"
#import "NYSInterfacedConst.h"

@implementation NYSRequest

/** 登录*/
+ (NSURLSessionTask *)getLoginWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    // 将请求前缀与请求路径拼接成一个完整的URL
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Login];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 退出*/
+ (NSURLSessionTask *)getLogoutWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Logout];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 注册*/
+ (NSURLSessionTask *)RegistWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Regist];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 忘记密码*/
+ (NSURLSessionTask *)ResetWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Reset];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 验证码*/
+ (NSURLSessionTask *)SendOneTimeCodeWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_SendOneTimeCode];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取个人信息*/
+ (NSURLSessionTask *)GetUserInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetUserInfo];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 更新个人信息*/
+ (NSURLSessionTask *)UpdateUserInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateUserInfo];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 签到*/
+ (NSURLSessionTask *)DosignWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DoSign];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 签到详情*/
+ (NSURLSessionTask *)GetDosignRecordWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_SignRecord];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}
/** 个人信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForUserWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderUserInfo];
    return [self unmismanageRequestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}
/** 群信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForTeamWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderTeamInfo];
    return [self unmismanageRequestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 创建群组*/
+ (NSURLSessionTask *)CreateGroupWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CreateGroup];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 修改群组资料*/
+ (NSURLSessionTask *)UpdateGroupInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateGroupInfo];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 解散群组*/
+ (NSURLSessionTask *)RemoveGroupInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_RemoveGroup];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取群列表*/
+ (NSURLSessionTask *)GetGroupListWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GroupList];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** QQ登录*/
+ (NSURLSessionTask *)QQLogoinWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_QQLogoin];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 微信登录*/
+ (NSURLSessionTask *)WCLogoinWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_WCLogoin];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 付费验证*/
+ (NSURLSessionTask *)VipValidateWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_VipValidate];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 更新提醒*/
+ (NSURLSessionTask *)UpdateTipWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateTip];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 绑定QQ*/
+ (NSURLSessionTask *)BindQQWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_BindQQ];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 绑定微信*/
+ (NSURLSessionTask *)BindWeChatWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_BindWeChat];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** VIP详情*/
+ (NSURLSessionTask *)VIPDetailstWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_VIPDetails];
    return [self requestWithURL:url parameters:parameters success:success failure:failure isCache:isCache];
}

#pragma mark - 网络请求的公共方法
+ (NSURLSessionTask *)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    [PPNetworkHelper openLog]; // 开启日志
//    [PPNetworkHelper closeAES];
//    [PPNetworkHelper openNetworkActivityIndicator:YES]; // 加载状态
//    [PPNetworkHelper setRequestTimeoutInterval:10]; // 超时时长
    //    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"from-data"]; // 请求头
    //    NLog(@"当前网络缓存大小cache = %fKB", [PPNetworkCache getAllHttpCacheSize]/1024.f);
    //    [PPNetworkCache removeAllHttpCache];
    
    // 发起请求
    //    [SVProgressHUD show];
    return [PPNetworkHelper POST:URL parameters:parameters success:^(id responseObject) {
        //        [SVProgressHUD dismiss];
        NLog(@"服务器：%@", responseObject);
        if ([[responseObject objectForKey:@"success"] boolValue]) {
            // 是否缓存
//            isCache ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
            success(responseObject);
        } else {
            NSString *error = [responseObject objectForKey:@"error"];
            [SVProgressHUD showErrorWithStatus:error];
            if ([error isEqualToString:@"未登录。"] || [error isEqualToString:@"在别的设备登陆。"]) {
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"errorAutoLogOutNotification" object:nil userInfo:nil]];
            }
            [SVProgressHUD dismissWithDelay:1.f];
            success(responseObject);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"网络错误:%ld", (long)error.code]];
        [SVProgressHUD dismissWithDelay:.7f];
        failure(error);
    }];
}

#pragma mark - 不处理错误网络请求的公共方法
+ (NSURLSessionTask *)unmismanageRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    [PPNetworkHelper openLog];
    [PPNetworkHelper openNetworkActivityIndicator:YES];
    [PPNetworkHelper setRequestTimeoutInterval:10];
    
    return [PPNetworkHelper POST:URL parameters:parameters responseCache:^(id responseCache) {
        isCache ? success(responseCache) : nil;
    } success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
#if defined(DEBUG)||defined(_DEBUG)
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"网络错误:%ld", (long)error.code]];
        [SVProgressHUD dismissWithDelay:.7f];
#endif
        failure(error);
    }];
}

@end
