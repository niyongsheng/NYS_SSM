//
//  NYSPersonalInfoCardFooterView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYSPersonalInfoCardFooterView : UIView
@property (strong, nonatomic) UserInfo *userInfoModel;
@property (strong, nonatomic) UIViewController *fromViewController;
@end

NS_ASSUME_NONNULL_END
