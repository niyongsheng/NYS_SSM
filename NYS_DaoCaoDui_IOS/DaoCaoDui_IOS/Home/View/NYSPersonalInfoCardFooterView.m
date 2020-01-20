//
//  NYSPersonalInfoCardFooterView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSPersonalInfoCardFooterView.h"
#import "NYSConversationViewController.h"

@interface NYSPersonalInfoCardFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *sendMessagesBtn;

@end
@implementation NYSPersonalInfoCardFooterView

- (void)drawRect:(CGRect)rect {
    self.sendMessagesBtn.layer.cornerRadius = 7.f;
    self.sendMessagesBtn.backgroundColor = NNavBgColorShallow;
}

- (IBAction)sendMessagesBtnClicked:(UIButton *)sender {
    NYSConversationViewController *privateConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:self.userInfoModel.account];
    privateConversationVC.title = self.userInfoModel.nickname;
    [self.fromViewController.navigationController pushViewController:privateConversationVC animated:YES];
}

@end
