//
//  NYSTabBarController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSTabBarController.h"
#import "NYSRootNavigationController.h"
#import "NYSHomeViewController.h"
#import "NYSMagicBoxViewController.h"
#import "NYSMeViewController.h"

@interface NYSTabBarController () <AxcAE_TabBarDelegate>

@end

@implementation NYSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[[NYSRootNavigationController alloc] initWithRootViewController:[NYSHomeViewController new]], @"normalImg":@"home_normal", @"selectImg":@"home_select", @"itemTitle":@"首页"},
      @{@"vc":[[NYSRootNavigationController alloc] initWithRootViewController:[NYSMagicBoxViewController new]], @"normalImg":@"magicBox_normal", @"selectImg":@"magicBox_select", @"itemTitle":@"百宝箱"},
      @{@"vc":[[NYSRootNavigationController alloc] initWithRootViewController:[NYSMeViewController new]], @"normalImg":@"me_normal", @"selectImg":@"me_select", @"itemTitle":@"我的"},
      ];
    
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectColor = UIColorFromHex(0x01BEFE);
        model.normalColor = UIColorFromHex(0xAFAFAF);
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        
        model.selectBackgroundColor = AxcAE_TabBarRGBA(248, 248, 248, 1);
        model.normalBackgroundColor = [UIColor clearColor];
        // 缩放动画
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.axcTabBar.selectIndex = 0;
    });
}

#pragma mark - AxcAE_TabBarDelegate
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
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
