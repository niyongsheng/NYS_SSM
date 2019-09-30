//
//  NYSTransition.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSTransition : NSObject <UIViewControllerAnimatedTransitioning>

/** 是否是push，反之则是pop */
@property(nonatomic,assign) BOOL isPush;

/** 动画时长 */
@property (nonatomic, assign) NSTimeInterval animationDuration;
@end

NS_ASSUME_NONNULL_END
