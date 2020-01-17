//
//  NYSPrayCollectionListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/17.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSPrayCollectionListViewController.h"
#import "NYSCollectionTableViewCell.h"
#import "NYSPrayModel.h"
#import "NYSPrayCardInfoViewController.h"

static NSInteger pageSize = 7;
@interface NYSPrayCollectionListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *datasourceArray;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation NYSPrayCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.height = NScreenHeight - NTopHeight;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)headerRereshing {
    self.pageNum = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = @(pageSize);
    parames[@"pageNum"] = @(self.pageNum);
    WS(weakSelf);
    [NYSRequest getCollectionPrayListWithResMethod:GET
                    parameters:parames
                       success:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer resetNoMoreData];
        [NYSPrayModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        weakSelf.datasourceArray = [NYSPrayModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
        [weakSelf.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeMove tableView:weakSelf.tableView];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    } isCache:YES];
}

- (void)footerRereshing {
    ++ self.pageNum;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = @(pageSize);
    parames[@"pageNum"] = @(self.pageNum);
    WS(weakSelf);
    [NYSRequest getCollectionPrayListWithResMethod:GET
                    parameters:parames
                       success:^(id response) {
        [NYSPrayModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        NSArray *tempArray = [NYSPrayModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        if (tempArray.count > 0) {
            [weakSelf.datasourceArray addObjectsFromArray:tempArray];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    } isCache:YES];
}

#pragma mark —- tableview delegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NYSCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NYSCollectionTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NYSCollectionTableViewCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.collectionPrayModel = self.datasourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:.2f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        cell.transform = CGAffineTransformIdentity;
        NYSPrayCardInfoViewController *prayCardInfoVC = [[NYSPrayCardInfoViewController alloc] init];
        prayCardInfoVC.prayModel = self.datasourceArray[indexPath.row];
        prayCardInfoVC.modalPresentationStyle = UIModalPresentationFullScreen;
        prayCardInfoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:prayCardInfoVC animated:YES completion:nil];
    }];
}

@end
