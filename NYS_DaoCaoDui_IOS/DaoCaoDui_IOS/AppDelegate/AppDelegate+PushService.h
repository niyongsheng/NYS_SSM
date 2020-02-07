//
//  AppDelegate+PushService.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/4.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import <JPush/JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (PushService) <UNUserNotificationCenterDelegate, JPUSHRegisterDelegate, RCIMReceiveMessageDelegate>

/// 初始化推送服务
- (void)initPush:(NSDictionary *)launchOptions application:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
