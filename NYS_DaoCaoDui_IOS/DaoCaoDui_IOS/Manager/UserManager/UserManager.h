//
//  UserManager.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/31.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

typedef NS_ENUM(NSInteger, UserLoginType) {
    NUserLoginTypeUnKnow = 0, // 未知
    NUserLoginTypeWeChat, // 微信登录
    NUserLoginTypeQQ, // QQ登录
    NUserLoginTypePwd, // 账号密码登录
    NUserLoginTypeApple, // Sign In With Apple
};

typedef void (^loginBlock)(BOOL success, id description);

#define NIsLogin [UserManager sharedUserManager].isLogined
#define NCurrentUser [UserManager sharedUserManager].currentUserInfo
#define NUserManager [UserManager sharedUserManager]

@interface UserManager : NSObject

/**
 用户管理单例
 
 @return sharedUserManager
 */
SINGLETON_FOR_HEADER(UserManager)

/** 当前用户 */
@property (nonatomic, strong) UserInfo *currentUserInfo;
/** 是否已登录 */
@property (nonatomic, assign) BOOL isLogined;
/** 请求序列号 */
@property (assign, nonatomic) NSInteger seq;

#pragma mark -— 登录相关方法 --
/**
 第三方登录
 
 @param loginType 登录方式
 @param completion 回调
 */
- (void)login:(UserLoginType)loginType completion:(loginBlock)completion;

/**
 带参登录
 
 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion;

/**
 自动登录
 
 @param completion 回调
 */
- (void)autoLoginToServer:(loginBlock)completion;

/**
 退出登录
 
 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据
 
 @return 是否成功
 */
- (BOOL)loadUserInfo;

/// 缓存用户数据
/// @param userDict 当前登录用户信息
- (void)saveUserInfo:(NSDictionary *)userDict;

@end
