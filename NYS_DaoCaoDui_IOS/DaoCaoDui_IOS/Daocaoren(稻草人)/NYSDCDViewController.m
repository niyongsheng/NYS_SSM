//
//  NYSDCDViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/17.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSDCDViewController.h"
#import "LayoutFittingView.h"
#import <SGPagingView/SGPagingView.h>

#import "NYSRootWebViewController.h"
#import "NYSMagicBoxViewController.h"

@interface NYSDCDViewController () <SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@end

@implementation NYSDCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.分页栏配置
    NSArray *titleArr = @[@"测试1", @"测试2"];
    SGPageTitleViewConfigure *titleConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    titleConfigure.indicatorStyle = SGIndicatorStyleDynamic;
    titleConfigure.indicatorColor = [UIColor whiteColor];
    titleConfigure.showBottomSeparator = YES;
    titleConfigure.bottomSeparatorColor = NNavBgColor;
    titleConfigure.indicatorDynamicWidth = 10;
    titleConfigure.indicatorHeight = 3.2f;
    titleConfigure.titleColor = [UIColor whiteColor];
    titleConfigure.titleSelectedColor = [UIColor whiteColor];
    titleConfigure.titleFont = [UIFont systemFontOfSize:15.f];
    titleConfigure.titleTextZoom = YES;
    titleConfigure.titleTextZoomRatio = 0.3f;
    
    // 2.分页栏view
    CGFloat pageTitleWidth = NScreenWidth - 200;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake((NScreenWidth - pageTitleWidth)/4 - 40, 0, pageTitleWidth, 44) delegate:self titleNames:titleArr configure:titleConfigure];
    self.pageTitleView.backgroundColor = [UIColor clearColor];
    LayoutFittingView *LFView = [[LayoutFittingView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 44)];
    [LFView addSubview:_pageTitleView];
    self.navigationItem.titleView = LFView;
    //    self.pageTitleView.selectedIndex = 1;
    
    // 3.分页控制器
    NYSRootWebViewController *homePageVC = [[NYSRootWebViewController alloc] initWithUrl:@"http://192.168.31.182:8080/api/"];
    NYSMagicBoxViewController *intelligentVC = [[NYSMagicBoxViewController alloc] init];
    NSArray *childArr = @[homePageVC, intelligentVC];
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight) parentVC:self childVCs:childArr];
    self.pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

#pragma mark - SGPagingViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
@end
