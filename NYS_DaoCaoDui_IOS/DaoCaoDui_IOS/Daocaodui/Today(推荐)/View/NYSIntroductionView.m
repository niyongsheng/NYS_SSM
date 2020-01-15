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
    self.titleLabel.layer.cornerRadius = 2.0f;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.2];
//    self.titleLabel.font = [[UIFont systemFontOfSize:15.f] fontWithItalic];
    self.titleLabel.font = [UIFont fontWithName:@"HYZhuZiMeiXinTiW" size:15];
    self.titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    self.bgImageView.image = [[UIImage imageNamed:@"1"] imageByBlurRadius:10 tintColor:nil tintMode:0 saturation:1 maskImage:nil];
}

- (void)setWeekBibleModel:(NYSWeekBibleModel *)weekBibleModel {
    _weekBibleModel = weekBibleModel;
    
    self.titleLabel.text = weekBibleModel.bible;
    UIImage *bgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:weekBibleModel.iconUrl]]];
    self.bgImageView.image = [bgImage imageByBlurRadius:10 tintColor:nil tintMode:0 saturation:1 maskImage:nil];
}

@end
