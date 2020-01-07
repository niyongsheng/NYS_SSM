//
//  NYSActivityListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSActivityListViewController.h"
#import <MJRefresh.h>
#import "NYSActivityModel.h"
#import "NYSActivityCollectionViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "NYSActivityInfoViewController.h"
#import <XRWaterfallLayout.h>

static float Magin = 10;
static NSInteger pageSize = 7;

@interface NYSActivityListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, XRWaterfallLayoutDelegate>
@property (strong, nonatomic) NSMutableArray *collectionDataArray;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation NYSActivityListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NNotificationCenter addObserver:self selector:@selector(refreshActivityList:) name:@"RefreshActivityListNotification" object:nil];
    
    [self initUI];
    [self headerRereshing];
}

#pragma mark — 初始化页面
- (void)initUI {
    // 创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:Magin rowSpacing:Magin sectionInset:UIEdgeInsetsMake(Magin, Magin, Magin, Magin)];
    waterfall.delegate = self;
    
    [self.collectionView setCollectionViewLayout:waterfall];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NYSActivityCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NYSActivityCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.height = NScreenHeight - NTopHeight;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight, 0);
    [self.view addSubview:self.collectionView];
}

- (void)updateUI {
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.7f animations:^{
        [self.view.superview layoutIfNeeded];
        [self.collectionView.superview layoutIfNeeded];
    }];
}

- (void)refreshActivityList:(NSNotification *)notification {
    [self headerRereshing];
}

- (void)headerRereshing {
    self.pageNum = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = @(pageSize);
    parames[@"pageNum"] = @(self.pageNum);
    [NYSRequest GetActivityList:GET parameters:parames success:^(id response) {
        [NYSActivityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        self.collectionDataArray = [NYSActivityModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer resetNoMoreData];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    } isCache:NO];
}

- (void)footerRereshing {
    ++ self.pageNum;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = @(pageSize);
    parames[@"pageNum"] = @(self.pageNum);
    [NYSRequest GetActivityList:GET parameters:parames success:^(id response) {
        [NYSActivityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        NSArray *tempArray = [NYSActivityModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        if (tempArray.count > 0) {
            [self.collectionDataArray addObjectsFromArray:tempArray];
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
    } isCache:NO];
}

#pragma mark — collection代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NYSActivityCollectionViewCell" forIndexPath:indexPath];
    cell.collectionModel = self.collectionDataArray[indexPath.row];
    cell.fromViewController = self;
    [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSActivityInfoViewController *actInfoVC = NYSActivityInfoViewController.new;
    actInfoVC.activityModel = self.collectionDataArray[indexPath.row];
    [self.navigationController pushViewController:actInfoVC animated:YES];
    
}

#pragma mark - XRWaterfallLayoutDelegate
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemHeight = itemWidth - 20 + [[self.collectionDataArray[indexPath.row] introduction] heightForFont:[UIFont systemFontOfSize:11.f] width:itemWidth - 20];
    return itemHeight;
}

@end
