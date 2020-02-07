//
//  AppDelegate+PushService.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/4.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate+PushService.h"
#import <AdSupport/AdSupport.h>

@implementation AppDelegate (PushService)

- (void)initPush:(NSDictionary *)launchOptions application:(UIApplication *)application {
    // 1.极光推送注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound | JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 2.本地推送配置注册
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    // 必须写代理，不然无法监听通知的接收与点击事件
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    
    // IDFA
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    // Init JPush
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPUSH_APPKEY
                          channel:JPUSH_CHANNEl
                 apsForProduction:JPUSH_IsProd
            advertisingIdentifier:advertisingId];
    
    
    // 监听融云IM接收消息
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 极光-注册DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    // 融云-注册DeviceToken
    [[RCIMClient sharedRCIMClient] setDeviceTokenData:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Fail Optional
    NLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - RongCloudRegisterDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    // 监听融云接收到的消息并处理
    [NNotificationCenter postNotificationName:@"RCIMReceiveMessageNotification" object:nil];
}

#pragma mark - JPUSHRegisterDelegate
/// iOS 10 Support 前台监听通知APP自动响应
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler API_AVAILABLE(ios(10.0)) {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
    
    switch ([userInfo[@"type"] integerValue]) {
        case 0: {
            
        }
            break;
            
        case 1: {
            
        }
            break;
            
        default:
            break;
    }
}
/// iOS 10 Support app处于后台或退出时点击通知拉起APP响应
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)) {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // 取得APNs标准信息内容
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        // 非空 取得Extras字段内容
        if (![[userInfo valueForKey:@"extras"] isKindOfClass:[NSNull class]]) {
            NSString *type = [userInfo valueForKey:@"type"]; // type 通知类型
            NSString *requestId = [userInfo valueForKey:@"requestId"]; // 通知ID
            
            NLog(@"content =[%@], badge=[%ld], sound=[%@], type=[%@], requestId=[%@]", [aps valueForKey:@"alert"], (long)[[aps valueForKey:@"badge"] integerValue], [aps valueForKey:@"sound"], type, requestId);
            // 跳转控制器
            switch ([type integerValue]) {
                case 0: {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        // 处理通知
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();
}

/*
 * @brief handle UserNotifications.framework [openSettingsForNotification:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 当前管理的通知对象
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification NS_AVAILABLE_IOS(12.0) {
    
}

/**
 * 监测通知授权状态返回的结果
 * @param status 授权通知状态，详见JPAuthorizationStatus
 * @param info 更多信息，预留参数
 */
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    
}

@end
