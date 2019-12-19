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

@interface NYSPrayCustomCardView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel     *titleLabel;

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
    self.titleLabel = [[UILabel alloc] init];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView.layer setMasksToBounds:YES];
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
}

- (void)cc_layoutSubviews  {    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height - 64, self.frame.size.width, 64);
}

- (void)setPray:(NYSPrayModel *)pray {
    _pray = pray;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:pray.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.imageView.transform = CGAffineTransformIdentity;
    self.titleLabel.text = pray.subtitle;
    self.titleLabel.transform = CGAffineTransformIdentity;
}

@end
