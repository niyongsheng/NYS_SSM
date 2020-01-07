//
//  NYSRankingListTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSClockListTableViewCell.h"
#import "NYSAlert.h"

@interface NYSClockListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *rankingBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickeName;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation NYSClockListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconBtn.layer.cornerRadius = 20.0f;
    self.iconBtn.layer.masksToBounds = YES;
    [self.remarkLabel setTextColor:[UIColor lightGrayColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
}

- (void)setUserModel:(UserInfo *)userModel {
    _userModel = userModel;
    [self.iconBtn setImageWithURL:[NSURL URLWithString:[userModel icon]] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"chat_single"]];
    [self.nickeName setText:[userModel nickname]];
    [self.remarkLabel setText:[userModel remark]];
    [self.dateLabel setText:userModel.gmtCreate];
    self.alertBtn.tag = userModel.account.integerValue;
}

- (void)setIsClocked:(BOOL)isClocked {
    _isClocked = isClocked;
    self.alertBtn.hidden = !isClocked;
    self.dateLabel.hidden = isClocked;
    [self.rankingBtn setHidden:isClocked];
}

- (void)setRanking:(NSInteger)ranking {
    _ranking = ranking;
    switch (ranking) {
        case 1: {[self.rankingBtn setImage:[UIImage imageNamed:@"clock_number_1"] forState:UIControlStateNormal];} break;
        case 2: {[self.rankingBtn setImage:[UIImage imageNamed:@"clock_number_2"] forState:UIControlStateNormal];} break;
        case 3: {[self.rankingBtn setImage:[UIImage imageNamed:@"clock_number_3"] forState:UIControlStateNormal];} break;
        default: [self.rankingBtn setTitle:[NSString stringWithFormat:@"%ld", ranking] forState:UIControlStateNormal];
            break;
    }
}

- (IBAction)iconClicked:(UIButton *)sender {
}

- (IBAction)alertBtnClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    WS(weakSelf);
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"@%@", self.userModel.nickname] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"鼓励Ta一下吧";
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"取消");
    }];
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [NYSRequest AlertClockActivityWithResMethod:GET
                                         parameters:@{@"account" : @(sender.tag),
                                                      @"remark" : alertVc.textFields.firstObject.text}
                                 success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                [NYSAlert showSuccessAlertWithTitle:@"提醒Ta打卡" message:@"提醒成功^^\n获得1粒稻壳" okButtonClickedBlock:^{
                    
                }];
            }
        } failure:^(NSError *error) {

        }];
    }];
    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVc addAction:cancelBtn];
    [alertVc addAction:sureBtn];
    [self.fromController presentViewController:alertVc animated:YES completion:nil];
}

@end
