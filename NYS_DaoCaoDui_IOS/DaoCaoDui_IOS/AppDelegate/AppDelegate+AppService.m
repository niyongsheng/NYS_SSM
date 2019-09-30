//
//  AppDelegate+AppService.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <JSPatchPlatform/JSPatch.h>
#import "OpenUDID.h"
#import "NYSTabBarController.h"
#import "NYSLoginViewController.h"
#import "NYSRootNavigationController.h"

@implementation AppDelegate (AppService)

#pragma mark —- 初始化服务 --
- (void)initService {
    // 注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:NNotificationLoginStateChange
                                               object:nil];
    
    // 网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:NNotificationNetWorkStateChange
                                               object:nil];
}

#pragma mark —- 初始化window --
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    // [[UIButton appearance] setShowsTouchWhenHighlighted:YES];
    // 当某个class被包含在另外一个class内时，才修改外观。
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}


#pragma mark -- 初始化用户系统 --
- (void)initUserManager {
    NLog(@"设备IMEI ：%@",[OpenUDID value]);
    
    if([NUserManager loadUserInfo]){

        // 如果有本地数据，先展示TabBar 随后异步自动登录
        self.mainTabBar = [NYSTabBarController new];
        self.window.rootViewController = self.mainTabBar;

        // 自动登录
        [NUserManager autoLoginToServer:^(BOOL success, NSString *des) {
            if (success) {
                NLog(@"自动登录成功");
                NPostNotification(NNotificationAutoLoginSuccess, nil);
            } else {
                [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
            }
        }];
    } else {
        // 没有登录过，展示登录页面
        NPostNotification(NNotificationLoginStateChange, @NO)
        NLog(@"没有登录过，显示登录页面");
    }
}

#pragma mark -- 登录状态处理 --
- (void)loginStateChange:(NSNotification *)notification {
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) { // 登陆成功加载主窗口控制器
        // 为避免自动登录成功刷新tabbar
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[NYSTabBarController class]]) {
            self.mainTabBar = [NYSTabBarController new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            
            self.window.rootViewController = self.mainTabBar;
            
            [NAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
            
        }
        
    } else { // 登陆失败加载登陆页面控制器
        self.mainTabBar = nil;

        CATransition *anima = [CATransition animation];
        anima.type = @"fade"; // 设置动画的类型
        anima.subtype = kCATransitionFromRight; // 设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = [NYSLoginViewController new];
        
        [NAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
    }
    
    // 展示FPS
    [AppManager showFPS];
}

#pragma mark -- 友盟 初始化 --
- (void)initUMeng {
    // 友盟+
    [UMConfigure setLogEnabled:YES];
    [MobClick setScenarioType:E_UM_NORMAL];
    [MobClick setCrashReportEnabled:YES];
    [UMConfigure initWithAppkey:UMengKey channel:@"App Store"];
    
    [self configUSharePlatforms];
}

#pragma mark -- 配置第三方 --
- (void)configUSharePlatforms {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:AppKey_Wechat appSecret:Secret_Wechat redirectURL:nil];
    /* 移除相应平台的分享，如微信收藏 */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:AppKey_TencentQQ  appSecret:nil redirectURL:nil];
}

#pragma mark -- JSPatch 初始化 --
- (void)initJSPatch {
    [JSPatch startWithAppKey:JSPatchKey];
    [JSPatch setupRSAPublicKey:RSAPublicKey];
    [JSPatch sync];
}

#pragma mark -- OpenURL 回调 --
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark -- 网络状态变化 --
- (void)netWorkStateChange:(NSNotification *)notification {
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) { // 有网络
        if ([NUserManager loadUserInfo] && !NIsLogin) {//有用户数据 并且 未登录成功 重新来一次自动登录
            [NUserManager autoLoginToServer:^(BOOL success, NSString *des) {
                if (success) {
                    NLog(@"网络改变后，自动登录成功");
                    [MBProgressHUD showSuccessMessage:@"网络改变后，自动登录成功"];
                    NPostNotification(NNotificationAutoLoginSuccess, nil);
                } else {
                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
                }
            }];
        }
        
    } else { // 登陆失败加载登陆页面控制器
        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
    }
}

#pragma mark -- 网络状态监听 --
- (void)monitorNetworkStatus {
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                NLog(@"网络环境：未知网络");
                // 无网络
            case PPNetworkStatusNotReachable:
                NLog(@"网络环境：无网络");
                NPostNotification(NNotificationNetWorkStateChange, @NO);
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                NLog(@"网络环境：手机自带网络");
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                NLog(@"网络环境：WiFi");
                NPostNotification(NNotificationNetWorkStateChange, @YES);
                break;
        }
        
    }];
    
}

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (UIViewController *)getCurrentUIVC {
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    } else {
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    }
    return superVC;
}

@end
