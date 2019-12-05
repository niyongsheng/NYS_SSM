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

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    // 移除转账和红包功能
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_TRANSFER_TAG];
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_RED_PACKET_TAG];

    self.enableNewComingMessageIcon = YES; //开启消息提醒
    self.enableUnreadMessageIcon = YES;
    // 取消IQKeyboardManager Toolbar
//    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:self];
}


- (void)backBtnClicked {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
