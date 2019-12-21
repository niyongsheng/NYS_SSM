//
//  NYSButtonFooterView.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/5.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSButtonFooterView : UIView
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

- (void)buttonIsEnable:(BOOL)isEnable withTitle:(NSString *)title;

- (void)buttonForSendData:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
