//
//  NYSEmitterUtil.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/19.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EmitterAnimationType) {
    /** 彩带*/
    EmitterAnimationColourbar,
    /** 雪花*/
    EmitterAnimationSnow,
    /** 雨水*/
    EmitterAnimationRain,
    /** 烟花*/
    EmitterAnimationFire
};

@interface NYSEmitterUtil : NSObject
/// 开启粒子效果
/// @param type 类型
/// @param view 作用域
/// @param times 持续时间
+ (void)showEmitterType:(EmitterAnimationType)type onView:(UIView *)view durationTime:(float)times;
@end

NS_ASSUME_NONNULL_END
