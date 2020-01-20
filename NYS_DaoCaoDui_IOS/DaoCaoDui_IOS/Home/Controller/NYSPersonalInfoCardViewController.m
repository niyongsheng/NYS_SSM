//
//  NYSPersonalInfoCardViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2020/1/18.
//  Copyright © 2020 NiYongsheng. All rights reserved.
//

#import "NYSPersonalInfoCardViewController.h"
#import "UserInfo.h"
#import "NYSPersonalInfoCardHeaderView.h"
#import "NYSPersonalInfoCardFooterView.h"

@interface NYSPersonalInfoCardViewController () <UITableViewDelegate, UITableViewDataSource> {
    NYSPersonalInfoCardHeaderView *_headerView;
    NYSPersonalInfoCardFooterView *_footerView;
}
@property (nonatomic, strong) NSMutableArray *datasourceArray;
@end

@implementation NYSPersonalInfoCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.account];
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSPersonalInfoCardHeaderView" owner:self options:nil] objectAtIndex:0];
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, 200);
    self.tableView.tableHeaderView = _headerView;
    
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSPersonalInfoCardFooterView" owner:self options:nil] objectAtIndex:0];
    _footerView.frame = CGRectMake(0, 0, NScreenWidth, 50);
    _footerView.fromViewController = self;
    self.tableView.tableFooterView = _footerView;
    
    self.tableView.height = NScreenHeight - NTopHeight;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self headerRereshing];
}

- (void)headerRereshing {
    [NYSRequest DataProviderInfoForUserWithResMethod:GET
                                          parameters:@{@"account" : self.account}
                                             success:^(id response) {
        UserInfo *userInfo = [UserInfo mj_objectWithKeyValues:[response objectForKey:@"data"]];
        self->_headerView.userInfoModel = userInfo;
        self->_footerView.userInfoModel = userInfo;
    } failure:^(NSError *error) {
        
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
    return 65.f;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
