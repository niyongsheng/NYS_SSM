//
//  NYSRankingListTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/3.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRankingTableViewCell.h"
#import "NYSActivityModel.h"

@interface NYSRankingTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation NYSRankingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.title setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8f]];
    self.progress.progressViewStyle = UIProgressViewStyleDefault;
    self.progress.progressTintColor = NNavBgColorShallow;
    
    self.bgImageView.layer.cornerRadius = 10.0f;
    self.bgImageView.layer.masksToBounds = YES;
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (void)setActivityModel:(NYSActivityModel *)activityModel {
    _activityModel = activityModel;
    
    self.title.text = activityModel.name;
    int x = activityModel.ID % 6;
    NSString *bgimgName = [NSString stringWithFormat:@"group_banner_%d_375x80_", x];
    [self.bgImageView setImage:[UIImage imageNamed:bgimgName]];
    self.progressLabel.text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)activityModel.clockedUserList.count, (unsigned long)activityModel.userList.count];
    CGFloat progress = (CGFloat)activityModel.clockedUserList.count/activityModel.userList.count;
    [self.progress setProgress:progress animated:YES];
}

@end
