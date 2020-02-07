//
//  NYSChatListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/16.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSChatListViewController.h"
#import "NYSConversationViewController.h"
#import "OYRPopOption.h"
#import "NYSContactsViewController.h"
#import "NYSGroupListViewController.h"

@interface NYSChatListViewController ()

@end

@implementation NYSChatListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置初始角标值
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
        @(ConversationType_PRIVATE),
        @(ConversationType_DISCUSSION),
        @(ConversationType_PUBLICSERVICE),
        @(ConversationType_PUBLICSERVICE),
        @(ConversationType_GROUP)
    ]];
    NYSTabBarController *tabBarVC = (NYSTabBarController *)self.tabBarController;
    AxcAE_TabBarItem *item = tabBarVC.axcTabBar.tabBarItems[0];
    item.badgeLabel.automaticHidden = YES;
    if (unreadMsgCount <= 0) {
        item.badgeLabel.hidden = YES;
    } else {
        item.badgeLabel.hidden = NO;
        item.badge = [NSString stringWithFormat:@"%d", unreadMsgCount];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightBtn];
    
    self.title = @"我们";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.conversationListTableView.tableFooterView = [UIView new];
    
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
    [self setConversationAvatarStyle:RC_USER_AVATAR_RECTANGLE];
    // 移除群助手
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION)]];
}

- (void)createRightBtn {
    UIImage *img = [UIImage imageNamed:@"icon_profile_more"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 36 * 0.6, 28 * 0.6);
    [btn setImage:img forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(righBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)righBtnClick:(UIButton *)optionButton {
    
    // 注意：由convertRect: toView 获取到屏幕上该控件的绝对位置。
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGRect frame = [optionButton convertRect:optionButton.bounds toView:window];
    
    OYRPopOption *s = [[OYRPopOption alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
    s.option_optionContents = @[@"私聊", @"群聊", @"会议"];
    s.option_optionImages = @[@"icon_quit_matchdetail",
                              @"icon_nav_share",
                              @"icon_invite_matchdetail"];
    // 使用链式语法直接展示 无需再写 [s option_show];
    [[s option_setupPopOption:^(NSInteger index, NSString *content) {
        switch (index) {
            case 0: {
                NYSContactsViewController *contactsListVC = [[NYSContactsViewController alloc] init];
                [self.navigationController pushViewController:contactsListVC animated:YES];
            }
                break;
                
            case 1: {
                NYSGroupListViewController *groupListVC = [[NYSGroupListViewController alloc] init];
                [self.navigationController pushViewController:groupListVC animated:YES];
            }
                break;
            
            case 2: {
                [SVProgressHUD showInfoWithStatus:@"视频会议功能开发中..."];
                [SVProgressHUD dismissWithDelay:2.f];
            }
                break;
                
            default:
                break;
        }
    } whichFrame:frame animate:YES] option_show];
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
