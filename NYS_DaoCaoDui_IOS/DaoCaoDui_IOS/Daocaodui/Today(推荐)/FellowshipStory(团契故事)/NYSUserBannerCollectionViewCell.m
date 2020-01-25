//
//  NYSUserBannerCollectionViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/25.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSUserBannerCollectionViewCell.h"

@implementation NYSUserBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.icon = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        
        self.titleText = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 35, self.contentView.frame.size.width, 35)];
        UIColor *color = [UIColor blackColor];
        color = [color colorWithAlphaComponent:0.2];
        self.titleText.backgroundColor = color;
        self.titleText.textColor = [UIColor whiteColor];
        self.titleText.numberOfLines = 1;
        self.titleText.font = [UIFont systemFontOfSize:12.f];
        self.titleText.textAlignment = NSTextAlignmentCenter;
        [self.icon addSubview:self.titleText];
        
        self.contentView.layer.cornerRadius = 10.0f;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

@end
