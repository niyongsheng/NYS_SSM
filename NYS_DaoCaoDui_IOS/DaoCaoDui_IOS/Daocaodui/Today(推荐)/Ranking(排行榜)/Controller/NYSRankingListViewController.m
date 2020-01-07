//
//  NYSRankingListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/4.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRankingListViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "NYSPagingViewTableHeaderView.h"
#import "NYSClockListView.h"
#import "NYSActivityInfoViewController.h"

static const CGFloat JXTableHeaderViewHeight = 260;
static const CGFloat JXheightForHeaderInSection = 55;
@interface NYSRankingListViewController () <JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) NYSPagingViewTableHeaderView *clockHeaderView;

@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation NYSRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:[self.activityDatasource name]];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_attention_17x17_"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    
    _titles = @[@"已打卡", @"未打卡"];
    
    _clockHeaderView = [[NYSPagingViewTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXTableHeaderViewHeight)];
    _clockHeaderView.datasource = self.activityDatasource;
    _clockHeaderView.fromController = self;
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = NNavBgColor;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelMaskEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor colorWithRed:0.91 green:0.25 blue:0.44 alpha:1.00];
    lineView.indicatorWidth = 20;
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

- (void)rightItemClicked {
    NYSActivityInfoViewController *aiVC = NYSActivityInfoViewController.new;
    aiVC.activityModel = self.activityDatasource;
    [self.navigationController pushViewController:aiVC animated:YES];
}

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.clockHeaderView;
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
    NYSClockListView *list = [[NYSClockListView alloc] init];
    if (index == 0) {
        list.dataSource = self.activityDatasource.clockedUserList.mutableCopy;
        list.isClocked = NO;
        list.fromController = self;
    } else if (index == 1) {
        list.dataSource = self.activityDatasource.unclockUserList.mutableCopy;
        list.isClocked = YES;
        list.fromController = self;
    }
    return list;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    [self.clockHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end
