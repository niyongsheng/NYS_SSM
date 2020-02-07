//
//  RongRTCMixStreamOutputConfig.h
//  RongRTCLib
//
//  Created by 杜立召 on 2019/10/10.
//  Copyright © 2019 Bailing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RongRTCMixStreamOutputConfig : NSObject

/**
 小视频流的宽
 */
@property (nonatomic,assign) int tinyVideo_width;

/**
 小视频流的宽
 */
@property (nonatomic,assign) int tinyVideo_height;

/**
 小视频流的帧率
 */
@property (nonatomic,assign) int tinyVideo_fps;

/**
 小视频流的码率
 */
@property (nonatomic,assign) int tinyVideo_bitrate;

/**
 大视频流的宽
 */
@property (nonatomic,assign) int normalVideo_width;

/**
 大视频流的高
 */
@property (nonatomic,assign) int normalVideo_height;

/**
 大视频流的帧率
 */
@property (nonatomic,assign) int normalVideo_fps;

/**
 大视频流的码率
 */
@property (nonatomic,assign) int normalVideo_bitrate;

/**
 音频的码率
 */
@property (nonatomic,assign) int audio_bitrate;

/**
 裁剪模式,1：裁剪填充 2：整个充满
 */
@property(nonatomic , assign)int renderMode;


@end

NS_ASSUME_NONNULL_END
