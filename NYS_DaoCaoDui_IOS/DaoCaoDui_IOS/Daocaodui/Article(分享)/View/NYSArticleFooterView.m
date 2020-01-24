//
//  NYSArticleFooterView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/15.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSArticleFooterView.h"
#import "NYSPersonalInfoCardViewController.h"
#import "NYSBaseNavigationController.h"
#import "NYSSDImageCacheHeader.h"

@interface NYSArticleFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end
@implementation NYSArticleFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)drawRect:(CGRect)rect {
    self.icon.layer.cornerRadius = 20.f;
    self.icon.layer.masksToBounds = YES;
    self.shareBtn.layer.cornerRadius = 7.f;
    
    CALayer *layer = [self.icon layer];
    layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4f].CGColor;
    layer.borderWidth = 0.7f;
}

- (IBAction)iconClicked:(UIButton *)sender {
    NYSPersonalInfoCardViewController *personalInfoCardVC = NYSPersonalInfoCardViewController.new;
    personalInfoCardVC.account = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    NYSBaseNavigationController *navVC = [[NYSBaseNavigationController alloc] initWithRootViewController:personalInfoCardVC];
    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.fromViewController presentViewController:navVC animated:YES completion:nil];
}

- (IBAction)shareClicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    // 1、设置分享的内容，并将内容添加到数组中
//    NSString *shareTitle = self.articleModel.title;
    NSString *shareContent = self.articleModel.content;
    NSURL *shareUrl = [NSURL URLWithString:self.articleModel.articleUrl];
    // 读取磁盘缓存的image
    UIImage *shareImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@_%ld", ShareImageCacheKey, (long)self.articleModel.idField]];
    !shareImage ? shareImage = [UIImage imageNamed:@"doulist_cover_122x122_"] : nil;
    
    NSArray *activityItemsArray = shareUrl ? @[shareContent, shareImage, shareUrl] : @[shareContent, shareImage];
    NSArray *activityArray = @[];
    
    // 2、初始化控制器，添加分享内容至控制器
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItemsArray applicationActivities:activityArray];
    activityVC.modalInPopover = YES;
    // 3、设置回调
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NLog(@"activityType == %@", activityType);
        if (completed) {
            NLog(@"completed");
        } else {
            NLog(@"share cancel with error:%@", activityError.localizedDescription);
        }
    };
    activityVC.completionWithItemsHandler = itemsBlock;
    // 4、调用控制器
    [self.fromViewController presentViewController:activityVC animated:YES completion:nil];
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
                                          @"reportId" : @(self.articleModel.idField),
                                          @"fellowship" : @(NCurrentUser.fellowship),
                                          @"content" : @""}
                                success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功，我们会尽快处理你的请求！"];
        [SVProgressHUD dismissWithDelay:1.5f];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Setter
- (void)setArticleModel:(NYSArticleModel *)articleModel {
    _articleModel = articleModel;
    
    self.icon.tag = articleModel.user.account.intValue;
    [self.icon setImageWithURL:[NSURL URLWithString:articleModel.user.icon] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"chat_single"]];
    self.nickname.text = articleModel.user.nickname;
}

@end
