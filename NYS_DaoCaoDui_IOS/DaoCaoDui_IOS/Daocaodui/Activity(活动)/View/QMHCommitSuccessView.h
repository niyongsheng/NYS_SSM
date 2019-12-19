//
//  QMHCommitSuccessView.h
//  安居公社
//
//  Created by 倪刚 on 2018/4/28.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Goback)(id);

@interface QMHCommitSuccessView : UIView
- (instancetype)initWithFrame:(CGRect)frame;

- (void)setTitleString:(NSString *)popTitleString sucessTitleString:(NSString *)sucessTitleString popMessagesString:(NSString *)popMessagesString;

- (void)closeButtonForSendData:(id)target action:(SEL)action;
@end
