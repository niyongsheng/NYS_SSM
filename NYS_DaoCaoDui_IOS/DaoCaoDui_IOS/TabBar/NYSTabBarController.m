//
//  NYSTabBarController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSTabBarController.h"
#import "NYSBaseNavigationController.h"
#import "NYSChatListViewController.h"
#import "NYSDCDViewController.h"
#import "NYSMeViewController.h"

@interface NYSTabBarController () <AxcAE_TabBarDelegate>

@end

@implementation NYSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NNotificationCenter addObserver:self selector:@selector(receiveMessage:) name:@"RCIMReceiveMessageNotification" object:nil];
    
    NSArray <NSDictionary *> *VCArray =
    @[@{@"vc":[[NYSBaseNavigationController alloc] initWithRootViewController:[NYSChatListViewController new]],
        @"normalImg":@"会话默认",
        @"selectImg":@"会话",
        @"itemTitle":@"We"},
      @{@"vc":[[NYSBaseNavigationController alloc] initWithRootViewController:[NYSDCDViewController new]],
        @"normalImg":@"机器人",
        @"selectImg":@"机器人",
        @"itemTitle":@"稻草人"},
      @{@"vc":[[NYSBaseNavigationController alloc] initWithRootViewController:[NYSMeViewController new]],
        @"normalImg":@"我的默认",
        @"selectImg":@"我的",
        @"itemTitle":@"Me"},
      ];
    
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        model.itemBadgeStyle = AxcAE_TabBarItemBadgeStyleTopRight;
        model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectColor = NNavBgColor;
        model.normalColor = UIColorFromHex(0xAFAFAF);
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        model.normalBackgroundColor = [UIColor clearColor];
        
        if (idx == 1 ) { // 如果是中间的
            // 设置凸出
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = -5;
            model.bulgeRoundedCorners = 2; // 修角
            // 设置成纯文字展示
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTitle;
            // 文字为加号
            model.itemTitle = @"+";
            // 字号大小
            model.titleLabel.font = [UIFont systemFontOfSize:40];
            model.normalColor = NNavBgColor;
            model.selectColor = [UIColor whiteColor];
            // 让Label上下左右全边距
            model.componentMargin = UIEdgeInsetsMake(-5, 0, 0, 0 );
            // 未选中选中颜色
            model.normalBackgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
            model.selectBackgroundColor = NNavBgColor;
            // 设置大小/边长
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 20.0, self.tabBar.frame.size.height - 10);
        }
        
        // 动画
        model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
        
        UIViewController *vc = [obj objectForKey:@"vc"];
        
        [tabBarVCs addObject:vc];
        [tabBarConfs addObject:model];
    }];
    self.viewControllers = tabBarVCs;
    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    self.axcTabBar.delegate = self;
    // 添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    
    self.axcTabBar.selectIndex = 1;
}

#pragma mark - AxcAE_TabBarDelegate
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index {
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
}

#pragma mark - RCIMReceiveMessageNotification
- (void)receiveMessage:(NSNotification *)notification {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
            @(ConversationType_PRIVATE),
            @(ConversationType_DISCUSSION),
            @(ConversationType_PUBLICSERVICE),
            @(ConversationType_PUBLICSERVICE),
            @(ConversationType_GROUP)
        ]];
        AxcAE_TabBarItem *item = self.axcTabBar.tabBarItems[0];
        item.badge = [NSString stringWithFormat:@"%d", unreadMsgCount];
//        item.badgeLabel.center = CGPointMake(item.size.width - 45, item.badgeLabel.frame.size.height/2);
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    if (self.axcTabBar) {
        self.axcTabBar.selectIndex = selectedIndex;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}

@end
