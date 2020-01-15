//
//  NYSPrayCustomCardView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPrayCustomCardView.h"
#import "NYSPrayModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

@interface NYSPrayCustomCardView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *iconBtn;
@end

@implementation NYSPrayCustomCardView

- (instancetype)init {
    if (self = [super init]) {
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.imageView = [[UIImageView alloc] init];
    self.iconBtn = [[UIButton alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView.layer setMasksToBounds:YES];
    
    self.iconBtn.layer.cornerRadius = 25.0f;
    self.iconBtn.layer.masksToBounds = YES;
    CALayer *layer = [self.iconBtn layer];
    layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
    layer.borderWidth = 0.5f;
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.imageView];
    [self addSubview:self.iconBtn];
    [self addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
}

- (void)cc_layoutSubviews {
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64);
    self.iconBtn.frame = CGRectMake(5, self.frame.size.height - 55, 50, 50);
    self.titleLabel.frame = CGRectMake(self.iconBtn.right + 5, self.frame.size.height - 64, self.frame.size.width - self.iconBtn.width - 10, 64);
}

- (void)setPray:(NYSPrayModel *)pray {
    _pray = pray;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:pray.icon] placeholderImage:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
    self.imageView.transform = CGAffineTransformIdentity;
    
    [self.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[pray.user icon]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"me_photo_80x80_"]];
    self.iconBtn.transform = CGAffineTransformIdentity;
    
    self.titleLabel.text = pray.title;
    self.titleLabel.transform = CGAffineTransformIdentity;
}

@end
