//
//  NYSConversationViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/16.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSConversationViewController.h"
#import <IQKeyboardManager.h>

@interface NYSConversationViewController ()

@end

@implementation NYSConversationViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    IQKeyboardManager *keyboardManager =  [IQKeyboardManager sharedManager];
    keyboardManager.enable = NO;
    keyboardManager.enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    IQKeyboardManager *keyboardManager =  [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.enableAutoToolbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 移除转账和红包功能
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_TRANSFER_TAG];
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_RED_PACKET_TAG];

    self.enableNewComingMessageIcon = YES; //开启消息提醒
//    // 取消IQKeyboardManager Toolbar
//    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
