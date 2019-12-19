//
//  QMHLeftTextCell.m
//  安居公社
//
//  Created by 倪刚 on 2018/5/7.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import "QMHLeftTextCell.h"

NSString * const XLFormRowDescriptorTypeLeftText = @"XLFormRowDescriptorTypeLeftText";
@implementation QMHLeftTextCell
+ (void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([QMHLeftTextCell class]) forKey:XLFormRowDescriptorTypeLeftText];
}

- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    [self.ratingView addTarget:self action:@selector(rateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)update
{
    [super update];
    
    self.title.text = self.rowDescriptor.title;
    self.text.text = self.rowDescriptor.value;
    
    self.title.textColor = [UIColor grayColor];
    if ([self.text.text isEqualToString:@"审核通过"]) {
        self.text.textColor = RGBColor(74, 142, 239);
    } else if ([self.text.text isEqualToString:@"审核驳回"]) {
        self.text.textColor = [UIColor redColor];
    } else {
        self.text.textColor = [UIColor grayColor];
    }
//    self.text.textColor = [self.text.text isEqualToString:@"审核通过"] ? RGBColor(74, 142, 239) : [UIColor grayColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Events
-(void)rateChanged:(AXRatingView *)ratingView
{
    self.rowDescriptor.value = [NSNumber numberWithFloat:ratingView.value];
}
@end
