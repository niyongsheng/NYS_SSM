//
//  NYSRankingListTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSClockListTableViewCell.h"

@interface NYSClockListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *rankingBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation NYSClockListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
}

- (void)setUserModel:(UserInfo *)userModel {
    _userModel = userModel;
    [self.iconBtn setImageWithURL:[NSURL URLWithString:[userModel icon]] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"chat_single"]];
    [self.remarkLabel setText:[userModel nickname]];
}

- (IBAction)iconClicked:(UIButton *)sender {
}

- (IBAction)alertBtnClicked:(UIButton *)sender {
}

@end
