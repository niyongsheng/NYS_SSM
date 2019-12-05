//
//  AppDelegate.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/25.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化window
    [self initWindow];
    
    // WRNavigationBar 初始化
    [self initWRNavigationBar];
    
    // 初始化app服务
    [self initService];
    
    // JPush初始化
    [self initJpush:launchOptions];
    
    // 友盟初始化
    [self initUMeng];
    
    // 初始化用户系统
    [self initUserManager];
    
    // 初始化IM
    [self initIMManager];
    
    // 网络监听
    [self monitorNetworkStatus];
    
    // 广告页
    [AppManager appStart];
    
    // FPS监测
    [AppManager showFPS];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
