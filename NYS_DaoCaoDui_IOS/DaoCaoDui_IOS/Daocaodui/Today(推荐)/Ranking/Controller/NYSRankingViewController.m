//
//  NYSRankingViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/3.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSRankingViewController.h"
#import "NYSRankingTableViewCell.h"
#import "NYSActivityModel.h"
#import "NYSRankingListViewController.h"

@interface NYSRankingViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dateSource;
@end

@implementation NYSRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"打卡活动"];
    
    [self setupUI];
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark -- initUI --
- (void)setupUI {
    self.tableView.mj_header.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)footerRereshing {
    WS(weakSelf);
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"fellowship"] = @(NCurrentUser.fellowship);
    [NYSRequest GetClockActivityList:GET parameters:parames success:^(id response) {
        [NYSActivityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        weakSelf.dateSource = [NYSActivityModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [weakSelf.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeToTop tableView:self.tableView];
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    } isCache:NO];
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RealValue(120.0f);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NYSRankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NYSRankingTableViewCell"];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NYSRankingTableViewCell" owner:self options:nil] firstObject];
    }
    cell.activityModel = self.dateSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NYSRankingListViewController *rlVC = NYSRankingListViewController.new;
    rlVC.activityDatasource = self.dateSource[indexPath.row];
    [self.navigationController pushViewController:rlVC animated:YES];
}


@end
