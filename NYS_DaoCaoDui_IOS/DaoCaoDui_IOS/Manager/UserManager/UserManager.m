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

#pragma mark -- 登录类型分发 --
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion {
    
    if (loginType == NUserLoginTypePwd) {
        // 账号登录
        [self loginToServer:loginType params:params completion:completion];
    } else {
        // 友盟登录类型
        UMSocialPlatformType platFormType;
        switch (loginType) {
            case NUserLoginTypeQQ:
                platFormType = UMSocialPlatformType_QQ;
                break;
            case NUserLoginTypeWeChat:
                platFormType = UMSocialPlatformType_WechatSession;
                break;
            default:
                platFormType = UMSocialPlatformType_UnKnown;
                break;
        }
        
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
                [self loginToServer:loginType params:params completion:completion];
            }
        }];
    }
}

#pragma mark —- 手动登录到服务器 —-
- (void)loginToServer:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion {
//    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    
    switch (loginType) {
        case NUserLoginTypePwd: {
            [NYSRequest getLoginWithResMethod:POST parameters:params success:^(id response) {
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
- (void)LoginSuccess:(id)responseObject completion:(loginBlock)completion {
    NPostNotification(NNotificationLoginStateChange, @YES);
    NSDictionary *data = responseObject[@"data"];
    self.currentUserInfo = [UserInfo modelWithDictionary:data];
    // 登录IM
    [[IMManager sharedIMManager] IMLoginwithCurrentUserInfo:self.currentUserInfo completion:^(BOOL success, id  _Nullable description) {
        
    }];
    // 缓存用户信息
    [self saveUserInfo:data];
    // 修改登录状态
    self.isLogined = YES;
}

#pragma mark —- 储存用户信息 —-
- (void)saveUserInfo:(NSDictionary *)userDict {
    if (userDict) {
        YYCache *cache = [[YYCache alloc] initWithName:NUserCacheName];
        [cache setObject:userDict forKey:NUserModelCache];
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
    [NYSRequest getLogoutWithResMethod:GET parameters:nil success:^(id response) {
        logoutSuccess(self, completion);
    } failure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"正常退出失败是否强制登录吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            logoutSuccess(self, completion);
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NLog(@"Cancel Action");
        }];
        
        [alertController addAction:logoutAction];
        [alertController addAction:cancelAction];
        [NAppWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    } isCache:NO];
}
static void logoutSuccess(UserManager *object, void (^completion)(BOOL, id)) {
    [[IMManager sharedIMManager] IMLogout];
    
    // 清除APP角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    [[IMManager sharedIMManager] IMLogout];
    
    object.currentUserInfo = nil;
    object.isLogined = NO;
    
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
