//
//  RongRTCRoomConfig.h
//  RongRTCLib
//
//  Created by jfdreamyang on 2019/5/21.
//  Copyright © 2019 Bailing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RongRTCDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface RongRTCRoomConfig : NSObject

/**
 加入房间场景
 */
@property (nonatomic)RongRTCRoomType roomType;

/**
 直播类型，仅在 RongRTCRoomType 为 RongRTCRoomTypeLive 时可用，选择当前为音频直播还是音视频直播
 */
@property(nonatomic , assign)RongRTCLiveType liveType;


@end

NS_ASSUME_NONNULL_END
