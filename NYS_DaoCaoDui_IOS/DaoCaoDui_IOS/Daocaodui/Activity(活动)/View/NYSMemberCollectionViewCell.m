//
//  NYSMemberCollectionViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/2.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSMemberCollectionViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface NYSMemberCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *account;
@end
@implementation NYSMemberCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.userInteractionEnabled = NO;
    self.icon.layer.cornerRadius = 25;
    self.icon.layer.masksToBounds = YES;
}

- (void)setMemberModel:(UserInfo *)memberModel {
    _memberModel = memberModel;
    [self.icon setBackgroundImageWithURL:[NSURL URLWithString:memberModel.icon] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"me_photo_80x80_"]];
    [self.nickname setText:memberModel.nickname];
    [self.account setText:memberModel.account];
}

@end
