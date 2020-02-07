//
//  AppDelegate+AppService.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogManager.h>
#import <UMAnalytics/MobClick.h>
#import "OpenUDID.h"
#import "NYSTabBarController.h"
#import "NYSLoginViewController.h"
#import "IMManager.h"

@implementation AppDelegate (AppService)

#pragma mark —- 初始化服务 --
- (void)initService {
    // 注册登录状态监听
    [NNotificationCenter addObserver:self
                            selector:@selector(loginStateChange:)
                                name:NNotificationLoginStateChange
                              object:nil];
    
    // 网络状态监听
    [NNotificationCenter addObserver:self
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
    // [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    NApplication.statusBarStyle = UIStatusBarStyleLightContent;
//    [NApplication setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    // 暂时不适配暗黑模式
    if (@available(iOS 13.0, *)) {
        [self.window setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    }
}
/*
#pragma mark -- WRNavigationBar 初始化 --
- (void)initWRNavigationBar {
    [WRNavigationBar wr_widely];
//    [WRNavigationBar wr_setBlacklist:@[@"NYSFAQViewController"]];
//    [WRNavigationBar wr_local];
//    [WRNavigationBar wr_setWhitelist:@[@"NYSDCDViewController",
//                                       @"HomeDetailViewController"]];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:NNavBgColor];
    // 设置导航栏默认的背景图
//    [WRNavigationBar wr_setDefaultNavBarBackgroundImage:[UIImage imageNamed:@"bg_nav"]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:NNavFontColor];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}
*/
#pragma mark -- 初始化用户系统 --
- (void)initUserManager {
    NLog(@"设备IMEI ：%@",[OpenUDID value]);
    // 判断是否登陆过
    if([NUserManager loadUserInfo]) {
        // 有本地缓存的用户数据，先展示TabBarVC随后异步自动登录
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

#pragma mark -- 初始化IM --
- (void)initIMManager {
    [[IMManager sharedIMManager] initRongCloudIM];
}

#pragma mark -- 登录状态处理 --
- (void)loginStateChange:(NSNotification *)notification {
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) { // 登陆成功加载主窗口控制器
        // 为避免自动登录成功刷新tabbar
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[NYSTabBarController class]]) {
            self.mainTabBar = [NYSTabBarController new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube"; // 设置动画的类型
            anima.subtype = kCATransitionFromRight; // 设置动画的方向
            anima.duration = 0.3f;
            
            self.window.rootViewController = self.mainTabBar;
            [NAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        }
    } else { // 登陆失败加载登陆页面控制器
        self.mainTabBar = nil;
        
        CATransition *anima = [CATransition animation];
        anima.type = @"cube"; // 设置动画的类型
        anima.subtype = kCATransitionFromLeft; // 设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = [NYSLoginViewController new];
        
        [NAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
    }
}

#pragma mark -- 友盟 初始化 --
- (void)initUMeng {
    // 友盟统计+分享
    [UMConfigure initWithAppkey:UMengKey channel:@"App Store"];
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];
    [MobClick setScenarioType:E_UM_NORMAL];
    [MobClick setCrashReportEnabled:YES];
    
    [self configUSharePlatforms];
}

#pragma mark -- 配置第三方登录 --
- (void)configUSharePlatforms {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:AppKey_Sina  appSecret:Secret_Sina redirectURL:RedirectURL_Sina];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:AppKey_TencentQQ  appSecret:Secret_TencentQQ redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:AppKey_Wechat appSecret:Secret_Wechat redirectURL:nil];
    // 移除相应平台的分享item微信收藏
//     [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}

#pragma mark -- OpenURL 第三方登录/支付回调 --
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark -- 网络状态变化 --
- (void)netWorkStateChange:(NSNotification *)notification {
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) { // 有网络
        if ([NUserManager loadUserInfo] && !NIsLogin) { // 有用户数据 并且 未登录成功 重新来一次自动登录
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
