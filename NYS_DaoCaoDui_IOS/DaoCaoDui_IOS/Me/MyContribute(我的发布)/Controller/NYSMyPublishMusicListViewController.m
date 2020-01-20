//
//  NYSMyPublishMusicListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSMyPublishMusicListViewController.h"
#import "NYSMyPublishTableViewCell.h"
#import "NYSMusicModel.h"

static NSInteger pageSize = 7;
@interface NYSMyPublishMusicListViewController () <UITableViewDelegate, UITableViewDataSource, NYSMyPublishTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *datasourceArray;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation NYSMyPublishMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.height = NScreenHeight - NTopHeight - SegmentViewHeight;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    [NYSRequest GetPublishMusicListWithResMethod:GET
                    parameters:parames
                       success:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer resetNoMoreData];
        [NYSMusicModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        weakSelf.datasourceArray = [NYSMusicModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
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
    [NYSRequest GetPublishMusicListWithResMethod:GET
                    parameters:parames
                       success:^(id response) {
        [NYSMusicModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        NSArray *tempArray = [NYSMusicModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
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
    return 120;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NYSMyPublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NYSMyPublishTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NYSMyPublishTableViewCell" owner:self options:nil] firstObject];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.collectionMusicModel = self.datasourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:.2f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        cell.transform = CGAffineTransformIdentity;
        
    }];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self deleteItemButton:indexPath.row];
        completionHandler (YES);
    }];
    deleteRowAction.image = [UIImage imageNamed:@"ic_delete_round_12x12_"];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

#pragma mark - NYSMyPublishTableViewCellDelegate
- (void)deleteItemButton:(NSInteger)index {
    WS(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要删除？" message:@"删除后收藏关系自动解除且无法恢复" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSInteger musicID = [weakSelf.datasourceArray[index] idField];
        [NYSRequest DeleteMusicByIdWithResMethod:GET
                                        parameters:@{@"musicID" : @(musicID)}
                                           success:^(id response) {
            [weakSelf.datasourceArray removeObjectAtIndex:index];
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
