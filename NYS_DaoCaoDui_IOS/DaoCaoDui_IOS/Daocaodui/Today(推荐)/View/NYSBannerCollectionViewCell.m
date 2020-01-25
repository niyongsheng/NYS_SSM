//
//  NYSBannerCollectionViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/11.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBannerCollectionViewCell.h"

@implementation NYSBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.icon = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        
        self.leftText = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 35, self.contentView.frame.size.width, 35)];
        UIColor *color = [UIColor blackColor];
        color = [color colorWithAlphaComponent:0.2];
        self.leftText.backgroundColor = color;
        self.leftText.textColor = [UIColor whiteColor];
        self.leftText.numberOfLines = 1;
        self.leftText.textAlignment = NSTextAlignmentCenter;
        [self.icon addSubview:self.leftText];
        
        self.contentView.layer.cornerRadius = 8;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

@end
