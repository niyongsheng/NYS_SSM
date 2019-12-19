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
    [navBar setBackgroundImage:[[UIImage imageWithColor:NNavBgColorShallow] imageByBlurRadius:40 tintColor:nil tintMode:0 saturation:1 maskImage:nil] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [navBar setBarTintColor:NNavBgColor];
    [navBar setTintColor:NNavFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:NNavFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    [navBar setShadowImage:[UIImage new]]; // delete bottom line
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
}

/// when push auto hidden tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/// navigation delegate hidden method
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[NYSRootViewController class]]) {
        NYSRootViewController *vc = (NYSRootViewController *)viewController;
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
