//
//  QMHCAListViewController.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/23.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHCAListViewController.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "QMHCommunityActivityList.h"
#import "QMHACCollectionViewCell.h"
#import "QMHGroupCardViewController.h"
//#import "QMHMyGroupViewController.h"
#import <RongIMKit/RongIMKit.h>

static float Magin = 10;
static NSString *pageSize = @"10";

@interface QMHCAListViewController ()  <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *collectionDataArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation QMHCAListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

/**
 *  懒加载collectionView
 *
 *  @return collectionView
 */
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth , NScreenHeight - NTopHeight - NTabBarHeight) collectionViewLayout:flow];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
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
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    parames[@"account"]  =  [userdefaults objectForKey:@"account"];
    parames[@"token"] = [userdefaults objectForKey:@"token"];
    parames[@"comNo"] = [userdefaults objectForKey:@"comNo"];
    parames[@"currentPage"] = [NSString stringWithFormat:@"%ld", _currentPage];
    parames[@"pageSize"] = pageSize;
    NLog(@"parames = %@", parames);
//    [QMHNetworkingRequestLayer requestWithAPI:self.activitylistUrl parameters:parames success:^(id response) {
//        [QMHCommunityActivityList mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"ID" : @"id"};
//        }];
//        self.collectionDataArray = [QMHCommunityActivityList mj_objectArrayWithKeyValuesArray:[response objectForKey:@"list"]];
//        [self.collectionView reloadData];
//        [self.collectionView.mj_header endRefreshing];
//        [self.collectionView.mj_footer resetNoMoreData];
//    } failure:^(NSError *error) {
//        [self.collectionView.mj_header endRefreshing];
//        NLog(@"网络错误:%@", error);
//    } showLoadingStatusMessages:nil isCache:NO];
}

- (void)footerRereshing {
    ++ self.currentPage;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    parames[@"account"]  =  [userdefaults objectForKey:@"account"];
    parames[@"token"] = [userdefaults objectForKey:@"token"];
    parames[@"comNo"] = [userdefaults objectForKey:@"comNo"];
    parames[@"currentPage"] = [NSString stringWithFormat:@"%ld", _currentPage];
    parames[@"pageSize"] = pageSize;
    NLog(@"parames = %@", parames);
//    [QMHNetworkingRequestLayer requestWithAPI:self.activitylistUrl parameters:parames success:^(id response) {
//        [QMHCommunityActivityList mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"ID" : @"id"};
//        }];
//        NSArray *tempArray = [QMHCommunityActivityList mj_objectArrayWithKeyValuesArray:[response objectForKey:@"list"]];
//        if (tempArray.count > 0) {
//            [self.collectionDataArray addObjectsFromArray:tempArray];
//            [self.collectionView reloadData];
//            [self.collectionView.mj_footer endRefreshing];
//        } else {
//            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//        }
//    } failure:^(NSError *error) {
//        [self.collectionView.mj_footer endRefreshing];
//        NLog(@"网络错误:%@", error);
//    } showLoadingStatusMessages:nil isCache:NO];
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
    QMHCommunityActivityList *activity = self.collectionDataArray[indexPath.row];
        if ([[activity creator] isEqualToString:[[[RCIMClient sharedRCIMClient] currentUserInfo] userId]]) {
//            QMHMyGroupViewController *groupCardVC = [[QMHMyGroupViewController alloc] init];
//            groupCardVC.aID = [activity ID];
//            [self.navigationController pushViewController:groupCardVC animated:YES];
        } else {
            QMHGroupCardViewController *groupCardVC = [[QMHGroupCardViewController alloc] init];
            groupCardVC.aID = [activity ID];
            groupCardVC.groupId = [activity groupId];
            groupCardVC.inGroup = [[activity inGroup] boolValue];
            [self.navigationController pushViewController:groupCardVC animated:YES];
        }
}

@end
