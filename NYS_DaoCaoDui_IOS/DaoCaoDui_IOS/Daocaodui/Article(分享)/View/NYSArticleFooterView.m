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
    NSString *shareTitle = self.articleModel.title;
    NSString *shareContent = self.articleModel.content;
    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.articleModel.icon]]];
    NSURL *shareUrl = [NSURL URLWithString:self.articleModel.articleUrl];
    NSArray *activityItemsArray = shareUrl ? @[shareTitle, shareContent, shareImage, shareUrl] : @[shareTitle, shareContent, shareImage];
    NSArray *activityArray = @[];
    
    // 2、初始化控制器，添加分享内容至控制器
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItemsArray applicationActivities:activityArray];
    activityVC.modalInPopover = YES;
    // 3、设置回调
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"activityType == %@", activityType);
        if (completed == YES) {
            NLog(@"completed");
        }else{
            NLog(@"cancel");
        }
    };
    activityVC.completionWithItemsHandler = itemsBlock;
    // 4、调用控制器
    [self.fromViewController presentViewController:activityVC animated:YES completion:nil];
}

- (void)setArticleModel:(NYSArticleModel *)articleModel {
    _articleModel = articleModel;
    
    self.icon.tag = articleModel.user.account.intValue;
    [self.icon setImageWithURL:[NSURL URLWithString:articleModel.user.icon] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"chat_single"]];
    self.nickname.text = articleModel.user.nickname;
}

@end
