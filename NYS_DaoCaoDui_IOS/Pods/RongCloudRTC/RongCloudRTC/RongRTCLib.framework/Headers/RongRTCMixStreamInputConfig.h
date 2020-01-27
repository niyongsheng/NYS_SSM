//
//  RongRTCMixStreamInputConfig.h
//  RongRTCLib
//
//  Created by 杜立召 on 2019/10/10.
//  Copyright © 2019 Bailing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RongRTCMixStreamInputConfig : NSObject

/**
 要混流的流所属 userId
 */
@property (nonatomic,copy) NSString *userId;

/**
 混流图层左上角坐标的 y 值，即左上角坐标为 (left, top)
 */
@property (nonatomic,assign) int top;

/**
 混流图层左上角坐标的 x 值，即左上角坐标为 (left, top)
 */
@property (nonatomic,assign) int left;

/**
 视频流的宽
 */
@property (nonatomic,assign) int width;

/**
 视频流的高
 */
@property (nonatomic,assign) int height;

@end
NS_ASSUME_NONNULL_END
