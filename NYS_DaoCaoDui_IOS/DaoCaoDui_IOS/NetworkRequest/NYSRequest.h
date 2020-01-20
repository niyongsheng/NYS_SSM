//
//  NYSRequest.h
//  NYSUtils
//
//  Created by 倪永胜 on 2018/12/1.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ResMethod) {
    POST = 0,
    GET
};

typedef void(^NYSRequestSuccess)(id response);
typedef void(^NYSRequestFailure)(NSError *error);
typedef void(^NYSUploadProcess)(NSProgress *progress);

@interface NYSRequest : NSObject

/** 登录*/
+ (NSURLSessionTask *)LoginWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 退出*/
+ (NSURLSessionTask *)LogoutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 注册*/
+ (NSURLSessionTask *)RegistWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 忘记密码*/
+ (NSURLSessionTask *)ResetWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 验证码*/
+ (NSURLSessionTask *)SendOneTimeCodeWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 修改个人信息*/
+ (NSURLSessionTask *)UpdateUserInfoWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 签到*/
+ (NSURLSessionTask *)DosignWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 积分记录详情*/
+ (NSURLSessionTask *)GetScoreRecordWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 个人信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForUserWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 群组信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForGroupWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 群组成员信息提供者*/
+ (NSURLSessionTask *)DataProviderInfoForGroupMembersWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 单文件上传*/
+ (NSURLSessionTask *)UploadFileWithFilePath:(NSString *)filePath parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 多图上传*/
+ (NSURLSessionTask *)UploadImagesWithImages:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)imageNames name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 获取轮播图*/
+ (NSURLSessionTask *)GetBannerList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取公告*/
+ (NSURLSessionTask *)GetPublicnoticeList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取文章列表*/
+ (NSURLSessionTask *)GetArticleList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取活动列表*/
+ (NSURLSessionTask *)GetActivityList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取打卡活动列表*/
+ (NSURLSessionTask *)GetClockActivityList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取代祷列表*/
+ (NSURLSessionTask *)GetPrayList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取歌单列表*/
+ (NSURLSessionTask *)GetMusicMenuList:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取歌单（含歌曲列表）*/
+ (NSURLSessionTask *)GetMusicMenuById:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 发布分享*/
+ (NSURLSessionTask *)PublishArtcleWithImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 发布代祷*/
+ (NSURLSessionTask *)PublishPrayWithImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 发布音频*/
+ (NSURLSessionTask *)PublishMusicWithImage:(UIImage *)image imageName:(NSString *)imageName audioFileData:(NSData *)audioFileData audioParamName:(NSString *)audioParamName audioName:(NSString *)audioName fileData:(NSData *)fileData fileParamName:(NSString *)fileParamName fileName:(NSString *)fileName parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 发布活动*/
+ (NSURLSessionTask *)PublishActivityWithImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters process:(NYSUploadProcess)process success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 结束活动*/
+ (NSURLSessionTask *)DismissActivityWithActivityID:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 加入活动*/
+ (NSURLSessionTask *)JoinActivityWithActivityID:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 退出活动*/
+ (NSURLSessionTask *)QuitActivityWithActivityID:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 获取群列表*/
+ (NSURLSessionTask *)GetGroupListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取用户列表*/
+ (NSURLSessionTask *)GetUserListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 打卡*/
+ (NSURLSessionTask *)PunchClockActivityWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 提醒打卡*/
+ (NSURLSessionTask *)AlertClockActivityWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 获取本周经文*/
+ (NSURLSessionTask *)GetWeekBibleWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 获取推荐物品列表*/
+ (NSURLSessionTask *)GetRecommendListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏/取消收藏文章*/
+ (NSURLSessionTask *)ArticleCollectionInOrOutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏/取消收藏代祷*/
+ (NSURLSessionTask *)PrayCollectionInOrOutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏/取消收藏音乐*/
+ (NSURLSessionTask *)MusicCollectionInOrOutWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏文章列表*/
+ (NSURLSessionTask *)GetCollectionArticleListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏代祷列表*/
+ (NSURLSessionTask *)GetCollectionPrayListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏音乐列表*/
+ (NSURLSessionTask *)GetCollectionMusicListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏文章列表*/
+ (NSURLSessionTask *)GetPublishArticleListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏代祷列表*/
+ (NSURLSessionTask *)GetPublishPrayListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 收藏音乐列表*/
+ (NSURLSessionTask *)GetPublishMusicListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;
/** 删除文章*/
+ (NSURLSessionTask *)DeleteArticleByIdWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 删除代祷*/
+ (NSURLSessionTask *)DeletePrayByIdWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 删除音乐*/
+ (NSURLSessionTask *)DeleteMusicByIdWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure;
/** 获取团契列表*/
+ (NSURLSessionTask *)GetFellowshipListWithResMethod:(ResMethod)resMethod parameters:(NSDictionary *)parameters success:(NYSRequestSuccess)success failure:(NYSRequestFailure)failure isCache:(BOOL)isCache;











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

