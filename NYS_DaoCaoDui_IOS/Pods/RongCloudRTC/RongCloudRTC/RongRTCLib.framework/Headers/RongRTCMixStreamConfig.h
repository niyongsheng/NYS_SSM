//
//  RongRTCMixStreamConfig.h
//  RongRTCLib
//
//  Created by 杜立召 on 2019/10/10.
//  Copyright © 2019 Bailing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RongRTCMixStreamOutputConfig.h"
#import "RongRTCMixStreamInputConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface RongRTCMixStreamConfig : NSObject

/**
 合流服务版本
 */
@property(nonatomic,assign,readonly) int version;

/**
 合流模式，1：悬浮布局  2：自适应布局  3： 自定义布局
 
 模式 1 和 2 时不需要设置 用户的 inputVideoConfigs
 */
@property(nonatomic,assign) int mode;

/**
 mode 为 1 或者 2 时可用，将此 userId 的用户置顶
 */
@property(nonatomic , copy)NSString *hostUserId;

/**
 输入流列表，SDK 根据输入流列表中的流进行混流
 */
@property (nonatomic,strong) NSMutableArray<RongRTCMixStreamInputConfig*> *inputStreamConfigList;

/**
 输出流配置
 */
@property (nonatomic,strong) RongRTCMixStreamOutputConfig *outputConfig;

@end

NS_ASSUME_NONNULL_END
