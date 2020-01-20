//
//  AppDelegate+PushService.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/4.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate+PushService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation AppDelegate (PushService)

- (void)initPush:(NSDictionary *)launchOptions application:(UIApplication *)application {
    // Register Push
    [self initAPNsWithApplication:application];
    // IDFA
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    // Init JPush
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPUSH_APPKEY
                          channel:JPUSH_CHANNEl
                 apsForProduction:JPUSH_IsProd
            advertisingIdentifier:advertisingId];
}

- (void)initAPNsWithApplication:(UIApplication *)application {
    // 1.极光推送注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert |
        JPAuthorizationOptionBadge|
        JPAuthorizationOptionSound|
        JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert |
        JPAuthorizationOptionBadge|
        JPAuthorizationOptionSound;
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 2.融云推送注册
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                            (UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert) categories:nil];
    [application registerUserNotificationSettings:settings];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 融云-注册DeviceToken
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    // 极光-注册DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Fail Optional
    NLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - RongCloudRegisterDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    
}

#pragma mark - JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // iOS 10 Support 前台监听通知APP自动响应
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
        completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
    } else {
        // Fallback on earlier versions
    }
    
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

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // iOS 10 Support 后台点击通知拉起APP响应
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // 取得APNs标准信息内容
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *content = [aps valueForKey:@"alert"]; // 推送显示的内容
        NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; // badge数量
        NSString *sound = [aps valueForKey:@"sound"]; // 播放的声音
        // 非空 取得Extras字段内容
        if (![[userInfo valueForKey:@"extras"] isKindOfClass:[NSNull class]]) {
            NSString *type = [userInfo valueForKey:@"type"]; // 任务单type 单子类型:1投诉单;2报修单;3预约单;4房屋审核单
            NSString *requestId = [userInfo valueForKey:@"requestId"]; // 任务单ID
            
            NLog(@"content =[%@], badge=[%ld], sound=[%@], type=[%@], requestId=[%@]", content, badge, sound, type, requestId);
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
