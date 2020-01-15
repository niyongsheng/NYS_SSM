//
//  NYSArticleFooterView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/15.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSArticleFooterView : UIView
@property (weak, nonatomic) NYSArticleModel *articleModel;
@property (strong, nonatomic) UIViewController *fromViewController;
@end

NS_ASSUME_NONNULL_END
