//
//  NYSPrayCardView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/24.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSPrayCardView.h"
#import "NYSPrayModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "NYSPersonalInfoCardViewController.h"

@interface NYSPrayCardView ()
@property (assign, nonatomic) BOOL isAnonymity;

@property (weak, nonatomic) IBOutlet UIImageView *isTopImageView;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@end

@implementation NYSPrayCardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.number.font = [UIFont fontWithName:@"04b_03b" size:20.f];

    self.iconBtn.layer.cornerRadius = 30.0f;
    self.iconBtn.layer.masksToBounds = YES;
    [self.iconBtn addTarget:self action:@selector(iconBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    CALayer *layer = [self.iconBtn layer];
    layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
    layer.borderWidth = 0.5f;
}

#pragma mark - Setter
- (void)setPray:(NYSPrayModel *)pray {
    _pray = pray;
        
    self.number.text = [NSString stringWithFormat:@"NO.%ld", pray.idField];
       self.number.transform = CGAffineTransformIdentity;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:pray.icon] placeholderImage:[UIImage imageNamed:@"bg_ocr_intro_345x200_"]];
    self.imageView.transform = CGAffineTransformIdentity;
    
    self.isAnonymity = pray.anonymity;
    self.iconBtn.tag = pray.user.account.intValue;
    if (pray.anonymity) {
        [self.iconBtn setImage:[UIImage imageNamed:@"me_photo_80x80_"] forState:UIControlStateNormal];
    } else {
        [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:pray.user.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"me_photo_80x80_"]];
    }
    self.iconBtn.transform = CGAffineTransformIdentity;
    
    self.titleLabel.text = pray.title;
    self.titleLabel.transform = CGAffineTransformIdentity;
    
    self.subtitleLabel.text = pray.subtitle;
    self.subtitleLabel.transform = CGAffineTransformIdentity;
    
    self.isTopImageView.hidden = !pray.isTop;
    self.number.transform = CGAffineTransformIdentity;
}

- (void)iconBtnClicked:(UIButton *)sender {
    if (_isAnonymity) {
        [SVProgressHUD showInfoWithStatus:@"匿名代祷"];
        [SVProgressHUD dismissWithDelay:1.f];
        return;
    }
    NYSPersonalInfoCardViewController *personalInfoCardVC = NYSPersonalInfoCardViewController.new;
    personalInfoCardVC.account = [NSString stringWithFormat:@"%ld", sender.tag];
    [self.fromViewController.navigationController pushViewController:personalInfoCardVC animated:YES];
}

- (IBAction)reportBtnClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"举报" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    WS(weakSelf);
    UIAlertAction *ADAction = [UIAlertAction actionWithTitle:@"广告信息" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf reportWithType:1 idType:1];
    }];
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"垃圾信息" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf reportWithType:2 idType:1];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"不感兴趣" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf reportWithType:3 idType:1];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:ADAction];
    [alertController addAction:rubbishAction];
    [alertController addAction:otherAction];
    [alertController addAction:cancelAction];
    
    [self.fromViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)reportWithType:(NSInteger)type idType:(NSInteger)idType {
    
    [NYSRequest UserReportWithResMethod:POST
                             parameters:@{@"type" : @(type),
                                          @"idType" : @(idType),
                                          @"reportId" : @(self.pray.idField),
                                          @"fellowship" : @(NCurrentUser.fellowship),
                                          @"content" : @""}
                                success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功，我们会尽快处理你的请求！"];
        [SVProgressHUD dismissWithDelay:1.5f];
    } failure:^(NSError *error) {
        
    }];
}

@end
