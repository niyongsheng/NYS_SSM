//
//  RongRTCLiveInfo.h
//  RongRTCLib
//
//  Created by 孙承秀 on 2019/8/22.
//  Copyright © 2019 Bailing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RongRTCLiveInfo : NSObject

/**
 当前的直播地址
 */
@property(nonatomic , copy)NSString *liveUrl;
@end

NS_ASSUME_NONNULL_END
