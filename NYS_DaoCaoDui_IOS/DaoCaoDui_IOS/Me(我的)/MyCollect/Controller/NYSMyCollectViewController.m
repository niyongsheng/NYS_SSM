//
//  NYSMyCollectViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMyCollectViewController.h"
#import "QMHCAListViewController.h"
#import <SGPagingView.h>
#import "QMHCreateActViewController.h"

@interface NYSMyCollectViewController () <SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end

@implementation NYSMyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的收藏"];

    UIBarButtonItem *createActivity = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createActivityClicked:)];
    self.navigationItem.rightBarButtonItem = createActivity;
    
    NSArray *titleArr = @[@"文章", @"音乐", @"代祷"];
    SGPageTitleViewConfigure *titleConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    titleConfigure.indicatorStyle = SGIndicatorStyleDynamic;
    titleConfigure.indicatorColor = [UIColor orangeColor];
    titleConfigure.showBottomSeparator = YES;
    titleConfigure.bottomSeparatorColor = [UIColor colorWithRed:237.996/255.0 green:237.996/255.0 blue:237.996/255.0 alpha:1];
    titleConfigure.indicatorDynamicWidth = 20;
    titleConfigure.indicatorHeight = 3.2f;
    titleConfigure.titleColor = RGBColor(161, 160, 160);
    titleConfigure.titleSelectedColor = RGBColor(58, 58, 58);
    titleConfigure.titleFont = [UIFont systemFontOfSize:14];
    titleConfigure.titleTextZoom = YES;
    titleConfigure.titleTextZoomRatio = 0.6f;
    
    // 分页栏view
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, NTopHeight, NScreenWidth, 44) delegate:self titleNames:titleArr configure:titleConfigure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    self.pageTitleView.selectedIndex = self.index;
    
    QMHCAListViewController *acListVC1 = [[QMHCAListViewController alloc] init];
    acListVC1.activitylistUrl = @"/api/activity/getDefaultList";
    QMHCAListViewController *acListVC2 = [[QMHCAListViewController alloc] init];
    acListVC2.activitylistUrl = @"/api/activity/getMemberNumList";
    QMHCAListViewController *acListVC3 = [[QMHCAListViewController alloc] init];
    acListVC3.activitylistUrl = @"/api/activity/getActiveList";
    NSArray *childArr = @[acListVC1, acListVC2, acListVC3];

    CGFloat ContentCollectionViewHeight = NScreenHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), NScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

#pragma mark - SGPagingViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

/** 创建活动 */
- (void)createActivityClicked:(id)sender {
    QMHCreateActViewController *cVC = [[QMHCreateActViewController alloc] init];
    cVC.title = @"创建活动";
    [self.navigationController pushViewController:cVC animated:YES];
}

@end
