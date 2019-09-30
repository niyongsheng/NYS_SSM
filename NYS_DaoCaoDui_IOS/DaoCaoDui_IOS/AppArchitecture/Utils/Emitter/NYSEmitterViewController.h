//
//  NYSEmitterViewController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/21.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EmitterAnimationType) {
    /** 彩带*/
    EmitterAnimationColourbar,
    /** 雪花*/
    EmitterAnimationSnow,
    /** 雨水*/
    EmitterAnimationRain,
    /** 火焰*/
    EmitterAnimationFire
};

@interface NYSEmitterViewController : NYSRootViewController

- (instancetype)initWithEmitterAnimationType:(EmitterAnimationType)EmitterAnimationType;

@end

NS_ASSUME_NONNULL_END
