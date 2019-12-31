//
//  NYSPublishFooterView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/6/26.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSPublishFooterView : UIView
/// 初始化
/// @param frame 约束
/// @param title 标题
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

/// 发布按钮绑定点击事件
- (void)publishButtonForSendData:(id)target action:(SEL)action;
/// 用户协议绑定点击事件
- (void)EULAButtonForSendData:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
