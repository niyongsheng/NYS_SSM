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
#import <AXWebViewController.h>
#import "HomeViewController.h"
#import "NYSDaocaoduiHomeViewController.h"
#import "NYSPrayCardListViewController.h"
#import "NYSActivityListViewController.h"
#import "NYSMusicListViewController.h"

@interface NYSDCDViewController () <SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@end

@implementation NYSDCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.分页栏配置
    NSArray *titleArr = @[@"稻草堆", @"文章", @"音乐", @"代祷", @"活动", @"Bible"];
    SGPageTitleViewConfigure *titleConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    titleConfigure.indicatorStyle = SGIndicatorStyleDynamic;
    titleConfigure.indicatorColor = [UIColor whiteColor];
    titleConfigure.showBottomSeparator = YES;
    titleConfigure.bottomSeparatorColor = NNavBgColor;
    titleConfigure.indicatorDynamicWidth = 4;
    titleConfigure.indicatorHeight = 4;
    titleConfigure.titleColor = [UIColor whiteColor];
    titleConfigure.titleSelectedColor = [UIColor whiteColor];
    titleConfigure.titleFont = [UIFont fontWithName:@"HYZhuZiMeiXinTiW" size:15];;
    titleConfigure.titleTextZoom = YES;
    titleConfigure.titleTextZoomRatio = .7f;
    
    // 2.分页栏view
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(-20, 0, NScreenWidth, 44) delegate:self titleNames:titleArr configure:titleConfigure];
    self.pageTitleView.backgroundColor = [UIColor clearColor];
    LayoutFittingView *LFView = [[LayoutFittingView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 44)];
    [LFView addSubview:_pageTitleView];
    self.navigationItem.titleView = LFView;
    //    self.pageTitleView.selectedIndex = 1;
    
    // 3.分页控制器
    HomeViewController *articlePageVC = [[HomeViewController alloc] init];
    AXWebViewController *dcdWebVC0 = [[AXWebViewController alloc] initWithAddress:@"http://www.daocaodui.top:8080/web"];
    AXWebViewController *dcdWebVC1 = [[AXWebViewController alloc] initWithAddress:@"http://www.daocaodui.top:8080/api/"];
    AXWebViewController *dcdWebVC2 = [[AXWebViewController alloc] initWithAddress:@"http://www.daocaodui.top:8080/api/swagger-ui.html"];
    NSArray *childArr = @[[NYSDaocaoduiHomeViewController new], articlePageVC, [NYSMusicListViewController new], [NYSPrayCardListViewController new], [NYSActivityListViewController new], dcdWebVC2];
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
