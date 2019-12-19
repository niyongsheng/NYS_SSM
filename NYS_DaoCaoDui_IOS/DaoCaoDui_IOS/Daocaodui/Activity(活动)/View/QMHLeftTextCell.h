//
//  QMHLeftTextCell.h
//  安居公社
//
//  Created by 倪刚 on 2018/5/7.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import <XLForm.h>
#import "XLFormBaseCell.h"
#import "XLRatingView.h"

extern NSString * const XLFormRowDescriptorTypeLeftText;

@interface QMHLeftTextCell : XLFormBaseCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *text;

@end
