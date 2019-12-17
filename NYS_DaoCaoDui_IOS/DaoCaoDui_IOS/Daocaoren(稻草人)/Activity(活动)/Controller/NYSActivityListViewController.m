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
#import "QMHACCollectionViewCell.h"
#import "QMHGroupCardViewController.h"
//#import "QMHMyGroupViewController.h"
#import <RongIMKit/RongIMKit.h>

static float Magin = 10;
static NSString *pageSize = @"10";
@interface NYSActivityListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *collectionDataArray;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation NYSActivityListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark — 初始化页面
- (void)initUI {
    int count = 2;
    // 自动瀑布流布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (NScreenWidth - 15 - count * Magin) / count;
    // 设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * 19/16 * Iphone6ScaleWidth);
    // 最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 15;
    // 最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 15;
    // 设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(Magin, Magin, Magin, Magin);
    // 设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QMHACCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"QMHACCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.collectionView];
}

- (void)updateUI {
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.7f animations:^{
        [self.view.superview layoutIfNeeded];
        [self.collectionView.superview layoutIfNeeded];
    }];
}

- (void)headerRereshing {
    self.currentPage = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = pageSize;
    parames[@"pageNum"] = [NSString stringWithFormat:@"%ld", _currentPage];
    [NYSRequest GetActivityList:GET parameters:parames success:^(id response) {
        [NYSActivityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        self.collectionDataArray = [NYSActivityModel mj_objectArrayWithKeyValuesArray:[[response objectForKey:@"data"] objectForKey:@"list"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer resetNoMoreData];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    } isCache:NO];
}

- (void)footerRereshing {
    ++ self.currentPage;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = pageSize;
    parames[@"pageNum"] = [NSString stringWithFormat:@"%ld", _currentPage];
    [NYSRequest GetActivityList:GET parameters:parames success:^(id response) {
        [NYSActivityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        NSArray *tempArray = [NYSActivityModel mj_objectArrayWithKeyValuesArray:[[response objectForKey:@"data"] objectForKey:@"list"]];
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
    return _collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QMHACCollectionViewCell *cell = (QMHACCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"QMHACCollectionViewCell" forIndexPath:indexPath];
    cell.collectionModel = self.collectionDataArray[indexPath.row];
    cell.fromViewController = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}


@end
