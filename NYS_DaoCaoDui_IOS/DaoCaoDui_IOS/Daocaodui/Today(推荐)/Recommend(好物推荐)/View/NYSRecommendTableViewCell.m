//
//  NYSRecommendTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/7.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRecommendTableViewCell.h"
#import "NYSRecommendModel.h"
#import "NYSPersonalInfoCardViewController.h"

@interface NYSRecommendTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
@implementation NYSRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 5.0f;
    self.iconBtn.layer.cornerRadius = 15.0f;
    self.iconBtn.layer.masksToBounds = YES;
    
    // 头像边框
    CALayer *layer = [self.iconBtn layer];
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 0.2f;
    
    // 添加四个边阴影
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (IBAction)iconBtnClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    NYSPersonalInfoCardViewController *personalInfoCardVC = NYSPersonalInfoCardViewController.new;
    personalInfoCardVC.account = [NSString stringWithFormat:@"%ld", sender.tag];
    [self.fromViewController.navigationController pushViewController:personalInfoCardVC animated:YES];
}

- (void)setRecommendModel:(NYSRecommendModel *)recommendModel {
    _recommendModel = recommendModel;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:recommendModel.iconUrl] placeholder:[UIImage imageNamed:@"chat_share_subject_72x72_"]];
    self.name.text = recommendModel.name;
    self.content.text = recommendModel.content;
    self.iconBtn.tag = recommendModel.user.account.intValue;
    [self.iconBtn setImageWithURL:[NSURL URLWithString:recommendModel.user.icon] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"chat_single"]];
    NSInteger timestamp = [NYSTools timeSwitchTimestamp:recommendModel.gmtCreate andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    self.date.text = [NYSTools timeBeforeInfoWithTimestamp:timestamp];
}

@end
