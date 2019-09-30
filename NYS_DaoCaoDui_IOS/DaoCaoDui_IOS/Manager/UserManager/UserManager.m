//
//  UserManager.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/31.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "UserManager.h"
#import <UMShare/UMShare.h>

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        // 被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:NNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark -- 三方登录 --
- (void)login:(UserLoginType)loginType completion:(loginBlock)completion {
    [self login:loginType params:nil completion:completion];
}

#pragma mark -- 带参数登录 --
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion {
    self.loginType = loginType;
    // 友盟登录类型
    UMSocialPlatformType platFormType;
    if (loginType == NUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    } else if (loginType == NUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    } else {
        platFormType = UMSocialPlatformType_UnKnown;
    }
    
    // 第三方登录 + 传参
    if (loginType != NUserLoginTypePwd) {
        [MBProgressHUD showActivityMessageInView:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                UMSocialUserInfoResponse *resp = result;
                // 授权信息
                NLog(@"QQ uid: %@", resp.uid);
                NLog(@"QQ openid: %@", resp.openid);
                NLog(@"QQ accessToken: %@", resp.accessToken);
                NLog(@"QQ expiration: %@", resp.expiration);
                // 用户信息
                NLog(@"QQ name: %@", resp.name);
                NLog(@"QQ iconurl: %@", resp.iconurl);
                NLog(@"QQ gender: %@", resp.unionGender);
                // 第三方平台SDK源数据
                NLog(@"QQ originalResponse: %@", resp.originalResponse);

                NSDictionary *params = @{@"openid":resp.openid,
                                         @"nickname":resp.name,
                                         @"headimgurl":resp.iconurl,
                                         @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2,
                                         @"cityname":resp.originalResponse[@"city"]};
                [self loginToServer:params completion:completion];
            }
        }];
    } else { // 账号登录
        [self loginToServer:params completion:completion];
    }
}

#pragma mark —- 手动登录到服务器 —-
- (void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion {
//    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    
    switch (self.loginType) {
        case NUserLoginTypePwd: {
            [NYSRequest getLoginWithParameters:params success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            } isCache:NO];
        }
            break;
            
        case NUserLoginTypeQQ: {
            [NYSRequest QQLogoinWithParameters:params success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            } isCache:NO];
        }
            break;
            
        case NUserLoginTypeWeChat: {
            [NYSRequest WCLogoinWithParameters:params success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            } isCache:NO];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- 自动登录到服务器 —-
- (void)autoLoginToServer:(loginBlock)completion{
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_auto_login) parameters:nil success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark —- 登录成功处理 —-
- (void)LoginSuccess:(id )responseObject completion:(loginBlock)completion {
//    NPostNotification(NNotificationLoginStateChange, @YES);
    if (ValidDict(responseObject)) {
        if (ValidDict(responseObject[@"returnValue"])) {
            NSDictionary *data = responseObject[@"returnValue"];
//            if (ValidStr(data[@"account"]) && ValidStr(data[@"yunxinToken"])) {
//                // 登录IM
//                [[IMManager sharedIMManager] IMLogin:data[@"account"] IMPwd:data[@"yunxinToken"] completion:^(BOOL success, NSString *des) {
//                    [MBProgressHUD hideHUD];
//                    if (success) {
//                        self.currentUserInfo = [UserInfo modelWithDictionary:data];
//                        [self saveUserInfo];
//                        self.isLogined = YES;
//                        if (completion) {
//                            completion(YES, nil);
//                        }
//                        NPostNotification(NNotificationLoginStateChange, @YES);
//                    } else {
//                        if (completion) {
//                            completion(NO, @"IM登录失败");
//                        }
//                        NPostNotification(NNotificationLoginStateChange, @NO);
//                    }
//                }];
//            } else {
//                if (completion) {
//                    completion(NO, @"登录返回IM数据异常");
//                }
//                NPostNotification(NNotificationLoginStateChange, @NO);
//            }
            
            self.currentUserInfo = [UserInfo modelWithDictionary:data];
            [self saveUserInfo];
            self.isLogined = YES;
            if (completion) {
                completion(YES, nil);
            }
            NPostNotification(NNotificationLoginStateChange, @YES);
        }
    } else {
        if (completion) {
            completion(NO, @"登录服务器返回数据异常");
        }
        NPostNotification(NNotificationLoginStateChange, @NO);
    }
}

#pragma mark —- 储存用户信息 —-
- (void)saveUserInfo {
    if (self.currentUserInfo) {
        YYCache *cache = [[YYCache alloc] initWithName:NUserCacheName];
        NSDictionary *dic = [self.currentUserInfo modelToJSONObject];
        [cache setObject:dic forKey:NUserModelCache];
    }
}

#pragma mark —- 加载缓存的用户信息 —-
- (BOOL)loadUserInfo {
    YYCache *cache = [[YYCache alloc] initWithName:NUserCacheName];
    NSDictionary *userDic = (NSDictionary *)[cache objectForKey:NUserModelCache];
    if (userDic) {
        self.currentUserInfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark —- 被踢下线 —-
- (void)onKick {
    [self logout:nil];
}

#pragma mark -- 退出登录 --
- (void)logout:(void (^)(BOOL, id))completion {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    [[IMManager sharedIMManager] IMLogout];
    
    self.currentUserInfo = nil;
    self.isLogined = NO;
    
    // 移除缓存
    YYCache *cache = [[YYCache alloc] initWithName:NUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES, nil);
        }
    }];
    
    NPostNotification(NNotificationLoginStateChange, @NO);
}

@end
