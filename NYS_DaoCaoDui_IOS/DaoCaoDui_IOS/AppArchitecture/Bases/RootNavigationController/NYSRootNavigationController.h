//
//  NYSRootNavigationController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/27.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSRootNavigationController : UINavigationController
/*
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
