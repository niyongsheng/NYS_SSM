//
//  NYSPagingViewTableHeaderView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSActivityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSPagingViewTableHeaderView : UIView
@property(strong, nonatomic) NYSActivityModel *datasource;

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;
@end

NS_ASSUME_NONNULL_END
