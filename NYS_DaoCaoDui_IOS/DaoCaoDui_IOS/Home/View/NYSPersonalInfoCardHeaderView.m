//
//  NYSPersonalInfoCardHeaderView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSPersonalInfoCardHeaderView.h"

@interface NYSPersonalInfoCardHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickename;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIImageView *gender;
@property (weak, nonatomic) IBOutlet UILabel *introduction;

@end
@implementation NYSPersonalInfoCardHeaderView

- (void)drawRect:(CGRect)rect {
    self.icon.layer.cornerRadius = 35.f;
    CALayer *layer = [_icon layer];
    layer.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4f].CGColor;
    layer.borderWidth = 0.8f;
}

- (void)setUserInfoModel:(UserInfo *)userInfoModel {
    _userInfoModel = userInfoModel;
    
    [self.icon setImageWithURL:[NSURL URLWithString:userInfoModel.icon] placeholder:[UIImage imageNamed:@"chat_single"]];
    [self.nickename setText:userInfoModel.nickname];
    [self.name setText:[NSString stringWithFormat:@"姓名：%@", userInfoModel.truename]];
    [self.score setText:[NSString stringWithFormat:@"稻壳：%ld粒", userInfoModel.score]];
    [self.introduction setText:[NSString stringWithFormat:@"简介：%@", userInfoModel.introduction]];
    if ([userInfoModel.gender isEqualToString:@"male"]) {
        [self.gender setImage:[UIImage imageNamed:@"ic_male_profile_10x10_"]];
    } else if ([userInfoModel.gender isEqualToString:@"female"]) {
        [self.gender setImage:[UIImage imageNamed:@"ic_female_profile_10x10_"]];
    }
}

@end
