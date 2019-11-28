//
//  NYSBaseNavigationController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/11/28.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBaseNavigationController.h"

@interface NYSBaseNavigationController ()

@end

@implementation NYSBaseNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
