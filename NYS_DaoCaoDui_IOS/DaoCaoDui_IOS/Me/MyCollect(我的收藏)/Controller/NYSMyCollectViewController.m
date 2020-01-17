//
//  NYSMyCollectViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMyCollectViewController.h"
#import <SGPagingView.h>
#import "NYSArticleCollectionListViewController.h"
#import "NYSPrayCollectionListViewController.h"
#import "NYSMusicCollectionListViewController.h"

@interface NYSMyCollectViewController () <SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end

@implementation NYSMyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的收藏"];
    
    NSArray *titleArr = @[@"文章", @"代祷", @"音乐"];
    SGPageTitleViewConfigure *segmentConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    segmentConfigure.indicatorStyle = SGIndicatorStyleCover;
    segmentConfigure.indicatorColor = [UIColor whiteColor];
    segmentConfigure.bounces = YES;
    segmentConfigure.showBottomSeparator = NO;
    segmentConfigure.bottomSeparatorColor = [UIColor clearColor];
    segmentConfigure.indicatorHeight = 28.f;
    segmentConfigure.indicatorAdditionalWidth = 28.f;
    segmentConfigure.indicatorCornerRadius = 14.f;
    segmentConfigure.indicatorBorderColor = NNavBgColor;
    segmentConfigure.indicatorBorderWidth = 1.f;
    segmentConfigure.showBottomSeparator = YES;
    segmentConfigure.titleFont = [UIFont systemFontOfSize:15.f];
    
    // segment view
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, NScreenWidth, SegmentViewHeight) delegate:self titleNames:titleArr configure:segmentConfigure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    self.pageTitleView.selectedIndex = self.index;

    NSArray *childArr = @[NYSArticleCollectionListViewController.new, NYSPrayCollectionListViewController.new, NYSMusicCollectionListViewController.new];

    CGFloat ContentCollectionViewHeight = NScreenHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), NScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    
    self.pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:self.pageContentCollectionView];
}

#pragma mark - SGPagingViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
