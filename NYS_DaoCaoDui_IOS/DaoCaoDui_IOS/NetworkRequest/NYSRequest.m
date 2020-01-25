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
#import <AFNetworking/AFHTTPSessionManager.h>

#define RequestTimeout 20

@implementation NYSRequest

/** 登录*/
+ (NSURLSessionTask *)LoginWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    // 将请求前缀与请求路径拼接成一个完整的URL
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Login];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** Apple登录*/
+ (NSURLSessionTask *)LoginByAppleWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    // 将请求前缀与请求路径拼接成一个完整的URL
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_LoginByApple];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 退出*/
+ (NSURLSessionTask *)LogoutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
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

/** 修改个人信息*/
+ (NSURLSessionTask *)UpdateUserInfoWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateUserInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 签到*/
+ (NSURLSessionTask *)DosignWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DoSign];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 积分记录详情*/
+ (NSURLSessionTask *)GetScoreRecordWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ScoreRecord];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 个人信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForUserWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderUserInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}
/** 群组信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForGroupWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderTeamInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 群组成员信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForGroupMembersWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_ProviderTeamMembersInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 单文件上传*/
+ (NSURLSessionTask *)UploadFileWithFilePath:(NSString *)filePath parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UploadFile];
    return [self fileRequestWithURL:url parameters:parameters filePath:filePath process:process success:success failure:failure];
}

/** 多图上传*/
+ (NSURLSessionTask *)UploadImagesWithImages:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)imageNames name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UploadiImages];
    return [self imagesRequestWithURL:url parameters:parameters images:images fileNames:imageNames name:name process:process success:success failure:failure];
}

/** 获取轮播图*/
+ (NSURLSessionTask *)GetBannerList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetBanners];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取公告*/
+ (NSURLSessionTask *)GetPublicnoticeList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetPublicnotices];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取文章列表*/
+ (NSURLSessionTask *)GetArticleList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetArticleList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取活动列表*/
+ (NSURLSessionTask *)GetActivityList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetActivityList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取打卡活动列表*/
+ (NSURLSessionTask *)GetClockActivityList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetClockActivityList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取代祷列表*/
+ (NSURLSessionTask *)GetPrayList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetPrayList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取歌单列表*/
+ (NSURLSessionTask *)GetMusicMenuList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetMusicMenuList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取歌单（含歌曲列表）*/
+ (NSURLSessionTask *)GetMusicMenuById:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GetMusicMenu];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 发布分享*/
+ (NSURLSessionTask *)PublishArtcleWithImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishArtcle];
    return [self imagesRequestWithURL:url parameters:parameters images:@[image] fileNames:nil name:name process:process success:success failure:failure];
}

/** 发布代祷*/
+ (NSURLSessionTask *)PublishPrayWithImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishPray];
    return [self imagesRequestWithURL:url parameters:parameters images:@[image] fileNames:nil name:name process:process success:success failure:failure];
}

/** 发布音频*/
+ (NSURLSessionTask *)PublishMusicWithImage:(UIImage *)image imageName:(NSString *)imageName audioFileData:(NSData *)audioFileData audioParamName:(NSString *)audioParamName audioName:(NSString *)audioName fileData:(NSData *)fileData fileParamName:(NSString *)fileParamName fileName:(NSString *)fileName parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishMusic];
    return [self uploadRequestWithURL:url parameters:parameters image:image imageName:imageName audioFileData:audioFileData audioParamName:audioParamName audioName:audioName fileData:fileData fileParamName:fileParamName fileName:fileName process:process success:success failure:failure];
}

/** 发布活动*/
+ (NSURLSessionTask *)PublishActivityWithImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishActivity];
    return [self imagesRequestWithURL:url parameters:parameters images:@[image] fileNames:nil name:name process:process success:success failure:failure];
}

/** 结束活动*/
+ (NSURLSessionTask *)DismissActivityWithActivityID:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DismissActivity];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 加入活动*/
+ (NSURLSessionTask *)JoinActivityWithActivityID:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_JoinActivity];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 退出活动*/
+ (NSURLSessionTask *)QuitActivityWithActivityID:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_QuitActivity];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 获取群列表*/
+ (NSURLSessionTask *)GetGroupListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_GroupList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取用户列表*/
+ (NSURLSessionTask *)GetUserListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UserList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 打卡*/
+ (NSURLSessionTask *)PunchClockActivityWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PunchClock];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 提醒打卡*/
+ (NSURLSessionTask *)AlertClockActivityWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_AlertClock];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 获取本周经文*/
+ (NSURLSessionTask *)GetWeekBibleWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_WeekBible];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 获取推荐物品列表*/
+ (NSURLSessionTask *)GetRecommendListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_Recommend];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏/取消收藏文章*/
+ (NSURLSessionTask *)ArticleCollectionInOrOutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CollectionArticle];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏/取消收藏代祷*/
+ (NSURLSessionTask *)PrayCollectionInOrOutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CollectionPray];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏/取消收藏音乐*/
+ (NSURLSessionTask *)MusicCollectionInOrOutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CollectionMusic];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏文章列表*/
+ (NSURLSessionTask *)GetCollectionArticleListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CollectionArticleList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏代祷列表*/
+ (NSURLSessionTask *)GetCollectionPrayListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CollectionPrayList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏音乐列表*/
+ (NSURLSessionTask *)GetCollectionMusicListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_CollectionMusicList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏文章列表*/
+ (NSURLSessionTask *)GetPublishArticleListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishArticleList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏代祷列表*/
+ (NSURLSessionTask *)GetPublishPrayListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishPrayList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 收藏音乐列表*/
+ (NSURLSessionTask *)GetPublishMusicListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_PublishMusicList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 删除文章*/
+ (NSURLSessionTask *)DeleteArticleByIdWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DeleteArticle];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 删除代祷*/
+ (NSURLSessionTask *)DeletePrayByIdWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DeletePray];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 删除音乐*/
+ (NSURLSessionTask *)DeleteMusicByIdWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_DeleteMusic];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 获取团契列表*/
+ (NSURLSessionTask *)GetFellowshipListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_FellowshipList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** QQ登录*/
+ (NSURLSessionTask *)QQLogoinWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_QQLogoin];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 微信登录*/
+ (NSURLSessionTask *)WCLogoinWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_WCLogoin];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 刷新用户信息*/
+ (NSURLSessionTask *)RefreshUserInfoWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_RefreshUserInfo];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}

/** 举报*/
+ (NSURLSessionTask *)UserReportWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UserReport];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:NO];
}

/** 检索圣经*/
+ (NSURLSessionTask *)BibleSearchListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_BibleSearchList];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}










/** 付费验证*/
+ (NSURLSessionTask *)VipValidateWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_VipValidate];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}
/** 更新提醒*/
+ (NSURLSessionTask *)UpdateTipWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_UpdateTip];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}
/** VIP详情*/
+ (NSURLSessionTask *)VIPDetailstWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    NSString *url = [NSString stringWithFormat:@"%@%@", CR_ApiPrefix, CR_VIPDetails];
    return [self requestWithResMethod:resMethod URL:url parameters:parameters success:success failure:failure isCache:isCache];
}


/// POST/GET网络请求方法
/// @param resMethod 请求方式
/// @param URL 请求地址
/// @param parameters 参数
/// @param success 成功回调
/// @param failure 失败回调
/// @param isCache 是否缓存
+ (NSURLSessionTask *)requestWithResMethod:(ResMethod)resMethod URL:(NSString *)URL parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache {
    [PPNetworkHelper closeLog];
//    [PPNetworkHelper openNetworkActivityIndicator:YES];
    [PPNetworkHelper setRequestTimeoutInterval:RequestTimeout];
//    [PPNetworkHelper closeAES];
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
                              success:success
                              failure:failure];
            } failure:^(NSError *error) {
#if defined(DEBUG)
                [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
#endif
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
                              success:success
                              failure:failure];
            } failure:^(NSError *error) {
#if defined(DEBUG)
                [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
#endif
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
    [PPNetworkHelper closeLog];
    [PPNetworkHelper setRequestTimeoutInterval:RequestTimeout];
    
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
        [SVProgressHUD showProgress:progress.fractionCompleted status:@"文件上传进度"];
        NLog(@"文件上传进度:%.2f%%", progress.fractionCompleted);
    } success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self responseHandler:URL isCache:NO parameters:parameters responseObject:responseObject success:success failure:failure];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
#if defined(DEBUG)
        [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
#endif
        failure(error);
    }];
}

/// 多图上传方法
/// @param URL 请求地址
/// @param parameters 参数
/// @param images 图片数组
/// @param imageNames 图片名数组
/// @param name 服务器接收字段名
/// @param process 进度
/// @param success 成功
/// @param failure 失败
+ (NSURLSessionTask *)imagesRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)imageNames name:(nonnull NSString *)name process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NLog(@"接口URL:%@\n参数Params:%@", URL, parameters);
    [PPNetworkHelper closeLog];
    [PPNetworkHelper setRequestTimeoutInterval:25.0f];
    
#pragma mark - AUTH认证
    [PPNetworkHelper setValue:NCurrentUser.token forHTTPHeaderField:@"Token"];
    [PPNetworkHelper setValue:NCurrentUser.account forHTTPHeaderField:@"Account"];
    
#pragma mark - Resquest
    return [PPNetworkHelper uploadImagesWithURL:URL
                                     parameters:parameters
                                           name:name
                                         images:images
                                      fileNames:imageNames
                                     imageScale:0.65f
                                      imageType:@"image/jpg/png/jpeg"
                                       progress:^(NSProgress *progress) {
        if (progress.finished) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showWithStatus:@"处理中..."];
        } else {
            [SVProgressHUD showProgress:progress.fractionCompleted status:@"上传进度"];
            NLog(@"图片上传进度:%.2f%%", progress.fractionCompleted);
        }
        process(progress);
    } success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self responseHandler:URL isCache:NO parameters:parameters responseObject:responseObject success:success failure:failure];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
#if defined(DEBUG)
        [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
#endif
        failure(error);
    }];
}

/// 多文件/多类型上传
/// @param URL 上传接口地址
/// @param parameters 参数
/// @param image 图片
/// @param imageName 图片参数名
/// @param audioFileData 音频二进制数据
/// @param audioParamName 音频参数名
/// @param audioName 音频名
/// @param fileData 文件二进制数据
/// @param fileParamName 文件参数名
/// @param fileName 文件名
/// @param process 进度回调
/// @param success 成功回调
/// @param failure 失败回调
+ (NSURLSessionTask *)uploadRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameters image:(UIImage *)image imageName:(NSString *)imageName audioFileData:(NSData *)audioFileData audioParamName:(NSString *)audioParamName audioName:(NSString *)audioName fileData:(NSData *)fileData fileParamName:(NSString *)fileParamName fileName:(NSString *)fileName process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NLog(@"接口URL:%@\n参数Params:%@", URL, parameters);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
#pragma mark - AUTH认证
    [manager.requestSerializer setValue:NCurrentUser.token forHTTPHeaderField:@"Token"];
    [manager.requestSerializer setValue:NCurrentUser.account forHTTPHeaderField:@"Account"];
    
    return [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 时间戳命名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy_MM_ddHH:mm:ss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName = [NSString stringWithFormat:@"image%@.png", str];
        // 1.图片二进制文件
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
        [formData appendPartWithFileData:imageData
                                    name:imageName
                                fileName:imageFileName
                                mimeType:@"image/jpg/png/jpeg"];
        // 2.音频文件处理
        audioFileData ? [formData appendPartWithFileData:audioFileData name:audioParamName fileName:audioName mimeType:@"audio/mpeg/mp3/m4a/wav"] : nil;
        // 3.歌词文件处理
        audioFileData ? [formData appendPartWithFileData:audioFileData name:fileParamName fileName:fileName mimeType:@"application/octet-stream"] : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"文件上传进度"];
        NLog(@"文件上传进度:%.2f%%", uploadProgress.fractionCompleted);
        process(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self responseHandler:URL isCache:NO parameters:parameters responseObject:JSON success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
#if defined(DEBUG)
        [MBProgressHUD showTopTipMessage:[NSString stringWithFormat:@"Oops!连接失败,请检查网络:%ld", (long)error.code] isWindow:YES];
#endif
        failure(error);
    }];
}

#pragma mark - 请求响应处理方法_____________________COMMON_________________________
/// 处理返回数据的通用模板
///  @param URL API地址
///  @param isCache 是否缓存
///  @param parameters 参数
///  @param responseObject 返回的JSON数据
///  @param success 成功回调
///  @param failure 失败回调
+ (void)responseHandler:(NSString *)URL isCache:(BOOL)isCache parameters:(NSDictionary *)parameters responseObject:(id)responseObject success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure {
    NLog(@"[服务器Response]：%@", responseObject);
    if ([[responseObject objectForKey:@"status"] boolValue]) {
        // 0.正常无异常
        isCache ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        success(responseObject);
    } else {
        NSError *error = nil;
        NSInteger code = [[responseObject objectForKey:@"statusCode"] integerValue];
        if (code == 6005 || code == 6010 || code == 6006) {
            // 1.登录状态异常
            NSString *errorInfo = [responseObject objectForKey:@"msg"];
            NSString *errorStr = [NSString stringWithFormat:@"%ld\n%@", (long)code, errorInfo];
            error = [NSError errorWithDomain:NSCocoaErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey : @"登录状态异常", NSLocalizedFailureReasonErrorKey : errorInfo, NSLocalizedRecoverySuggestionErrorKey : @"重新登录"}];
            [SVProgressHUD showErrorWithStatus:errorStr];
            // 退出当前登录
            [NUserManager logout:nil];
        } else if (code == 4001) {
            // 2.参数不合法异常
            NSString *warnInfo = [responseObject objectForKey:@"data"];
            NSString *warningStr = [NSString stringWithFormat:@"%ld\n%@", (long)code, warnInfo];
            error = [NSError errorWithDomain:NSCocoaErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey : @"服务器接收到的参数异常", NSLocalizedFailureReasonErrorKey : warnInfo, NSLocalizedRecoverySuggestionErrorKey : @"检查请求参数合法性"}];
            [SVProgressHUD showInfoWithStatus:warningStr];
        } else {
            // 3.其他服务器返回异常
            NSString *unknowStr = [responseObject objectForKey:@"msg"];
            error = [NSError errorWithDomain:NSCocoaErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey : @"Service Exception!", NSLocalizedFailureReasonErrorKey : unknowStr}];
            [SVProgressHUD showInfoWithStatus:unknowStr];
        }
        // 隐藏提示框，返回错误NSError❌
        [SVProgressHUD dismissWithDelay:1.5f completion:^{
            failure(error);
        }];
    }
}

@end
