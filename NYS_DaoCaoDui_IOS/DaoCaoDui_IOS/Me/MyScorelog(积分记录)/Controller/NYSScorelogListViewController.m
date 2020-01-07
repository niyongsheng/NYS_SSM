//
//  NYSScorelogListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/6.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSScorelogListViewController.h"
#import "NYSScorelogModel.h"

static NSInteger pageSize = 50;
@interface NYSScorelogListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation NYSScorelogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"积分记录"];
    
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
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
    [NYSRequest GetScoreRecordWithResMethod:GET
                                 parameters:parames
                                    success:^(id response) {
        [NYSScorelogModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        self.datasourceArray = [NYSScorelogModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [self.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeToTop tableView:self.tableView];
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
    [NYSRequest GetScoreRecordWithResMethod:GET
                                 parameters:parames
                                    success:^(id response) {
        [NYSScorelogModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID" : @"id"};
        }];
        NSArray *tempArray = [NYSScorelogModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        if (tempArray.count > 0) {
            [self.datasourceArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
//            [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeToTop tableView:self.tableView];
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
    return 65;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    NYSScorelogModel *scorelog = self.datasourceArray[indexPath.row];
    switch ([scorelog type]) {
        case 1: cell.textLabel.text = @"签到"; break;
        case 2: cell.textLabel.text = @"打赏"; break;
        case 3: cell.textLabel.text = @"交易"; break;
        default:
            break;
    }
    cell.detailTextLabel.numberOfLines = 0;
    NSString *amount = [NSString stringWithFormat:@"%ld", [scorelog amount]];
    NSString *str = [NSString stringWithFormat:@"%@粒稻壳\n%@", amount, [scorelog gmtCreate]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:amount]];
    cell.detailTextLabel.attributedText = attrStr;
    
    return cell;
}



@end
