//
//  NYSDataSource.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/16.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

#define RCDDataSource [RCDRCIMDataSource shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface NYSChatDataSource : NSObject <RCIMUserInfoDataSource, RCIMGroupInfoDataSource>

+ (NYSChatDataSource *)shareInstance;

@end

NS_ASSUME_NONNULL_END
