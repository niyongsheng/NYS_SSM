//
//  NYSMeViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/5/29.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMeViewController.h"
#import "NYSHeaderView.h"
#import "NYSMeTableViewCell.h"
#import "NYSMeModel.h"
#import <MJExtension/MJExtension.h>
#import <WXWaveView.h>

#import "NYSPersonalInfoViewController.h"
#import "NYSFAQViewController.h"

#define NHeaderHeight ((200 * Iphone6ScaleWidth) + NStatusBarHeight)

@interface NYSMeViewController () <UITableViewDelegate, UITableViewDataSource, headerViewDelegate> {
    NSArray *_dataSource;
    NYSHeaderView *_headerView;
}
@property (strong, nonatomic) WXWaveView *waveView;
@end

@implementation NYSMeViewController

- (WXWaveView *)waveView {
    if (!_waveView) {
        _waveView = [WXWaveView addToView:_headerView withFrame:CGRectMake(0, NHeaderHeight + 10, NScreenWidth, 15)];
        _waveView.waveTime = 1.5f; // When 0, the wave will never stop;
        _waveView.waveColor = [UIColor whiteColor];
        _waveView.waveSpeed = 10.f;
        _waveView.angularSpeed = 1.8f;
    }
    return _waveView;
}

- (void)viewDidLayoutSubviews {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.isHidenNaviBar = YES;
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    
    // 初始化UI
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequset];
}

#pragma mark -- getData --
-(void)getRequset {
    _headerView.userInfo = NCurrentUser;
}

#pragma mark -- headerViewDelegate头像被点击 --
- (void)headerViewClick {
    [self.navigationController pushViewController:[NYSPersonalInfoViewController new] animated:YES];
}

#pragma mark -- headerViewDelegate昵称被点击 --
- (void)nickNameViewClick {
    [self.navigationController pushViewController:NYSRootViewController.new animated:YES];
}

#pragma mark -- initUI --
- (void)setupUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight - NTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _headerView = [[NYSHeaderView alloc] initWithFrame:CGRectMake(0, -NStatusBarHeight, NScreenWidth, NHeaderHeight)];
    _headerView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(_headerView.height, 0, 0, 0);
    [self.tableView addSubview:_headerView];
//    [self.tableView setTableHeaderView:_headerView];
    [self.view addSubview:self.tableView];
    
    _dataSource = [NYSMeModel mj_objectArrayWithFilename:@"me.plist"];
    [self.tableView reloadData];
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
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

/** 设置section整体圆角 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        if (tableView == self.tableView) {
            // 圆角尺寸
            CGFloat cornerRadius = 15.f;
            
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) { // 分组首行
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) { // 分组末行
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
            layer.shadowColor = [UIColor grayColor].CGColor;
            //        self.layer.shadowOffset = CGSizeMake(3, 3); // 有偏移量的情况,默认向右向下有阴影
            // 设置偏移量为0,四周都有阴影
            layer.shadowOffset = CGSizeZero;
            layer.shadowOpacity = 0.3f;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-20, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
//                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

#pragma mark —- ScrollViewDelegate 下拉放大header —-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat totalOffsetY = scrollView.contentInset.top + offset;
    CGFloat offsetWidth = totalOffsetY * 2.f;
    
    if (totalOffsetY < 0) {
        _headerView.frame = CGRectMake(offsetWidth/2, offset, self.view.width - offsetWidth, NHeaderHeight- totalOffsetY);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.waveView wave];
//    });
}

@end
