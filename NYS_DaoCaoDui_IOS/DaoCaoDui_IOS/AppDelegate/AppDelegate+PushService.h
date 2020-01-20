//
//  AppDelegate+PushService.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/4.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import <JPUSHService.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (PushService) <JPUSHRegisterDelegate, RCIMReceiveMessageDelegate>

- (void)initPush:(NSDictionary *)launchOptions application:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
