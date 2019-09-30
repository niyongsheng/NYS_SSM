//
//  NYSWebViewController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSRootViewController.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSWebViewController : NYSRootViewController
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic) UIColor *progressViewColor;
@property (nonatomic, weak) WKWebViewConfiguration * webConfiguration;
@property (nonatomic, copy) NSString * url;

- (instancetype)initWithUrl:(NSString *)url;

// 更新进度条
- (void)updateProgress:(double)progress;

// 更新导航栏按钮，子类去实现
- (void)updateNavigationItems;

@end

NS_ASSUME_NONNULL_END
