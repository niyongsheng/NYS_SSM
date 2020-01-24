//
//  NYSPrayCardView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/24.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "CCDraggableCardView.h"

@class NYSPrayModel;

NS_ASSUME_NONNULL_BEGIN

@interface NYSPrayCardView : CCDraggableCardView
@property (weak, nonatomic) NYSPrayModel *pray;
@property (strong, nonatomic) UIViewController *fromViewController;
@end

NS_ASSUME_NONNULL_END
