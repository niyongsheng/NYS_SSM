//
//  NYSChatListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/16.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSChatListViewController.h"
#import "NYSConversationViewController.h"

@interface NYSChatListViewController ()

@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

@end

@implementation NYSChatListViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle {
    _StatusBarStyle = StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.title = @"我们";
    self.conversationListTableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.conversationListTableView setSeparatorColor:[UIColor colorWithRed:0.85 green:0.84 blue:0.84 alpha:0.9]];
    
    // 设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[
                                        @(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)
                                        ]];
    
    // 设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[
                                          @(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)
                                          ]];
    // 连接状态
    self.showConnectingStatusOnNavigatorBar = YES;
    // 会话列表头像 圆形显示
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    // 移除群助手
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION)]];
}

// 点击cell回调
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationBaseCell * cell = [self.conversationListTableView cellForRowAtIndexPath:indexPath];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    cell.selectedBackgroundView = view;
    
    NYSConversationViewController *conversationVC = [[NYSConversationViewController alloc] init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
