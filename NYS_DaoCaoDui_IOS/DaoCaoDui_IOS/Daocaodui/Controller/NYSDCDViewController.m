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
#import "NYSMusicMenuSegmentViewController.h"
#import "NYSBibleViewController.h"

@interface NYSDCDViewController () <SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@end

@implementation NYSDCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.分页栏配置
    NSArray *titleArr = @[@"稻草堆", @"圣经", @"文章", @"音乐", @"代祷", @"活动"];
    SGPageTitleViewConfigure *segmentConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    segmentConfigure.indicatorStyle = SGIndicatorStyleDynamic;
    segmentConfigure.indicatorColor = [UIColor whiteColor];
    segmentConfigure.showBottomSeparator = YES;
    segmentConfigure.bottomSeparatorColor = [UIColor clearColor];
    segmentConfigure.indicatorDynamicWidth = 4;
    segmentConfigure.indicatorHeight = 4;
    segmentConfigure.indicatorCornerRadius = 2;
    segmentConfigure.indicatorToBottomDistance = 2;
    segmentConfigure.indicatorScrollStyle = SGIndicatorScrollStyleDefault;
    segmentConfigure.titleColor = [UIColor whiteColor];
    segmentConfigure.titleSelectedColor = [UIColor whiteColor];
    segmentConfigure.titleFont = [UIFont fontWithName:@"HYZhuZiMeiXinTiW" size:15];;
    segmentConfigure.titleTextZoom = YES;
    segmentConfigure.titleTextZoomRatio = .7f;
    
    // 2.分页栏view
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(-20, 0, NScreenWidth, 44) delegate:self titleNames:titleArr configure:segmentConfigure];
    self.pageTitleView.backgroundColor = [UIColor clearColor];
    LayoutFittingView *LFView = [[LayoutFittingView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 44)];
    [LFView addSubview:_pageTitleView];
    self.navigationItem.titleView = LFView;
    
    // 3.分页控制器
//    AXWebViewController *dcdWebVC0 = [[AXWebViewController alloc] initWithAddress:@"http://www.daocaodui.top:8080/web"];
//    AXWebViewController *dcdWebVC1 = [[AXWebViewController alloc] initWithAddress:@"http://www.daocaodui.top:8080/api/"];
//    AXWebViewController *dcdWebVC2 = [[AXWebViewController alloc] initWithAddress:@"http://www.daocaodui.top:8080/api/swagger-ui.html"];
    NSArray *childArr = @[[NYSDaocaoduiHomeViewController new], [NYSBibleViewController new], [HomeViewController new], [NYSMusicMenuSegmentViewController new], [NYSPrayCardListViewController new], [NYSActivityListViewController new]];
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
