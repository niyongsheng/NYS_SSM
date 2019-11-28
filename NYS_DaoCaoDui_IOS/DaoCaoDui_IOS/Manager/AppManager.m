//
//  AppManager.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/28.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "AppManager.h"
#import "AdPageView.h"
#import "YYFPSLabel.h"
#import "NYSRootNavigationController.h"
#import "NYSRootWebViewController.h"


@implementation AppManager
+ (void)appStart {
    // 加载广告
    AdPageView *adView = [[AdPageView alloc] initWithFrame:NScreen_Bounds withTapBlock:^{
        NYSRootNavigationController *loginNavi = [[NYSRootNavigationController alloc] initWithRootViewController:[[NYSRootWebViewController alloc] initWithUrl:@"https://movie.douban.com/subject/30249161/"]];
        [NRootViewController presentViewController:loginNavi animated:YES completion:nil];
    }];
    adView = adView;
}

+ (void)showFPS {
    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = NScreenHeight - 55;
    _fpsLabel.right = NScreenWidth - 10;
    //    _fpsLabel.alpha = 0;
    [NAppWindow addSubview:_fpsLabel];
}

@end
