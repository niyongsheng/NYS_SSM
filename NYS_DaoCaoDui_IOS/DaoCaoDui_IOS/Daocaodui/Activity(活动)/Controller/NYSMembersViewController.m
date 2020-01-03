//
//  NYSMembersViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/2.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSMembersViewController.h"
#import "NYSMemberCollectionViewCell.h"

static float Magin = 10;
static NSString *pageSize = @"40";
static NSString * const reuseIdentifier = @"NYSMemberCollectionViewCell";
@interface NYSMembersViewController ()  <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation NYSMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成员列表";
    
    [self initUI];
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
    self.collectionView.height = NScreenHeight - NTopHeight;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NYSMemberCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.mj_header.hidden = YES;
    self.collectionView.mj_footer.hidden = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

#pragma mark — collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.memberListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSMemberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.memberModel = self.memberListArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
