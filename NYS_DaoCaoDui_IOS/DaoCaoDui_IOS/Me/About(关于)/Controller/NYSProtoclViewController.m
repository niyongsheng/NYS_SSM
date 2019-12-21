//
//  NYSProtoclViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/21.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSProtoclViewController.h"

@interface NYSProtoclViewController ()

@end

@implementation NYSProtoclViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"用户协议"];
    
    // 1、创建UIWebView:
    CGRect bouds = [[UIScreen mainScreen] bounds];
    UIWebView* webView = [[UIWebView alloc] initWithFrame:bouds];
    [self.view addSubview:webView];
    
    // 2、设置UIWebView的相关属性:
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor whiteColor];
    
    // 3、加载PDF
    NSString *pdfString = [[NSBundle mainBundle] pathForResource:@"UserPrivacyAgreement" ofType:@"pdf"];
    NSURL *filePath = [NSURL fileURLWithPath:pdfString];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
    [webView loadRequest:request];
}

@end
