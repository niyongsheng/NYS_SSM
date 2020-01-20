//
//  NYSMusicTableViewCell.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/17.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSMusicTableViewCell.h"
#import "NYSPersonalInfoCardViewController.h"

@interface NYSMusicTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UIButton *collection;
@property (weak, nonatomic) IBOutlet UIButton *uploader;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation NYSMusicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CALayer *layer = [self.uploader layer];
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 0.2f;
    
    self.icon.layer.cornerRadius = 25.f;
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.uploader.layer.cornerRadius = 11.f;
}

- (IBAction)uploaderClicked:(UIButton *)sender {
    NYSPersonalInfoCardViewController *personalInfoCardVC = NYSPersonalInfoCardViewController.new;
    personalInfoCardVC.account = [NSString stringWithFormat:@"%ld", sender.tag];
    [self.fromViewController.navigationController pushViewController:personalInfoCardVC animated:YES];
}

- (IBAction)collectionClicked:(UIButton *)sender {
    [NYSRequest MusicCollectionInOrOutWithResMethod:GET parameters:@{@"musicID" : @(sender.tag)} success:^(id response) {
        if ([[response objectForKey:@"status"] boolValue]) {
            self.collection.selected = !self.collection.selected;
            [SVProgressHUD showSuccessWithStatus:[[response objectForKey:@"data"] objectForKey:@"info"]];
            [SVProgressHUD dismissWithDelay:1.f];
        }
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

- (void)setMusicModel:(NYSMusicModel *)musicModel {
    _musicModel = musicModel;
    [self.icon setImageWithURL:[NSURL URLWithString:musicModel.icon] placeholder:[UIImage imageNamed:@"ic_disc_90x90_"]];
    self.title.text = musicModel.name;
    self.singer.text = musicModel.singer;
    self.collection.selected = musicModel.isCollection;
    self.collection.tag = musicModel.idField;
    [self.uploader setImageWithURL:[NSURL URLWithString:musicModel.user.icon] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"chat_single"]];
    self.uploader.tag = musicModel.user.account.integerValue;
    NSInteger timestamp = [NYSTools timeSwitchTimestamp:musicModel.gmtCreate andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    self.time.text = [NYSTools timeBeforeInfoWithTimestamp:timestamp];
}

@end
