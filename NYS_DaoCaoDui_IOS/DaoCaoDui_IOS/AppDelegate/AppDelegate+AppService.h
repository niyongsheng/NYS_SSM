//
//  AppDelegate+AppService.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)
/** 初始化服务 */
- (void)initService;

/** 初始化 window */
- (void)initWindow;

/** WRNavigationBar 初始化 */
- (void)initWRNavigationBar;

/** 初始化友盟 */
- (void)initUMeng;

/** 初始化用户系统 */
- (void)initUserManager;

/** 初始化IM*/
- (void)initIMManager;

/** 监听网络状态 */
- (void)monitorNetworkStatus;


/** 单例 */
+ (AppDelegate *)shareAppDelegate;

/** 当前顶层控制器 */
- (UIViewController*)getCurrentVC;

- (UIViewController*)getCurrentUIVC;

@end

NS_ASSUME_NONNULL_END
