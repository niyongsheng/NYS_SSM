//
//  UserManager.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/31.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "UserManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "KHAlertPickerController.h"
#import "NYSFellowshipModel.h"
#import "NYSEmitterUtil.h"

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
        // 1.账号密码登录
        [self loginToServer:loginType params:params completion:completion];
    } else if (loginType == NUserLoginTypeApple) {
        // 2.苹果登录
        [self loginToServer:loginType params:params completion:completion];
    } else {
        // 3.友盟第三方登录
        UMSocialPlatformType platFormType;
        switch (loginType) {
            case NUserLoginTypeQQ : platFormType = UMSocialPlatformType_QQ; break;
            case NUserLoginTypeWeChat : platFormType = UMSocialPlatformType_WechatSession; break;
            default : platFormType = UMSocialPlatformType_UnKnown; break;
        }
        
        [SVProgressHUD showWithStatus:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [SVProgressHUD dismiss];
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            } else {
                UMSocialUserInfoResponse *resp = result;
                // 第三方平台SDK源数据
                NLog(@"UMSocialManager originalResponse: %@", resp.originalResponse);
                
                NSDictionary *qqParams = @{@"qqUnionId" : resp.uid,
                                           @"nickname" : resp.name,
                                           @"iconUrl" : resp.iconurl,
                                           @"fellowship" : params ? [params stringValueForKey:@"fellowship" default:@""] : @"",
                                           @"gender" : [resp.unionGender isEqualToString:@"男"] ? @1 : @2,
                                           @"city" : resp.originalResponse[@"city"]};
                NSDictionary *wcParams = @{@"wxUnionId" : resp.uid,
                                           @"nickname" : resp.name,
                                           @"iconUrl" : resp.iconurl,
                                           @"fellowship" : params ? [params stringValueForKey:@"fellowship" default:@""] : @"",
                                           @"gender" : [resp.unionGender isEqualToString:@"男"] ? @1 : @2,
                                           @"city" : resp.originalResponse[@"city"]};
                if (loginType == NUserLoginTypeQQ) {
                    [self loginToServer:loginType params:qqParams completion:completion];
                } else if (loginType == NUserLoginTypeWeChat) {
                    [self loginToServer:loginType params:wcParams completion:completion];
                }
            }
        }];
    }
}

#pragma mark —- 手动登录到服务器 —-
- (void)loginToServer:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion {
    switch (loginType) {
        case NUserLoginTypePwd: {
            [NYSRequest LoginWithResMethod:POST parameters:params success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            }];
        }
            break;
            
        case NUserLoginTypeApple: {
            [NYSRequest LoginByAppleWithResMethod:POST parameters:params success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (error.code == 6013) {
                    [self chooseFellowship:NUserLoginTypeApple params:params.mutableCopy completion:completion];
                } else {
                    completion(NO, error.localizedDescription);
                }
            }];
        }
            break;
            
        case NUserLoginTypeQQ: {
            [NYSRequest QQLogoinWithResMethod:POST
                                   parameters:params
                                      success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (error.code == 6013) {
                    [self chooseFellowship:NUserLoginTypeQQ params:params.mutableCopy completion:completion];
                }
            } isCache:NO];
        }
            break;
            
        case NUserLoginTypeWeChat: {
            [NYSRequest WCLogoinWithResMethod:POST
                                   parameters:params
                                      success:^(id response) {
                [self LoginSuccess:response completion:completion];
            } failure:^(NSError *error) {
                if (error.code == 6013) {
                    [self chooseFellowship:NUserLoginTypeQQ params:params.mutableCopy completion:completion];
                }
            } isCache:NO];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- 首次第三方登录选择要注册的团契id —-
- (void)chooseFellowship:(UserLoginType)loginType params:(NSMutableDictionary *)params completion:(loginBlock)completion {
    WS(weakSelf);
    [NYSRequest GetFellowshipListWithResMethod:GET
                                    parameters:nil success:^(id response) {
        [NYSFellowshipModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        NSMutableArray<NYSFellowshipModel *> *fellowshipArray = [NYSFellowshipModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        
        NSMutableArray *titleArray = [NSMutableArray array];
        for (NYSFellowshipModel *fellowship in fellowshipArray) {
            [titleArray addObject:fellowship.fellowshipName];
        }
        // 团契选框
        KHAlertPickerController *alertPicker = [KHAlertPickerController  alertPickerWithTitle:@"选择团契" Separator:nil SourceArr:titleArray];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"注册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            for (NYSFellowshipModel *fellowship in fellowshipArray) {
                if ([fellowship.fellowshipName isEqualToString:alertPicker.contentStr]) {
                    [params setValuesForKeysWithDictionary:@{@"fellowship" : @(fellowship.idField)}];
                }
            }
            // 第三方登录注册
            switch (loginType) {
                case NUserLoginTypeQQ: {
                    [NYSRequest QQLogoinWithResMethod:POST
                                           parameters:params
                                              success:^(id response) {
                        [weakSelf LoginSuccess:response completion:completion];
                    } failure:^(NSError *error) {
                        
                    } isCache:NO];
                }
                    break;
                    
                case NUserLoginTypeWeChat: {
                    [NYSRequest WCLogoinWithResMethod:POST
                                           parameters:params
                                              success:^(id response) {
                        [weakSelf LoginSuccess:response completion:completion];
                    } failure:^(NSError *error) {
                        
                    } isCache:NO];
                }
                    break;
                
                case NUserLoginTypeApple: {
                    [weakSelf login:NUserLoginTypeApple params:params completion:completion];
                }
                    break;
                    
                default:
                    break;
            }
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"其他团契" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"18853936112"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        [alertPicker addCompletionAction:sureAction];
        [alertPicker addCompletionAction:otherAction];
        [NRootViewController presentViewController:alertPicker animated:YES completion:nil];
    } failure:^(NSError *error) {
        
    } isCache:YES];
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
    [NYSRequest LogoutWithResMethod:GET parameters:nil success:^(id response) {
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
