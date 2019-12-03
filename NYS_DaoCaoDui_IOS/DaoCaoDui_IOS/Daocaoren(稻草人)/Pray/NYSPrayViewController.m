//
//  NYSPrayViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/11/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPrayViewController.h"
#import<BarrageRenderer/BarrageRenderer.h>

@interface NYSPrayViewController ()

@end

@implementation NYSPrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 毛玻璃背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6"]];
    [bgImageView setFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bgImageView.bounds;
    [bgImageView addSubview:effectView];
    [self.view addSubview:bgImageView];
    
}

@end
