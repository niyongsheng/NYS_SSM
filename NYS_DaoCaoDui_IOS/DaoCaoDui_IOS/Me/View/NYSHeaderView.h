//
//  NYSHeaderView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/30.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol headerViewDelegate <NSObject>

- (void)headerViewClick;
- (void)nickNameViewClick;

@end

@interface NYSHeaderView : UIView

/** 头像 */
@property(nonatomic, strong) YYAnimatedImageView *headImgView;
/** 用户信息 */
@property(nonatomic, strong) UserInfo *userInfo;

@property(nonatomic, assign) id<headerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
