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
+ (NSURLSessionTask *)getLoginWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    // 将请求前缀与请求路径拼接成一个完整的URL
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Login];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 退出*/
+ (NSURLSessionTask *)getLogoutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Logout];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 注册*/
+ (NSURLSessionTask *)RegistWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Regist];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 忘记密码*/
+ (NSURLSessionTask *)ResetWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Reset];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 验证码*/
+ (NSURLSessionTask *)SendOneTimeCodeWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_SendOneTimeCode];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}



// TODO 下面没改--------------------------------


/** 获取个人信息*/
+ (NSURLSessionTask *)GetUserInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetUserInfo];
    return nil;
}

/** 修改个人信息*/
+ (NSURLSessionTask *)UpdateUserInfoWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateUserInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 签到*/
+ (NSURLSessionTask *)DosignWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DoSign];
    return nil;
}

/** 签到详情*/
+ (NSURLSessionTask *)GetDosignRecordWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_SignRecord];
    return nil;
}
/** 个人信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForUserWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderUserInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}
/** 群信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForGroupWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderTeamInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 单文件上传*/
+ (NSURLSessionTask *)UploadFileWithFilePath:(NSString *)filePath parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UploadFile];
    return [self fileRequestWithURL:url parameters:parameters filePath:filePath process:process success:success failure:failure];
}

/** 多图上传*/
+ (NSURLSessionTask *)UploadImagesWithImages:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)imageNames parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UploadiImages];
    return [self imagesRequestWithURL:url parameters:parameters images:images fileNames:imageNames process:process success:success failure:failure];
}

/** 创建群组*/
+ (NSURLSessionTask *)CreateGroupWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CreateGroup];
    return nil;
}

/** 修改群组资料*/
+ (NSURLSessionTask *)UpdateGroupInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateGroupInfo];
    return nil;
}

/** 解散群组*/
+ (NSURLSessionTask *)RemoveGroupInfoWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_RemoveGroup];
    return nil;
}

/** 获取群列表*/
+ (NSURLSessionTask *)GetGroupListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GroupList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取用户列表*/
+ (NSURLSessionTask *)GetUserListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UserList];
    return [self requestWithResMethod:GET URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** QQ登录*/
+ (NSURLSessionTask *)QQLogoinWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_QQLogoin];
    return nil;
}

/** 微信登录*/
+ (NSURLSessionTask *)WCLogoinWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_WCLogoin];
    return nil;
}

/** 付费验证*/
+ (NSURLSessionTask *)VipValidateWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_VipValidate];
    return nil;
}

/** 更新提醒*/
+ (NSURLSessionTask *)UpdateTipWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateTip];
    return nil;
}

/** 绑定QQ*/
+ (NSURLSessionTask *)BindQQWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_BindQQ];
    return nil;
}

/** 绑定微信*/
+ (NSURLSessionTask *)BindWeChatWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_BindWeChat];
    return nil;
}

/** VIP详情*/
+ (NSURLSessionTask *)VIPDetailstWithParameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_VIPDetails];
    return nil;
}


/// POST/GET网络请求方法
/// @param resMethod 请求方式
/// @param URL 请求地址
/// @param parameters 参数
/// @param success 成功回调
/// @param failure 失败回调
/// @param isCache 是否缓存
+ (NSURLSessionTask *)requestWithResMethod:(ResMethod)resMethod URL:(NSString *)URL parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    [PPNetworkHelper openLog];
//    [PPNetworkHelper openNetworkActivityIndicator:YES];
    [PPNetworkHelper setRequestTimeoutInterval:10];
//    [PPNetworkHelper closeAES];
    NLog(@"当前网络缓存大小cache = .2%fKB", [PPNetworkCache getAllHttpCacheSize]/1024.f);
//    [PPNetworkCache removeAllHttpCache];
    NLog(@"接口：%@\n参数：%@", URL, parameters);
    
#pragma mark - AUTH认证
    [PPNetworkHelper setValue:NCurrentUser.token forHTTPHeaderField:@"Token"];
    [PPNetworkHelper setValue:NCurrentUser.account forHTTPHeaderField:@"Account"];
    
#pragma mark - Resquest
//    [SVProgressHUD show];
    switch (resMethod) {
        case POST: {
            return [PPNetworkHelper POST:URL parameters:parameters success:^(id responseObject) {
                [SVProgressHUD dismiss];
                [self responseHandler:URL
                              isCache:isCache
                           parameters:parameters
                       responseObject:responseObject
                              success:success];
            } failure:^(NSError *error) {
                [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
                failure(error);
            }];
        }
            break;
            
        case GET: {
            return [PPNetworkHelper GET:URL parameters:parameters success:^(id responseObject) {
                [SVProgressHUD dismiss];
                [self responseHandler:URL
                              isCache:isCache
                           parameters:parameters
                       responseObject:responseObject
                              success:success];
            } failure:^(NSError *error) {
                [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
                failure(error);
            }];
        }
            break;
            
        default:
            break;
    }
}

/// 单文件上传方法
/// @param URL 请求地址
/// @param parameters 参数
/// @param filePath 文件路径
/// @param process 进度
/// @param success 成功
/// @param failure 失败
+ (NSURLSessionTask *)fileRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameters filePath:(NSString *)filePath process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    [PPNetworkHelper openLog];
    [PPNetworkHelper setRequestTimeoutInterval:10];
    NLog(@"当前网络缓存大小cache = %fKB", [PPNetworkCache getAllHttpCacheSize]/1024.f);
    
#pragma mark - AUTH认证
    [PPNetworkHelper setValue:NCurrentUser.token forHTTPHeaderField:@"Token"];
    [PPNetworkHelper setValue:NCurrentUser.account forHTTPHeaderField:@"Account"];
    
#pragma mark - Resquest
    return [PPNetworkHelper uploadFileWithURL:URL
                                   parameters:parameters
                                         name:@"file"
                                     filePath:filePath
                                     progress:^(NSProgress *progress) {
        process(progress);
        CGFloat process = progress.completedUnitCount/progress.totalUnitCount;
        NLog(@"文件上传进度:%.2f%%",100.0 * process);
        [SVProgressHUD showProgress:process * 100 status:@"文件上传进度"];
    } success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self responseHandler:URL isCache:NO parameters:parameters responseObject:responseObject success:success];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
        failure(error);
    }];
}

/// 多图上传方法
/// @param URL 请求地址
/// @param parameters 参数
/// @param images 图片数组
/// @param imageNames 图片名数组
/// @param process 进度
/// @param success 成功
/// @param failure 失败
+ (NSURLSessionTask *)imagesRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)imageNames process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    [PPNetworkHelper openLog];
    [PPNetworkHelper setRequestTimeoutInterval:10];
    NLog(@"当前网络缓存大小cache = %fKB", [PPNetworkCache getAllHttpCacheSize]/1024.f);
    
#pragma mark - AUTH认证
    [PPNetworkHelper setValue:NCurrentUser.token forHTTPHeaderField:@"Token"];
    [PPNetworkHelper setValue:NCurrentUser.account forHTTPHeaderField:@"Account"];
    
#pragma mark - Resquest
    return [PPNetworkHelper uploadImagesWithURL:URL
                                     parameters:parameters
                                           name:@"files"
                                         images:images
                                      fileNames:imageNames
                                     imageScale:.5f
                                      imageType:@"image/jpg/png/jpeg"
                                       progress:^(NSProgress *progress) {
        process(progress);
        CGFloat process = progress.completedUnitCount/progress.totalUnitCount;
        NLog(@"图片上传进度:%.2f%%",100.0 * process);
        [SVProgressHUD showProgress:process * 100 status:@"图片上传进度"];
    } success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self responseHandler:URL isCache:NO parameters:parameters responseObject:responseObject success:success];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
        failure(error);
    }];
}

#pragma mark - 请求响应处理方法
+ (void)responseHandler:(NSString *)URL isCache:(BOOL)isCache parameters:(NSDictionary *)parameters responseObject:(id)responseObject success:(NYSRequestSuccess)success {
    NLog(@"[服务器Response]：%@", responseObject);
    if ([[responseObject objectForKey:@"status"] boolValue]) {
        isCache ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        success(responseObject);
    } else {
        NSInteger code = [[responseObject objectForKey:@"statusCode"] integerValue];
        NSString *info = [responseObject objectForKey:@"msg"];
        NSString *error = [NSString stringWithFormat:@"%ld\n%@", (long)code, info];
        [SVProgressHUD showErrorWithStatus:error];
        if (code == 6005 || code == 6010 || code == 6011 || code == 6001) {
            // 退出登录通知
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"errorAutoLogOutNotification" object:nil userInfo:nil]];
        } else if (code == 4001) {
            // 参数合法性提示
            NSString *warnInfo = [responseObject objectForKey:@"data"];
            NSString *warning = [NSString stringWithFormat:@"%ld\n%@", (long)code, warnInfo];
            [SVProgressHUD showInfoWithStatus:warning];
        }
        [SVProgressHUD dismissWithDelay:2.f];
    }
}

@end
