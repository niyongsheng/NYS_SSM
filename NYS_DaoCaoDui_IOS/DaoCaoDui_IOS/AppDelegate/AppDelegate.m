//
//  AppDelegate.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/25.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"
#import <SDWebImage/SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化window
    [self initWindow];
    
    // WRNavigationBar 初始化
//    [self initWRNavigationBar];
    
    // 初始化app服务
    [self initService];
    
    // 推送初始化
    [self initPush:launchOptions application:application];
    
    // 友盟初始化
    [self initUMeng];
    
    // 初始化用户系统
    [self initUserManager];
    
    // 初始化IM
    [self initIMManager];
    
    // 网络监听
    [self monitorNetworkStatus];
    
    // 开屏广告
    [AppManager appStart];
    
#if defined(DEBUG)
    // FPS监测
    [AppManager showFPS];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
        @(ConversationType_PRIVATE),
        @(ConversationType_DISCUSSION),
        @(ConversationType_PUBLICSERVICE),
        @(ConversationType_PUBLICSERVICE),
        @(ConversationType_GROUP)
    ]];
    application.applicationIconBadgeNumber = unreadMsgCount + 0;
    // JPush 服务器端脚标
    [JPUSHService setBadge:application.applicationIconBadgeNumber];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - 内存警告处理
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *SDManager = [SDWebImageManager sharedManager];
    // 1.取消正在下载的操作
    [SDManager cancelAll];
    // 2.清除内存缓存
    [SDManager.imageCache clearWithCacheType:SDImageCacheTypeMemory completion:^{
        NLog(@"SDManager clear memory cache.");
    }];
}

@end
