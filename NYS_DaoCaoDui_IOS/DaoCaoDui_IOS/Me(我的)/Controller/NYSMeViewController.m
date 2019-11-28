//
//  NYSMeViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMeViewController.h"
#import "NYSTransitionProtocol.h"
#import "NYSHeaderView.h"
#import "NYSMeTableViewCell.h"
#import "NYSMeModel.h"
#import <MJExtension/MJExtension.h>
#import "NYSFAQViewController.h"

#define NHeaderHeight ((200 * Iphone6ScaleWidth) + NStatusBarHeight)

@interface NYSMeViewController () <UITableViewDelegate, UITableViewDataSource, headerViewDelegate, NYSTransitionProtocol> {
    NSArray *_dataSource;
    NYSHeaderView *_headerView;
    // 自定义导航栏View
    UIView *_NavView;
}
@end

@implementation NYSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
//    self.title = @"我的";
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self wr_setNavBarBackgroundAlpha:0];
    [self getRequset];
}

#pragma mark -- 拉取数据 --
-(void)getRequset{
    _headerView.userInfo = NCurrentUser;
}

#pragma mark -- headerViewDelegate头像被点击 --
- (void)headerViewClick {
    NLog(@"headerViewClicked");
}

#pragma mark -- headerViewDelegate昵称被点击 --
- (void)nickNameViewClick {
    [self.navigationController pushViewController:[NYSRootViewController new] animated:YES];
}

#pragma mark - NYSTransitionAnimatorDataSource
- (UIImageView *)pushTransitionImageView {
    return _headerView.headImgView;
}

- (UIImageView *)popTransitionImageView {
    return nil;
}

- (UIView *)targetTransitionView {
    return _headerView.headImgView;
}

- (BOOL)isNeedTransition {
    return YES;
}

#pragma mark -- 创建页面 --
- (void)setupUI {
    [[UITableViewHeaderFooterView appearance] setTintColor:NViewBgColor];
    self.tableView.height = NScreenHeight - NTabBarHeight;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _headerView = [[NYSHeaderView alloc] initWithFrame:CGRectMake(0, -NHeaderHeight, NScreenWidth, NHeaderHeight)];
    _headerView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(_headerView.height, 0, 0, 0);
    [self.tableView addSubview:_headerView];
    [self.view addSubview:self.tableView];
    
    [self createNav];
    
    _dataSource = [NYSMeModel mj_objectArrayWithFilename:@"me.plist"];
    [self.tableView reloadData];
}

#pragma mark —- 创建自定义导航栏 —-
- (void)createNav {
    _NavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NTopHeight)];
    _NavView.backgroundColor = [UIColor clearColor];
    
    UILabel * titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, NStatusBarHeight, NScreenWidth/2, NNavBarHeight )];
    titlelbl.centerX = _NavView.width/2;
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.font= SYSTEMFONT(17);
    titlelbl.textColor = [UIColor whiteColor];
    titlelbl.text = self.title;
    [_NavView addSubview:titlelbl];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEMFONT(16);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(_NavView.width - btn.width - 15, NStatusBarHeight, btn.width, 40);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [_NavView addSubview:btn];
    
    [self.view addSubview:_NavView];
}

#pragma mark —- tableview 代理 —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NYSMeModel *cellModel = _dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = cellModel.titleText;
    cell.imageView.image = [UIImage imageNamed:cellModel.titleIcon];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *titleText = [_dataSource[indexPath.section][indexPath.row] titleText];
    if ([titleText isEqualToString:@"分享"]) {
       [[ShareManager sharedShareManager] showShareView];
    } else if ([titleText isEqualToString:@"关于"]) {
        [self.navigationController pushViewController:[NYSFAQViewController new] animated:YES];
    }
}

#pragma mark —- scrollView 代理 —-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat totalOffsetY = scrollView.contentInset.top + offset;
    CGFloat offsetWidth = totalOffsetY * 2.f;
    
    if (totalOffsetY < 0) {
        _headerView.frame = CGRectMake(offsetWidth/2, offset, self.view.width - offsetWidth, NHeaderHeight- totalOffsetY);
    }
}

#pragma mark —- 退出 --
- (void)logout:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出当先登录吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [NUserManager logout:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
