//
//  CommonMacros.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark -- 用户相关 --
// 登录状态改变通知
#define NNotificationLoginStateChange @"loginStateChange"
// 自动登录成功
#define NNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"
// 被踢下线
#define NNotificationOnKick @"KNotificationOnKick"
// 用户信息缓存 名称
#define NUserCacheName @"KUserCacheName"
// 用户model缓存
#define NUserModelCache @"KUserModelCache"


#pragma mark -- 网络状态相关 --
// 网络状态变化
#define NNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"
// 圣经版本刷新通知
// 网络状态变化
#define NNotificationBibleVersionChange @"KNotificationBibleVersionChange"

#endif /* CommonMacros_h */
