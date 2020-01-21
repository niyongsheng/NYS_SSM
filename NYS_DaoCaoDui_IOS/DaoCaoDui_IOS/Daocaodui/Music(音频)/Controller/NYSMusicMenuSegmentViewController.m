//
//  NYSMusicMenuSegmentViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/18.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMusicMenuSegmentViewController.h"
#import "NYSMusicListViewController.h"
#import <SGPagingView.h>
#import "NYSMusicMenuModel.h"

@interface NYSMusicMenuSegmentViewController ()  <SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableArray<NYSMusicMenuModel *> *datasourceArray;
@end

@implementation NYSMusicMenuSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WS(weakSelf);
    [NYSRequest GetMusicMenuList:GET parameters:@{@"fellowship" : @(NCurrentUser.fellowship)} success:^(id response) {
        [NYSMusicMenuModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        [weakSelf initUI:[NYSMusicMenuModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]]];
    } failure:^(NSError *error) {
        
    } isCache:YES];
}

- (void)initUI:(NSArray *)datasourceArray {
    // prepare data
    NSMutableArray *titleArray = [NSMutableArray array], *childArray = [NSMutableArray array];
    for (NYSMusicMenuModel *musicMenu in datasourceArray) {
        [titleArray addObject:musicMenu.name];
        
        NYSMusicListViewController *mlVC = [[NYSMusicListViewController alloc] init];
        mlVC.musicMenuID = musicMenu.idField;
        [childArray addObject:mlVC];
    }
    // config segment
    SGPageTitleViewConfigure *segmentConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    segmentConfigure.indicatorStyle = SGIndicatorStyleFixed;
    segmentConfigure.indicatorScrollStyle = SGIndicatorScrollStyleEnd;
    segmentConfigure.indicatorAnimationTime = 0.2f;
    segmentConfigure.indicatorColor = [NNavBgColorShallow colorWithAlphaComponent:0.4f];
    segmentConfigure.showBottomSeparator = NO;
    segmentConfigure.bottomSeparatorColor = [UIColor clearColor];
    segmentConfigure.indicatorFixedWidth = 20;
    segmentConfigure.indicatorDynamicWidth = 7;
    segmentConfigure.indicatorHeight = 5.f;
    segmentConfigure.indicatorCornerRadius = 4.0f;
    segmentConfigure.indicatorToBottomDistance = 3;
    segmentConfigure.titleColor = NBgColorLightGray;
    segmentConfigure.titleSelectedColor = NBgSilverColor1;
    segmentConfigure.titleFont = [UIFont fontWithName:@"HYZhuZiMeiXinTiW" size:15];
    segmentConfigure.titleTextZoom = NO;
    segmentConfigure.titleTextZoomRatio = 0.5f;
    // segment view init
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, NScreenWidth, SegmentViewHeight) delegate:self titleNames:titleArray configure:segmentConfigure];
    self.pageTitleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [self.view addSubview:_pageTitleView];
    self.pageTitleView.selectedIndex = 0;
    
    CGFloat ContentCollectionViewHeight = NScreenHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), NScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArray];
    
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

@end
