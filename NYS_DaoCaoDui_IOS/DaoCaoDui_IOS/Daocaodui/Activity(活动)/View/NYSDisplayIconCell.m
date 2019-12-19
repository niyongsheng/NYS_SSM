//
//  NYSUploadImageCell.m
//  28ChatRoom
//
//  Created by 倪永胜 on 2018/12/4.
//  Copyright © 2018 qingmai. All rights reserved.
//

#import "NYSDisplayIconCell.h"
#import <UIImageView+WebCache.h>

NSString *const XLFormRowDescriptorTypeDisplayIcon = @"XLFormRowDescriptorTypeDisplayIcon";

@interface NYSDisplayIconCell ()

@end

@implementation NYSDisplayIconCell

+ (void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([NYSDisplayIconCell class]) forKey:XLFormRowDescriptorTypeDisplayIcon];
}

- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 圆角
    self.view.layer.cornerRadius = CGRectGetWidth(self.view.bounds)/2;
    self.view.layer.masksToBounds = YES;
    self.imageView1.userInteractionEnabled = YES;
    
    // 描边
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    //    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    //虚线边框
    //    borderLayer.lineDashPattern = @[@8, @8];
    //实线边框
    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:borderLayer];
}

- (void)update {
    [super update];
    
    // 设置头像（无缓存）
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.rowDescriptor.value] placeholderImage:[UIImage imageNamed:@"CRGroupManagerCell"] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            self.imageView1.image = image;
        }
    }];
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 150;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
