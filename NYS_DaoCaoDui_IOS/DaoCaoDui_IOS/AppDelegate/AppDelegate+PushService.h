//
//  AppDelegate+PushService.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/4.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (PushService)

- (void)initAPNs;

- (void)initJpush:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
