//
//  CCDraggableCardView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "CCDraggableCardView.h"

@class NYSPrayModel;

@interface NYSPrayCustomCardView : CCDraggableCardView
@property (weak, nonatomic) NYSPrayModel *pray;
@property (strong, nonatomic) UIViewController *fromViewController;
@end
