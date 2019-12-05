//
//  NYSBaseNavigationController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/11/28.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBaseNavigationController.h"
#import "NYSRootViewController.h"

@interface NYSBaseNavigationController () <UINavigationControllerDelegate>

@end

@implementation NYSBaseNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [navBar setBarTintColor:NNavBgColor];
    [navBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    self.delegate = self;
}

/// push hidden tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/// 隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[NYSRootViewController class]]) {
        NYSRootViewController * vc = (NYSRootViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            vc.view.top = NTopHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

@end
