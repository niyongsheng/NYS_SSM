//
//  NYSMusicListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMusicListViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "NYSPagingViewTableHeaderView.h"
#import "NYSMusicListView.h"

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 50;

@interface NYSMusicListViewController ()
<JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) NYSPagingViewTableHeaderView *musicHeaderView;

@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation NYSMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"新歌", @"敬拜", @"安静"];
    
    _musicHeaderView = [[NYSPagingViewTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXTableHeaderViewHeight)];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = NNavBgColor;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = NNavBgColor;
    lineView.indicatorWidth = 30;
    self.categoryView.indicators = @[lineView];
    
    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];
    
    // FIXME:如果和JXPagingView联动
    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagingView.frame = self.view.bounds;
}

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.musicHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    NYSMusicListView *list = [[NYSMusicListView alloc] init];
    if (index == 0) {
        list.dataSource = @[@"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", ].mutableCopy;
    }else if (index == 1) {
        list.dataSource = @[@"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", ].mutableCopy;
    }else if (index == 2) {
        list.dataSource = @[@"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", @"喜乐赞美主1", ].mutableCopy;
    }
    return list;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    [self.musicHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
}

@end
