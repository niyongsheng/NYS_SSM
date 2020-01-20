//
//  NYSContactsViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/10/21.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSContactsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserInfo.h"
#import "NYSConversationViewController.h"

@interface NYSContactsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation NYSContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小伙伴";
    self.tableView.height = NScreenHeight;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)headerRereshing {
    WS(weakSelf);
    [NYSRequest GetUserListWithResMethod:GET
                              parameters:@{@"isPageBreak" : @"0", @"fellowship" : @(NCurrentUser.fellowship)}
                                 success:^(id response) {
        weakSelf.dataSource = [UserInfo mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [weakSelf.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeLayDown tableView:weakSelf.tableView];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    } isCache:NO];
}

- (void)footerRereshing {
}

#pragma mark —- tableview 代理 —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ID = @"UserCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UserInfo *userModel = _dataSource[indexPath.section];
    cell.textLabel.text = userModel.nickname;
    cell.detailTextLabel.text = userModel.introduction ? [NSString stringWithFormat:@"简介：%@", userModel.introduction] : nil;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:userModel.icon] placeholderImage:[UIImage imageNamed:@"chat_single"]];
    
    // 调整cell的imageview大小
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.layer.cornerRadius = 20.f;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UserInfo *userModel = _dataSource[indexPath.section];
    NYSConversationViewController *privateConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:userModel.account];
    privateConversationVC.title = userModel.nickname;
    [self.navigationController pushViewController:privateConversationVC animated:YES];
}

@end
