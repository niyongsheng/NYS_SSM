//
//  CMFAQViewController.m
//  CreditMoney
//
//  Created by 倪永胜 on 2019/4/29.
//  Copyright © 2019 QM. All rights reserved.
//

#import "NYSFAQViewController.h"
#import <MJRefresh.h>
#import "CMFAQModel.h"
#import "NYSFAQHeaderView.h"
#import "CMFAQTableViewCell.h"
#import "NSString+Size.h"

@interface NYSFAQViewController () <UITableViewDelegate, UITableViewDataSource, CMHeaderViewDelegate>
@property (nonatomic,strong) NSMutableArray *tableDataArray;
@property (nonatomic, strong) UITableView *FAQTableView;
@end

@implementation NYSFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FQA";
    self.customStatusBarStyle = UIStatusBarStyleLightContent;
    
    [self initUI];
    [self.FAQTableView.mj_header beginRefreshing];
}

- (void)initUI {
    //    self.FAQTableView.mj_header.hidden = YES;
    self.FAQTableView.mj_footer.hidden = YES;
    self.FAQTableView.delegate = self;
    self.FAQTableView.dataSource = self;
    self.FAQTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.FAQTableView];
}

- (UITableView *)FAQTableView {
    if (_FAQTableView == nil) {
        _FAQTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight) style:UITableViewStylePlain];
        _FAQTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _FAQTableView.estimatedRowHeight = 0;
        _FAQTableView.estimatedSectionHeaderHeight = 0;
        _FAQTableView.estimatedSectionFooterHeight = 0;
        
        // 头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _FAQTableView.mj_header = header;
        
        // 底部刷新
        _FAQTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        //        _FAQTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        //        _FAQTableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        
        _FAQTableView.backgroundColor = UIColorFromHex(0xf2f2f2);
        _FAQTableView.scrollsToTop = YES;
        _FAQTableView.tableFooterView = [[UIView alloc] init];
    }
    return _FAQTableView;
}

- (void)headerRereshing {
    NSString *JSON = @"";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.FAQTableView.mj_header endRefreshing];
        self.tableDataArray = [CMFAQModel mj_objectArrayWithFilename:@"FAQ.plist"];
        [self.FAQTableView reloadData];
    });
}

- (void)footerRereshing {
    
}

#pragma mark — tableview 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(CMFAQModel *)self.tableDataArray[section] expanded] ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [NSString getString:[(CMFAQModel *)self.tableDataArray[indexPath.section] desc] lineSpacing:0 font:[UIFont systemFontOfSize:15.f] width:ScreenWidth-50];
    NSArray *descArray = @[@"我们秉持着对用户数据隐私负责的态度，要求您使用个人实名认证手机号进行注册，也可使用第三方登录快速注册。\n\n温馨提示：请使用本人实名制使用时间最长的手机号且后续的资料认证需使用同一手机号。",@"为了和您建立正式的借款合约，需要验证您的身份信息。",
                           @"申请借款的资料\n\n      个人有效期内身份证件\n      个人真实信息\n      本人实名制使用时间最长的手机号\n 人脸识别认证\n\n申请借款的条件\n\n为保障账户安全，实名信息与账户信息一一关联；一个身份证号码／一个手机号／一张银行卡只能绑定一个实名账户；且该手机号需与银行卡、运营商认证等手机信息保持一致。",
                           @"原理：运营商认证即在您的授权下，登录运营商官网或商城的账户，查询通话账单、验证个人身份，是系统判断借款人真实性的必要条件。\n\n异常：手机运营商部分地区官网，会不时出现无法登录、无法查通话账单等情况，进而无法进行运营商认证，提示“异常／繁忙／失败”。\n\n方案：在不同时间段多尝试认证几次。",
                           @"可通过微信公众号或在线客服联系我们。"];
    return [NSString getStringHeightWithText:descArray[[[(CMFAQModel *)self.tableDataArray[indexPath.section] index] intValue]] font:[UIFont systemFontOfSize:16.f] viewWidth:NScreenWidth-50];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NYSFAQHeaderView *header = [[NYSFAQHeaderView alloc] init];
    header.delegate = self;
    header.FAQ = self.tableDataArray[section];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMFAQTableViewCell *cell = (CMFAQTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CMFAQTableViewCell"];
    if (cell == nil) {
        cell = (CMFAQTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"CMFAQTableViewCell" owner:self options:nil] lastObject];
    }
    cell.FAQ = self.tableDataArray[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - CMHeaderViewDelegate
- (void)headerViewDidClickedNameView:(NYSFAQHeaderView *)headerView {
    [self.FAQTableView reloadData];
}

@end
