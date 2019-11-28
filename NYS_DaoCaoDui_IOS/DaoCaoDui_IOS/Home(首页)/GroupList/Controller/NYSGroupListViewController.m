//
//  NYSGroupListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/26.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSGroupListViewController.h"
#import <Masonry.h>
#import "NYSGroupModel.h"
#import "NYSGroupCollectionCell.h"

static float Magin = 10;
static NSString *pageSize = @"10";
static NSString *CELL_ID = @"NYSGroupCollectionCell";

@interface NYSGroupListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *collectionDataArray;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation NYSGroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"小伙伴们"];
    
    [self initUI];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark — 初始化页面
- (void)initUI {
    // 自动瀑布流布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (NScreenWidth - (4 * Magin)) / 2;
    // 设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, 90 * (NScreenWidth / 375));
    // 最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 15;
    // 最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 0;
    // 设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(Magin, Magin, Magin, Magin);
    // 设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NYSGroupCollectionCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_ID];
    self.collectionView.height = NScreenHeight;
    self.collectionView.mj_footer.hidden = YES;
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
    [NYSRequest GetGroupListWithResMethod:GET parameters:@{@"fellowship" : @1} success:^(id response) {
        [NYSGroupModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        self.collectionDataArray = [NYSGroupModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        NLog(@"网络错误:%@", error);
    } isCache:NO];
}

- (void)footerRereshing {

}

#pragma mark — collection代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSGroupCollectionCell *cell = (NYSGroupCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
    cell.groupModel = self.collectionDataArray[indexPath.row];
    cell.fromViewController = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
