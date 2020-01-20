//
//  NYSRecommendViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/7.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRecommendViewController.h"
#import "NYSRecommendModel.h"
#import "NYSRecommendTableViewCell.h"
#import <AXWebViewController.h>
#import "NYSBaseNavigationController.h"

static NSInteger pageSize = 7;
@interface NYSRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation NYSRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"推荐书单"];
    
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
    [NYSRequest GetRecommendListWithResMethod:GET
                                 parameters:parames
                                    success:^(id response) {
        [NYSRecommendModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        self.datasourceArray = [NYSRecommendModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [self.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeOverTurn tableView:self.tableView];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    } isCache:YES];
}

- (void)footerRereshing {
    ++ self.pageNum;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    parames[@"isPageBreak"] = @"1";
    parames[@"pageSize"] = @(pageSize);
    parames[@"pageNum"] = @(self.pageNum);
    [NYSRequest GetRecommendListWithResMethod:GET
                                 parameters:parames
                                    success:^(id response) {
        [NYSRecommendModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        NSArray *tempArray = [NYSRecommendModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        if (tempArray.count > 0) {
            [self.datasourceArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
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
    NYSRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NYSRecommendTableViewCell"];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NYSRecommendTableViewCell" owner:self options:nil] firstObject];
    }
    cell.recommendModel = self.datasourceArray[indexPath.row];
    cell.fromViewController = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:[self.datasourceArray[indexPath.row] targetUrl]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.barTintColor = NNavBgColor;
    webVC.navigationType = AXWebViewControllerNavigationToolItem;
    webVC.showsToolBar = YES;
    [self.navigationController pushViewController:webVC animated:YES];
    
//    NYSBaseNavigationController *webVCNavi = [[NYSBaseNavigationController alloc] initWithRootViewController:webVC];
//    webVCNavi.modalPresentationStyle = UIModalPresentationFullScreen;
//    webVCNavi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:webVCNavi animated:YES completion:nil];
}

@end
