//
//  AppManager.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/28.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//
//  包含应用层的相关服务

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject

/** APP启动接口 */
+ (void)appStart;

/** FPS监测 */
+ (void)showFPS;

@end

NS_ASSUME_NONNULL_END
