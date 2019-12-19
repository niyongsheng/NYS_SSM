//
//  QMHMemberListCollectionVC.m
//  安居公社
//
//  Created by 倪永胜 on 2019/10/30.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHMemberListCollectionVC.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "QMHMemberCollectionViewCell.h"
#import "QMHMemberModel.h"
#import "NYSConversationViewController.h"

static float Magin = 10;
static NSString *pageSize = @"40";
static NSString * const reuseIdentifier = @"QMHMemberCollectionViewCell";

@interface QMHMemberListCollectionVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *collectionDataArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation QMHMemberListCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群成员";
    
    [self initUI];
    [self.collectionView.mj_header beginRefreshing];
}

/**
 *  懒加载collectionView
 *
 *  @return collectionView
 */
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth , NScreenHeight) collectionViewLayout:flow];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
        _collectionView.backgroundColor = UIColorFromHex(0XF7F7F7);
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}

#pragma mark — 初始化页面
- (void)initUI {
    // 自动瀑布流布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (NScreenWidth - (6 * Magin)) / 5;
    // 设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, 90 * (NScreenWidth / 375));
    // 最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 15;
    // 最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 10;
    // 设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(Magin, Magin, Magin, Magin);
    // 设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QMHMemberCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (void)headerRereshing {
    self.currentPage = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    parames[@"account"]  =  [userdefaults objectForKey:@"account"];
    parames[@"token"] = [userdefaults objectForKey:@"token"];
    parames[@"comNo"] = [userdefaults objectForKey:@"comNo"];
    parames[@"id"] = self.groupID;
    parames[@"currentPage"] = [NSString stringWithFormat:@"%ld", _currentPage];
    parames[@"pageSize"] = pageSize;
    NLog(@"parames = %@", parames);
//    [QMHNetworkingRequestLayer requestWithAPI:@"/api/activity/getGroupMember" parameters:parames success:^(id response) {
//        [QMHMemberModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"ID" : @"id"};
//        }];
//        self.collectionDataArray = [QMHMemberModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"list"]];
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
    parames[@"id"] = self.groupID;
    parames[@"currentPage"] = [NSString stringWithFormat:@"%ld", _currentPage];
    parames[@"pageSize"] = pageSize;
    NLog(@"parames = %@", parames);
//    [QMHNetworkingRequestLayer requestWithAPI:@"/api/activity/getGroupMember" parameters:parames success:^(id response) {
//        [QMHMemberModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{@"ID" : @"id"};
//        }];
//        NSArray *tempArray = [QMHMemberModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"list"]];
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
    QMHMemberCollectionViewCell *cell = (QMHMemberCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.collectionModel = self.collectionDataArray[indexPath.row];
    cell.fromViewController = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QMHMemberModel *mm = (QMHMemberModel *)self.collectionDataArray[indexPath.row];
    NYSConversationViewController *groupConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:mm.member];
    groupConversationVC.title = mm.nickName;
    [self.navigationController pushViewController:groupConversationVC animated:YES];
}

@end
