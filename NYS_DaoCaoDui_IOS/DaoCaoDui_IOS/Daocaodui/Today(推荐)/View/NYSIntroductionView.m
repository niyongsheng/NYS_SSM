//
//  NYSIntroductionView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/18.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSIntroductionView.h"

@interface NYSIntroductionView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NYSIntroductionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    self.titleLabel.font = [[UIFont systemFontOfSize:15.f] fontWithItalic];
    self.bgImageView.image = [[UIImage imageNamed:@"1"] imageByBlurRadius:10 tintColor:nil tintMode:0 saturation:1 maskImage:nil];
}

@end
